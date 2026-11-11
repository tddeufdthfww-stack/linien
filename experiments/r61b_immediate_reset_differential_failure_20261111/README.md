# R61b strict immediate-reset differential: FAIL retained

Input code: 45161240d27b86d2c037e96e72c9b1446a381af0. Full functional flow
stopped in scope_factor_cache; synthesis and route were NOT RUN.
The original strict comparison against the R38 bridge fails at time 80056 ns
on the first transaction immediately after coordinated reset release.
R61 deliberately adds two local edges of bridge reset recovery; old parity
reset behaviour is not temporally equivalent. The original failing fixture,
complete stage logs, full input manifest and matching raw source are retained.

A diagnostic changes only the second coordinated-release stimulus by waiting
three SYS negedges, leaving all every-edge strict assertions enabled. Phase 0
then passes 28781 ADC cycles, 2036 bus transactions and 210 known memory reads.
This is NOT a claim that the original strict test passed or that independent
reset/clock stop/metastability/physical CDC is proved. Dedicated R61 reset and
error tests cover recovery requests separately. Full recovery-contract suites
and a fresh full build must be evaluated independently.
