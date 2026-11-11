# R68 native functional and actual PLL evidence

Four envelope cases and exact49-bit golden comparison PASS. Actual old/new CRG+PLL+analog UNISIM comparison PASS in two locked/reset-released epochs; unqualified unlocked startup is not compared by this second fixture (startup is compared by the separate four-envelope test).

Rejected fixture v1 incorrectly compared the PAD edge to the ideal PLL C-source phase, ignoring native UNISIM ODDR propagation (observed100ps). It failed CLK phase delta1.600 vs source phase1.500. Correct fixture checks the actual C source at exact1.500/2.000ns and retains the strict49-bit new/old pad comparison, with no tolerance relaxation in the pad assertion. Source, generated RTL, SV and failure logs retained. Preliminary script preparation/string-quoting errors were tooling failures, corrected before physical input; they are not a DUT PASS or a DUT regression conclusion.

No native result proves PVT/PCB/jitter/metastability. Actual postroute results are separate.
