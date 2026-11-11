# Native fixture clock model failure, not a hardware equivalence failure

The first R63 fixture used delayed continuous clock assignments. In Verilog
these have inertial pulse semantics. At PHI=3.5 ns the 250 MHz source pulses
(2 ns half period) were suppressed. The existing paired_checks coverage
assertion caught zero fast-clock checks and failed; compile/elaborate passed.
Cases PHI=1.5/2 ns passed before this failure. Source, fixture and native logs
are retained here. No hardware source or numerical/assertion checks changed.

The corrected fixture uses phase-started free-running oscillators instead of
inertially delayed clocks. It retains paired_checks>130000 and all original
word-index, reset, complete range and strict settled-pair assertions. A fresh
output directory is required for the corrected run; old FAIL is not overwritten.
