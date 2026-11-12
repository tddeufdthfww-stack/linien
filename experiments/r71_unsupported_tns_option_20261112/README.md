# R71 v1 tool-option failure

Vivado2020.1 rejected -tns_cleanup: it is available only with SLR-crossing optimization (UltraScale/UltraScale+). Zynq7020 is not applicable. This was a recipe error; no physical optimization or route result was produced. Input R70 DCP SHA unchanged. No FPGA logical source changed. Corrected v2 removes the unsupported option and keeps placement/routing/path-group selection, with a new output directory. Original failed command/source/metadata/logs retained.
