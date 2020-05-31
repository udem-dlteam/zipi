# Compiler Intrinsics

## `define_semantics`

Notify the compiler to treat the decorated function as a semantic, not as a Python function.

## `use_static_builtins`

Notify the compiler that the decorated function can be compiled with the assumptions that builtin functions are never renamed or shadowed.

## `no_dict_scope`

Notify the compiler that the decorated function canbe compiled with the assumption there will be no call to `globals()`, `locals()` or `vars()`.

## `class_getattr`

A callable intrinsic function which has a similar behaviour to calling `getattr(obj.__class__, attr, absent)`.

## `absent`

A special value returned as a sentinel by `class_getattr` when no attribute was found. This is not a Python object and should be handled carefully. Use `x is absent` is the only safe operation on this value.
