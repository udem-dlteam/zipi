from .common import *


__all__ = ["cvt_slice", "cvt_slice_seq"]


def cvt_slice_seq(slice_seq):
    return cvt_seq(cvt_slice, slice_seq)


def cvt_slice(slice):
    if isinstance(slice, AST.Slice):
        return ('(' + node_kind(slice, 'Slice') +
                ' ' + cvt_expr_opt(slice.lower) +
                ' ' + cvt_expr_opt(slice.upper) +
                ' ' + cvt_expr_opt(slice.step) +
                ')')
    elif isinstance(slice, AST.ExtSlice):
        return ('(' + node_kind(slice, 'Tuple') +
                ' ' + cvt_slice_seq(slice.dims) +
                ' ' + cvt_expr_context(ast.Load()) +
                ')')
    elif isinstance(slice, AST.Index):
        return cvt_expr(slice.value)
    else:
        raise TypeError(f'cvt_slice expected a slice AST, not {type(slice).__name__}')
