"""Bit-preserving lookup for a valid parallel one-hot instruction state."""
from migen import Replicate, Signal


def onehot_select_word(module, entries, onehot):
    assert entries and len(entries) == len(onehot)
    width = len(entries[0])
    assert all(len(entry) == width for entry in entries)
    selected = Signal.like(entries[0])
    word = 0
    for i, entry in enumerate(entries):
        word = word | (entry & Replicate(onehot[i], width))
    module.comb += selected.eq(word)
    return selected
