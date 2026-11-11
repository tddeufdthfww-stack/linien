# Negative-control oracle setup failure, not a hardware failure

The corrected-clock fixture passed four declared clock/data envelope cases.
Its zero-clock-delay negative control also passed unexpectedly, and the runner
failed because it required an explicit word-index failure in that control.
Root cause: the scoreboard read the testbench word variable at the same edge,
before that variable was updated 10 ps later. At PHI=0 it therefore expected the
previous word, masking the exact stale-word condition the control must catch.

The next fixture derives the source word index independently from simulation
time and the declared clock phase, including the final held-word condition.
No production hardware or paired-output assertions are changed. Four positive
cases and the required negative-control failure must all be rerun in a new
directory; these old logs/source are preserved and are not relabelled PASS.
