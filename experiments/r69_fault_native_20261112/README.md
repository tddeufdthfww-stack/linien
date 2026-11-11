# R69 actual fault contracts

Six original contracts x4 asynchronous phases PASS on candidate, with modes0/1/2/3/5 expected-failure evidence against frozen actual R68. Normal destination ERR keeps valid data and passes both.

Two extra pending-pulse/immediate-cancel-resume contracts x4 phases PASS. Both fail the same expected replay assertion on legacy R68. In mode7 the stopped destination resumes100ps after the local timeout-counter MSB rises; destination ready must gate the old request before source synchronous controls clear. This does not prove analog metastability or undo a write already committed before cancellation.

Actual RootModule elaborated object identity and instance abort/reset wiring PASS. Fixed test mimics that actual connection; unit test unconnected output would not suffice.

No FPGA bitstream or hardware action. Fresh full regression and actual synth/route remain separate.
