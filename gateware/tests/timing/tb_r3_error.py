"""Independent modular oracle for mixed-sign error and parallel block borrow."""
import random

from migen.sim import run_simulation

from gateware.logic.pid import PID


def block_subtract(a, b, width, chunk):
    generate, propagate, result = [], [], 0
    for lo in range(0, width, chunk):
        n = min(chunk, width-lo)
        mask = (1 << n)-1
        ai, bi = (a >> lo) & mask, (b >> lo) & mask
        borrow = any(generate[j] and all(propagate[j+1:])
                     for j in range(len(generate)))
        result |= ((ai-bi-int(borrow)) & mask) << lo
        generate.append(ai < bi)
        propagate.append(ai == bi)
    return result


def check_integer_identity():
    for a in range(256):
        for b in range(256):
            assert block_subtract(a, b, 8, 3) == (a-b) & 255
    print('R3_BORROW_EXHAUSTIVE_8BIT_PASS cases=65536', flush=True)


def check_error(width):
    dut = PID(width=width, error_chunks=True)
    rng = random.Random(303000+width)
    modulus = 1 << (width+1)
    mask = (1 << width)-1
    # Values immediately around every 6-bit boundary, full borrow propagation,
    # all sign combinations, unsigned setpoint MSB, and truncation extremes.
    special = {0, 1, mask, mask-1, 1 << (width-1), (1 << (width-1))-1}
    for bit in range(6, width, 6):
        special.update({(1 << bit)-1, 1 << bit, (1 << bit)+1,
                        mask ^ ((1 << bit)-1)})
    vectors = [(a, b) for a in sorted(special) for b in sorted(special)]
    vectors += [(rng.getrandbits(width), rng.getrandbits(width))
                for _ in range(5000)]

    def bench():
        for step, (raw_input, setpoint) in enumerate(vectors):
            signed_input = raw_input if raw_input < 1 << (width-1) else raw_input-(1 << width)
            bits = (signed_input-setpoint) % modulus
            expected = bits if bits < modulus//2 else bits-modulus
            assert block_subtract(signed_input % modulus, setpoint, width+1, 6) == bits
            for running in (1, 0):
                yield dut.input.eq(raw_input)
                yield dut.setpoint.storage.eq(setpoint)
                yield dut.running.eq(running)
                yield
                actual = (yield dut.error)
                assert actual == (expected if running else 0), (width, step, raw_input, setpoint, running, actual, expected)
        print('R3_ERROR_MODULAR_ORACLE_PASS width=%d vectors=%d running_cases=2' % (width, len(vectors)), flush=True)
    run_simulation(dut, bench(), clocks={'sys': 8})


def main():
    check_integer_identity()
    check_error(14)
    check_error(25)
    print('R3_ERROR_SUITE_PASS', flush=True)


if __name__ == '__main__':
    main()
