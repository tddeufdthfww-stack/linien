"""Copy the existing ya and signed-offset FF sum on their original clock edge."""
from migen import Signal

def same_edge_common(module,dy,pre_offset,width,shift):
    assert len(pre_offset)==width and len(dy)-shift==width
    # CSRStorage is unsigned. Reinterpret its W-bit encoding before widening.
    signed_offset = Signal((width,True))
    common = Signal((width+4,True))
    module.comb += signed_offset.eq(pre_offset)
    module.sync += common.eq((dy >> shift)+signed_offset)
    return common
