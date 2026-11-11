# R66 fresh functional and physical evidence

Input decd142b1f1f98f736efc15ce7861a3bc541d71e, full functional and generate/synth/route manifests share identical raw input SHA256 and record no input changes. Both stage flows completed. Actual routed setup FAIL; do not deploy.

Diagnostic R65 snapshots are supporting evidence, not R66 route results. v1 failed report_timing option syntax; v2 fixed syntax but CLK-min included an unreachable ODDR C-rising->Q-rising arc (D1=0/D2=1). v3 selects actual C-falling launch for clock Q-rise in diagnostic reports without disabling/cutting paths; actual preceding-WRT CLK-min is +.644ns. SEL min=-.883 and CLK-before-WRT=-.829 remain necessary-model failures. No added diagnostic constraints were saved to a candidate DCP. Pulse-width/PCB constraints remain open. IO scan uses only legal4/8/12/16 settings and selects no source change.

The functional log stage name r65_analog is a retained LABEL; its actual command/marker is tools/check_r66_analog.py/R66_ANALOG_SUITE_PASS. See r65_analog.json and stdout. No old analog test was silently reused.
