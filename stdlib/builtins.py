# ==============================================================================
# Builtins
# ==============================================================================

__import__ = __base___import__

abs = __base_abs

all = __base_all

any = __base_any

ascii = __base_ascii

bin = __base_bin

bool = __base_bool

breakpoint = __base_breakpoint

bytearray = __base_bytearray

bytes = __base_bytes

callable = __base_callable

chr = __base_chr

classmethod = __base_classmethod

compile = __base_compile

complex = __base_complex

delattr = __base_delattr

dict = __base_dict

dir = __base_dir

divmod = __base_divmod

enumerate = __base_enumerate

eval = __base_eval

exec = __base_exec

filter = __base_filter

float = __base_float

format = __base_format

frozenset = __base_frozenset

getattr = __base_getattr

globals = __base_globals

hasattr = __base_hasattr

hash = __base_hash

help = __base_help

hex = __base_hex

id = __base_id

input = __base_input

int = __base_int

isinstance = __base_isinstance

issubclass = __base_issubclass

iter = __base_iter

len = __base_len

list = __base_list

locals = __base_locals

map = __base_map

max = __base_max

memoryview = __base_memoryview

min = __base_min

next = __base_next

object = __base_object

oct = __base_oct

open = __base_open

ord = __base_ord

pow = __base_pow

print = __base_print

property = __base_property

class range_iterator:
    def __init__(self, start, stop, step, /):
        self.start = start
        self.stop = stop
        self.step = step

    def __iter__(self, /):
        return self

    def __next__(self, /):
        start = self.start
        stop = self.stop
        step = self.step

        if step < 0:
            if start > stop:
                self.start = start + step
                return start
        else:
            if start < stop:
                self.start = start + step
                return start
        raise StopIteration

class range:
    def __init__(self, arg1, arg2=_absent, arg3=_absent, /):
        if arg3 is not _absent:
            self.start = arg1
            self.stop = arg2
            self.step =  arg3
        elif arg2 is not _absent:
            self.start = arg1
            self.stop = arg2
            self.step = 1
        else:
            self.start = 0
            self.stop = arg1
            self.step = 1

    def __len__(self, /):
        return (self.stop - self.start) // self.step

    def __contains__(self, item, /):
        start = self.start
        stop = self.stop
        step = self.step

        if self.step < 0:
            if stop >= item or item > start:
                return False
        else:
            if start > item or item >= stop:
                return False

        return (item - start) % step == 0

    def __iter__(self, /):
        return range_iterator(self.start, self.stop, self.step)

repr = __base_repr

reversed = __base_reversed

round = __base_round

set = __base_set

setattr = __base_setattr

slice = __base_slice

sorted = __base_sorted

staticmethod = __base_staticmethod

str = __base_str

sum = __base_sum

super = __base_super

tuple = __base_tuple

type = __base_type

vars = __base_vars

zip = __base_zip

# ==============================================================================
# Singletons
# ==============================================================================

NotImplemented = NotImplemented

# ==============================================================================
# Exceptions
# ==============================================================================

# Passes BaseException from pre-bootstrap globals to current globals
BaseException = BaseException

class Exception(BaseException):
    pass


class GeneratorExit(BaseException):
    pass


class KeyboardInterrupt(BaseException):
    pass


class SystemExit(BaseException):
    pass


class ArithmeticError(Exception):
    pass


class AssertionError(Exception):
    pass


class AttributeError(Exception):
    pass


class BufferError(Exception):
    pass


class EOFError(Exception):
    pass


class ImportError(Exception):
    pass


class LookupError(Exception):
    pass


class MemoryError(Exception):
    pass


class NameError(Exception):
    pass


class EnvironmentError(Exception):
    pass


class IOError(Exception):
    pass


class OSError(Exception):
    pass


class WindowsError(Exception):
    pass


class ReferenceError(Exception):
    pass


class RuntimeError(Exception):
    pass


class StopAsyncIteration(Exception):
    pass


class StopIteration(Exception):
    pass


class SyntaxError(Exception):
    pass


class SystemError(Exception):
    pass


class TypeError(Exception):
    pass


class ValueError(Exception):
    pass


class Warning(Exception):
    pass


class FloatingPointError(ArithmeticError):
    pass


class OverflowError(ArithmeticError):
    pass


class ZeroDivisionError(ArithmeticError):
    pass


class ModuleNotFoundError(ImportError):
    pass


class IndexError(LookupError):
    pass


class KeyError(LookupError):
    pass


class UnboundLocalError(NameError):
    pass


class BlockingIOError(OSError):
    pass


class ChildProcessError(OSError):
    pass


class ConnectionError(OSError):
    pass


class FileExistsError(OSError):
    pass


class FileNotFoundError(OSError):
    pass


class InterruptedError(OSError):
    pass


class IsADirectoryError(OSError):
    pass


class NotADirectoryError(OSError):
    pass


class PermissionError(OSError):
    pass


class ProcessLookupError(OSError):
    pass


class TimeoutError(OSError):
    pass


class NotImplementedError(RuntimeError):
    pass


class RecursionError(RuntimeError):
    pass


class IndentationError(SyntaxError):
    pass


class UnicodeError(ValueError):
    pass


class BytesWarning(Warning):
    pass


class DeprecationWarning(Warning):
    pass


class FutureWarning(Warning):
    pass


class ImportWarning(Warning):
    pass


class PendingDeprecationWarning(Warning):
    pass


class ResourceWarning(Warning):
    pass


class RuntimeWarning(Warning):
    pass


class SyntaxWarning(Warning):
    pass


class UnicodeWarning(Warning):
    pass


class UserWarning(Warning):
    pass


class BrokenPipeError(ConnectionError):
    pass


class ConnectionAbortedError(ConnectionError):
    pass


class ConnectionRefusedError(ConnectionError):
    pass


class ConnectionResetError(ConnectionError):
    pass


class TabError(IndentationError):
    pass


class UnicodeDecodeError(UnicodeError):
    pass


class UnicodeEncodeError(UnicodeError):
    pass


class UnicodeTranslateError(UnicodeError):
    pass
