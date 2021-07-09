def get_type_name(obj):
    return type(obj).__name__


def get_type_alias(type_name):
    return "int" if type_name in int_specialized_types else type_name


def get_behavior_name(prefix, types):
    type_signature = '_'.join(t + id_ for t, id_ in zip(['' if t == "unknown" else t for t in types], 'XYZWABCDEF'))
    return f"{prefix}_{type_signature}"

known_types = ["int", "float", "bool", "str", "function"]
int_specialized_types = ['sint', 'bint']
known_types += int_specialized_types
