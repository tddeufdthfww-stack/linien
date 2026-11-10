"""Same-edge current/next/zero CSR cohort; no extra instruction/feedback edge."""
from migen import Array, Case, Constant, If, Signal


def next_instruction_word(module, values, index):
    """Constant-rotated table: wrap(index+1), including old X/Z default31."""
    assert len(values) == 1 << len(index)
    result = Signal.like(values[0])
    cases = {i: result.eq(values[(i + 1) % len(values)]) for i in range(len(values))}
    cases['default'] = result.eq(values[-1])
    module.comb += Case(index, cases)
    return result


def prefetch_instruction(module, peaks, waits, index, start, advance):
    assert len(peaks) == len(waits) == (1 << len(index))
    width, wait_width = peaks[0].size, waits[0].size
    assert all(p.size == width for p in peaks)
    assert all(w.size == wait_width for w in waits)
    choice = Signal(2, name='prefetch_choice')
    module.sync += If(start, choice.eq(2)).Elif(advance, choice.eq(1)).Else(choice.eq(0))
    slots = []
    for label, address in [('current', index), ('next', index), ('zero', Constant(0, len(index)))]:
        raw = Signal((width, True), name='prefetch_' + label + '_signed')
        absolute = Signal.like(raw)
        extended = Signal((width + 1, True))
        magnitude = Signal((width, True), name='prefetch_' + label + '_magnitude')
        negative = Signal((width + 1, True), name='prefetch_' + label + '_negative')
        positive = Signal(name='prefetch_' + label + '_positive')
        wait = Signal(wait_width, name='prefetch_' + label + '_wait')
        peak_word = (next_instruction_word(module, [p.storage for p in peaks], index)
                     if label == 'next' else Array([p.storage for p in peaks])[address])
        wait_word = (next_instruction_word(module, [w.storage for w in waits], index)
                     if label == 'next' else Array([w.storage for w in waits])[address])
        module.comb += [raw.eq(peak_word),
                        If(raw >= 0, absolute.eq(raw)).Else(absolute.eq(-raw)),
                        extended.eq(absolute)]
        module.sync += [magnitude.eq(absolute), negative.eq(-extended),
                        positive.eq(raw > 0), wait.eq(wait_word)]
        slots.append(dict(magnitude=magnitude, negative=negative, positive=positive, wait=wait))
    selected = {}
    for name in slots[0]:
        value = Signal.like(slots[0][name], name='prefetch_selected_' + name)
        module.comb += value.eq(Array([slot[name] for slot in slots])[choice])
        selected[name] = value
    selected['choice'] = choice
    return selected
