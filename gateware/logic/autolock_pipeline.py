"""One-clock robust decision transport; original sample throughput retained."""
from linien_common.common import AUTOLOCK_MAX_N_INSTRUCTIONS
from migen import Array,If,Signal,bits_for
from .autolock import RobustAutolock,ROBUST_AUTOLOCK_FPGA_DELAY
from .abs_threshold import signed_abs_over_threshold
from .instruction_prefetch import prefetch_instruction

class PipelinedRobustAutolock(RobustAutolock):
    def __init__(self, width=14, N_points=16383, max_delay=16383):
        self.init_submodules(width, N_points, max_delay)
        peak_height_bit, x_data_length_bit = self.init_csr(N_points)
        self.init_inout_signals(width)

        # One sys-clock decision transport. No register in the ADC->DAC data path.
        at_start_s1,request_s1,writing_s1,sweep_up_s1 = Signal(),Signal(),Signal(),Signal()
        sum_diff_s1 = Signal.like(self.sum_diff_calculator.output)
        n_instructions_s1 = Signal(self.N_instructions.size)
        final_wait_s1 = Signal(self.final_wait_time.size)
        current_peak_positive = Signal()
        self.sync += [at_start_s1.eq(self.at_start),request_s1.eq(self.request_lock),
            writing_s1.eq(self.writing_data_now),sweep_up_s1.eq(self.sweep_up),
            sum_diff_s1.eq(self.sum_diff_calculator.output),
            n_instructions_s1.eq(self.N_instructions.storage),
            final_wait_s1.eq(self.final_wait_time.storage)]
        self.current_instruction_idx = Signal(bits_for(AUTOLOCK_MAX_N_INSTRUCTIONS - 1))
        advance = Signal(name='prefetch_advance')
        prefetched = prefetch_instruction(self,self.peak_heights,self.wait_for,
            self.current_instruction_idx,at_start_s1,advance)
        self._instruction_prefetch = prefetched

        # is the autolock actively trying to detect peaks? This is set to true
        # if lock is requested and once the sweep is at start
        watching = Signal()

        # the following signals are property of the peak that the autolock is trying to
        # detect right now
        current_peak_height = Signal((peak_height_bit, True))
        abs_current_peak_height = Signal.like(current_peak_height)
        negative_current_peak_height = Signal((peak_height_bit+1,True))
        current_wait_for = Signal(x_data_length_bit)
        self.comb += [
            current_wait_for.eq(prefetched['wait']),
        ]

        # after detecting the last peak, how many cycles have passed?
        waited_for = Signal(bits_for(N_points))
        # after all peaks have been detected, how many cycles have passed?
        final_waited_for = Signal(bits_for(N_points))

        # this is the signal that's used for detecting peaks
        sum_diff = Signal((len(self.sum_diff_calculator.output), True))
        abs_sum_diff = Signal.like(sum_diff)
        self.comb += [
            self.sum_diff_calculator.writing_data_now.eq(self.writing_data_now),
            self.sum_diff_calculator.restart.eq(self.at_start),
            self.sum_diff_calculator.input.eq(self.input),
            self.sum_diff_calculator.delay_value.eq(self.time_scale.storage),
            sum_diff.eq(sum_diff_s1),
        ]

        # has this signal at the moment the same sign as the peak we are looking for?
        sign_equal = Signal()
        # is this signal higher than the peak we are looking for?
        over_threshold = Signal()
        # since detecting the previous peak, has enough time passed?
        waited_long_enough = Signal()
        # have we detected all peaks (and can turn on the lock)?
        all_instructions_triggered = Signal()

        self.comb += advance.eq(writing_s1 & ~all_instructions_triggered & sweep_up_s1
            & watching & sign_equal & over_threshold & waited_long_enough)

        self.comb += [
            sign_equal.eq((sum_diff > 0) == current_peak_positive),
            If(sum_diff >= 0, abs_sum_diff.eq(sum_diff)).Else(
                abs_sum_diff.eq(-1 * sum_diff)
            ),
            abs_current_peak_height.eq(prefetched['magnitude']),
            current_peak_positive.eq(prefetched['positive']),
            negative_current_peak_height.eq(prefetched['negative']),
            waited_long_enough.eq(waited_for > current_wait_for),
            all_instructions_triggered.eq(
                self.current_instruction_idx >= n_instructions_s1
            ),
            self.turn_on_lock.eq(
                all_instructions_triggered
                & (final_waited_for >= final_wait_s1)
            ),
        ]

        signed_abs_over_threshold(self,sum_diff,abs_current_peak_height,negative_current_peak_height,over_threshold)

        self.sync += [
            If(
                at_start_s1,
                waited_for.eq(0),
                # fpga robust autolock algorithm registeres trigger events delayed.
                # Therefore, we give it a head start for `final_waited_for`
                final_waited_for.eq(ROBUST_AUTOLOCK_FPGA_DELAY),
                self.current_instruction_idx.eq(0),
                If(request_s1, watching.eq(1)).Else(watching.eq(0)),
            ).Else(
                # not at start
                If(
                    ~request_s1,
                    # disable `watching` if `request_lock` was disabled while  the sweep
                    # is running. This is important for slow scan speeds when disabling
                    # the autolock and enabling it again with different parameters. In
                    # this case we want to take care that we start watching at start.
                    watching.eq(0),
                ),
                If(
                    writing_s1 & ~all_instructions_triggered & sweep_up_s1,
                    If(
                        watching & sign_equal & over_threshold & waited_long_enough,
                        self.current_instruction_idx.eq(
                            self.current_instruction_idx + 1
                        ),
                        waited_for.eq(0),
                    ).Else(waited_for.eq(waited_for + 1)),
                ),
                If(
                    writing_s1 & all_instructions_triggered & sweep_up_s1,
                    final_waited_for.eq(final_waited_for + 1),
                ),
            ),
        ]

        self.signal_out = []
        self.signal_in = []
        self.state_out = [
            watching,
            self.turn_on_lock,
            sign_equal,
            over_threshold,
            waited_long_enough,
        ]
        self.state_in = []

