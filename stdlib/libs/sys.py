import _sys

abiflags = ''  # TODO

def addaudithook(hook):
    raise NotImplementedError("sys.addaudithook(hook) not implemented")

argv = _sys.argv
#argv = call_host("(lambda () (py-list-from-scheme (list->dynamic-vector (map (lambda (s) (py-str-from-scheme s)) (cons \"\" (cond-expand (gambit (cdr (command-line))) (bigloo (command-line))))))))")

def audit(event, *args):
    raise NotImplementedError("sys.audit(event, *args) not implemented")

base_exec_prefix = '/'  # TODO

base_prefix = '/'  # TODO

byteorder = 'little'  # TODO

builtin_module_names = _sys.builtin_module_names
#builtin_module_names = ()
('_sys', '_ast', '_codecs', '_collections', '_functools', '_imp', '_io', '_locale', '_operator', '_signal', '_sre', '_stat', '_string', '_symtable', '_thread', '_tracemalloc', '_warnings', '_weakref', 'atexit', 'builtins', 'errno', 'faulthandler', 'gc', 'itertools', 'marshal', 'posix', 'pwd', 'sys', 'time', 'xxsubtype')

def call_tracing(func, args):
    raise NotImplementedError("sys.call_tracing(func, args) not implemented")

copyright = 'Copyright'  # TODO

def _clear_type_cache():
    raise NotImplementedError("sys._clear_type_cache() not implemented")

def _current_frames():
    raise NotImplementedError("sys._current_frames() not implemented")

def breakpointhook(value):
    raise NotImplementedError("sys.breakpointhook(value) not implemented")

def _debugmallocstats():
    raise NotImplementedError("sys._debugmallocstats() not implemented")

def displayhook(value):
    raise NotImplementedError("sys.displayhook(value) not implemented")

dont_write_bytecode = False  # TODO

pycache_prefix = None  # TODO

def excepthook(type, value, traceback):
    raise NotImplementedError("sys.excepthook(type, value, traceback) not implemented")

def exc_info():
    raise NotImplementedError("sys.exc_info() not implemented")

exec_prefix = '/'  # TODO

executable = ''  # TODO

def exit(arg = 0):
    raise NotImplementedError("sys.exit(arg) not implemented")

flags = None  # TODO

float_info = None  # TODO

float_repr_style = 'short'  # TODO

def getallocatedblocks():
    raise NotImplementedError("sys.getallocatedblocks() not implemented")

def getdefaultencoding():
    raise NotImplementedError("sys.getdefaultencoding() not implemented")

def getdlopenflags():
    raise NotImplementedError("sys.getdlopenflags() not implemented")

def getfilesystemencoding():
    raise NotImplementedError("sys.getfilesystemencoding() not implemented")

def getfilesystemencodeerrors():
    raise NotImplementedError("sys.getfilesystemencodeerrors() not implemented")

def getrefcount(object):
    raise NotImplementedError("sys.getrefcount(object) not implemented")

def getrecursionlimit():
    return 99999999  # no limit

def getsizeof(object, default = None):
    raise NotImplementedError("sys.getsizeof(object, default) not implemented")

def getswitchinterval():
    raise NotImplementedError("sys.getswitchinterval() not implemented")

def _getframe(depth = 0):
    raise NotImplementedError("sys._getframe(depth) not implemented")

def getprofile():
    raise NotImplementedError("sys.getprofile() not implemented")

def gettrace():
    raise NotImplementedError("sys.gettrace() not implemented")

def get_asyncgen_hooks():
    raise NotImplementedError("sys.get_asyncgen_hooks() not implemented")

def get_coroutine_origin_tracking_depth():
    raise NotImplementedError("sys.get_coroutine_origin_tracking_depth() not implemented")

hash_info = None  # TODO

hexversion = 0  # TODO

implementation = None  # TODO

int_info = None  # TODO

def intern(string):
    raise NotImplementedError("sys.intern(string) not implemented")

def is_finalizing():
    raise NotImplementedError("sys.is_finalizing() not implemented")

maxsize = _sys.maxsize
#maxsize = call_host("(lambda () (py-int-from-scheme (cond-expand (gambit |##max-fixnum|) (bigloo (maxvalfx)))))")

maxunicode = 1114111

meta_path = []  # TODO

modules = {}  # TODO

path = _sys.path
#path = ['']

path_hooks = []  # TODO

path_importer_cache = {}  # TODO

platform = '?'  # TODO

platlibdir = '/'  # TODO

prefix = '/'  # TODO

ps1 = '>>> '
ps2 = '... '

def setdlopenflags(n):
    raise NotImplementedError("sys.setdlopenflags(n) not implemented")

def setprofile(profilefunc):
    raise NotImplementedError("sys.setprofile(profilefunc) not implemented")

def setrecursionlimit(limit):
    pass  # no limit

def setswitchinterval(interval):
    raise NotImplementedError("sys.setswitchinterval(interval) not implemented")

def settrace(tracefunc):
    raise NotImplementedError("sys.settrace(tracefunc) not implemented")

def set_asyncgen_hooks(firstiter, finalizer):
    raise NotImplementedError("sys.set_asyncgen_hooks(firstiter, finalizer) not implemented")

def set_coroutine_origin_tracking_depth(depth):
    raise NotImplementedError("sys.set_coroutine_origin_tracking_depth(depth) not implemented")

stdin = None  # TODO
stdout = None  # TODO
stderr = None  # TODO

thread_info = None  # TODO

tracebacklimit = 0  # TODO

def unraisablehook(unraisable, /):
    raise NotImplementedError("sys.unraisablehook(unraisable) not implemented")

version = ''  # TODO

api_version = ''  # TODO

version_info = None  # TODO

warnoptions = None  # TODO

_xoptions = {}  # TODO

__breakpointhook__ = breakpointhook
__displayhook__ = displayhook
__excepthook__ = excepthook
__unraisablehook__ = unraisablehook

__stdin__ = stdin  # TODO
__stdout__ = stdout  # TODO
__stderr__ = stderr  # TODO
