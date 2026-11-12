"""Exact first circular rotation for a zero-quadrature, headroom-extended ADC.

Compute +/- ADC before phase arrives; retain the original first state edge,
phase recurrence, guard bits and every later CORDIC stage.
"""
from migen import Mux, Signal
from .cordic import Cordic


class SpeculativeDemodCordic(Cordic):
    def __init__(self, source_x, source_phase, **kwargs):
        assert source_x.signed and kwargs['width'] == len(source_x) + 1
        assert len(source_phase) == kwargs.get('widthz', kwargs['width'])
        assert kwargs['eval_mode'] == 'pipelined'
        assert kwargs['cordic_mode'] == 'rotate' and kwargs['func_mode'] == 'circular'
        self._source_x, self._source_phase = source_x, source_phase
        self._source_guard = kwargs['guard']
        super().__init__(**kwargs)

    def _stage(self, xi, yi, zi, xo, yo, zo, i, ai):
        stmt = super()._stage(xi, yi, zi, xo, yo, zo, i, ai)
        if i == 0:
            positive, negative = Signal.like(xi), Signal.like(xi)
            self.comb += [positive.eq(self._source_x << self._source_guard),
                          negative.eq(-positive)]
            quadrant = self._source_phase[-2] ^ self._source_phase[-1]
            stmt[0] = xo.eq(Mux(quadrant, negative, positive))
            stmt[1] = yo.eq(Mux(self._source_phase[-1], negative, positive))
            # stmt[2] (phase) and the original sync edge remain untouched.
        return stmt
