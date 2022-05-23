from itertools import product

def format_value_in_name(value):
    if type(value) is int and value < 0:
        return f"Neg{abs(value)}"
    elif isinstance(value, float):
        if int(value) != value:
            raise NotImplementedError

        value = int(value)

        return f"Neg{abs(value)}" if value < 0 else repr(value)

    return repr(value)


def iter_value_markers(values, placeholders='XYZWABCDEF'):
    for value, placeholder in zip(values, placeholders):
        if value is not None:
            yield format_value_in_name(value)
        else:
            yield placeholder


def get_behavior_name(prefix, types, values):
    type_signature = '_'.join(t + id_ for t, id_ in zip(['' if t == "unknown" else t for t in types], iter_value_markers(values)))
    return f"{prefix}_{type_signature}"


def type_name_of_value(val):
    if type(val) is int:
        return 'sint' # We assume behaviors for a specific int is only generated for fixnums
    else:
        return type(val).__name__


class Specializations:
    def __init__(self, module, function, types, prefix, as_test):
        self.module = module
        self.function = function
        self.values_or_types = [ts if isinstance(ts, (list, tuple)) else [ts] for ts in types]
        if prefix is None:
            if as_test:
                self.prefix = f"py_test_{function}" if prefix is None else prefix
            else:
                self.prefix = f"py_{function}" if prefix is None else prefix
        else:
            self.prefix = prefix
        self.as_test = as_test

    def __iter__(self):
        prefix = self.prefix

        for type_combination in product(*self.values_or_types):
            types = [tp if isinstance(tp, str) else type_name_of_value(tp) for tp in type_combination]
            values = [None if isinstance(tp, str) else tp for tp in type_combination]

            yield get_behavior_name(prefix, types, values), types, values


def maker_specializations_adder(module_name, lst):
    def add_specializations(name, types, prefix=None, as_test=False):
        lst.append(Specializations(module_name, name, types, prefix, as_test))
    return add_specializations
