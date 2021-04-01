def patch_module(module, pysexp__):
    for name in pysexp__.__all__:
        setattr(module, name, getattr(pysexp__, name))


def patch_pysexp_module_for_version(module, version):
    major_minor = version[:2]

    if major_minor == (3, 8):
        from . import pysexp38
        patch_module(module, pysexp38)

    elif major_minor == (3, 9):
        from . import pysexp39
        patch_module(module, pysexp39)

    else:
        raise NotImplementedError(f"unsupported python version: {version}")
