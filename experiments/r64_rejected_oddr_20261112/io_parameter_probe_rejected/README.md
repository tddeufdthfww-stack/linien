# Rejected diagnostic entry: unsupported DRIVE24

This in-memory IO characterization stopped when Vivado rejected DRIVE24 for
LVCMOS33 (legal values 4,8,12,16). No production source changed and no candidate
DCP was written. The input DCP SHA was verified unchanged. Partial rows were
not selected as an implementation. The generic result scope's restoration
wording describes the intended completed path: restoration was NOT reached
on this error; the temporary process memory was discarded when Vivado exited.
This is a diagnostic configuration failure, not a successful timing result.
