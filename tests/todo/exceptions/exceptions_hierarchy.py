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
