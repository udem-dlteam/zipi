## Compiler Intrinsics

### define_semantics

Tell the compiler to treat the decorated function as a semantic, not as a Python function.

### use_static_builtins

Tell the compiler that the decorated function can be compiled with the assumptions that builtin functions are never renamed or shadowed.

### no_dict_scope

Tell the compiler that the decorated function canbe compiled with the assumption there will be no call to globals(), locals() or vars().

### class_getattr

A callable intrinsic function which has a similar behaviour to calling ˋgetattr(obj.__class__, attr, absent)ˋ

### absent

A special value returned as a sentinel by ˋclass_getattrˋ when no attribute was found. This is not a Python object and should be handled carefully. Use ˋx is absentˋ is the only safe operation on this value.
