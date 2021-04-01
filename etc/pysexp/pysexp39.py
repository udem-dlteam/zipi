from .common import *


__all__ = ["cvt_slice"]


def cvt_slice(slice):
    if isinstance(slice, AST.Slice):
        return ('(' + node_kind(slice, 'Slice') +
                ' ' + cvt_expr_opt(slice.lower) +
                ' ' + cvt_expr_opt(slice.upper) +
                ' ' + cvt_expr_opt(slice.step) +
                ')')
    else:
        return cvt_expr(slice)
