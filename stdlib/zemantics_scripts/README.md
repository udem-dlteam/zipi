# Semantics manager

```
usage: manager.py [-h] {update,save,init,list} ...

Manage Python semantics file

positional arguments:
  {update,save,init,list}
```

## update

```
usage: manager.py update [-h] path

Update a semantics file from template

positional arguments:
  path
```

## save

```
usage: manager.py save [-h] path

Save a semantics file in history

positional arguments:
  path
```

## init

```
Initialize a semantics file from templates

positional arguments:
  path
```

## list

```
usage: manager.py list [-h]

Print a list of previous semantics version
```

# Compiler Intrinsics

## `define_semantics`

Notify the compiler that the decorated function should be treated as a semantics definition, not as a function definition.

## `use_static_builtins`

Notify the compiler that the decorated function can be compiled with the assumptions that builtin functions are never renamed or shadowed.

## `use_simple_scoping`

Notify the compiler that the decorated function can be compiled with the assumptions that there will be no call to `globals()`, `locals()`, `vars()`, `exec()` or `eval()`.

## `class_getattr`

A callable intrinsic function which has a similar behaviour to calling `getattr(obj.__class__, attr, absent)`.

## `absent`

A special value returned as a sentinel by `class_getattr` when no attribute was found. This is not a Python object and should be handled carefully. Usage of `x is absent` is the only safe operation on this value.
