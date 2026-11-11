# R61 explicit reset recovery Scope functional regression: PASS

Original strict immediate-reset differential remains FAIL in the sibling archive.
The original three regression scripts, frozen references and four R61b hardware
files are unchanged. This run adds only three SYS negedge waits after the second
coordinated release; all old state/data/bus assertions stay active. Factor cache
and predecode also assert actual new src_ready/dst_ready at release recovery.

Factor-cache: phases 0/1/2/3 ns PASS; 2036 bus transactions per phase.
Predecode: phases 0/1/2/3 ns PASS; 1652 bus transactions per phase.
Average: full parent PASS; 652 bus transactions. Total 15404 transactions and
225588 ADC cycles across these nine parent simulations. Both scalar regressions
PASS at 161872 known vectors and 3000 X/Z cases each, as recorded in logs.

This checks steady-state functionality after the explicitly changed reset
contract. It does not prove independent reset/metastability/physical CDC, mapped
cycle equivalence, STA or hardware. Dedicated reset/error suites and a fresh full
implementation must pass separately. Commands, native logs, original/recovery
fixtures and their hashes are retained; Vivado binary build outputs are excluded.
