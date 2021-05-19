import _time
import math

def asctime(t = None):
    raise NotImplementedError("time.asctime(t) not implemented")

def pthread_getcpuclockid(thread_id):
    raise NotImplementedError("time.pthread_getcpuclockid(thread_id) not implemented")

def clock_getres(clk_id):
    return _time.clock_getres(clk_id)

def clock_gettime(clk_id):
    return _time.clock_gettime(clk_id)

def clock_gettime_ns(clk_id):
    return math.floor(clock_gettime(clk_id) * 1e9)

def clock_settime(clk_id, time):
    raise NotImplementedError("time.clock_settime(clk_id, time) not implemented")

def clock_settime_ns(clk_id, time):
    raise NotImplementedError("time.clock_settime_ns(clk_id, time) not implemented")

def ctime(secs = None):
    raise NotImplementedError("time.ctime(secs = None) not implemented")

def get_clock_info(name):
    raise NotImplementedError("time.get_clock_info(name) not implemented")

def gmtime(secs = None):
    raise NotImplementedError("time.gmtime(secs = None) not implemented")

def localtime(secs = None):
    raise NotImplementedError("time.localtime(secs = None) not implemented")

def mktime(t):
    raise NotImplementedError("time.mktime(t) not implemented")

def monotonic():
    return _time.monotonic()

def monotonic_ns():
    return math.floor(monotonic() * 1e9)

def perf_counter():
    return _time.perf_counter()

def perf_counter_ns():
    return math.floor(perf_counter() * 1e9)

def process_time():
    return _time.process_time()

def process_time_ns():
    return math.floor(process_time() * 1e9)

def sleep(secs):
    _time.sleep(secs)

def strftime(format, t = None):
    raise NotImplementedError("time.strftime(format, t) not implemented")

def strptime(string, format = None):
    raise NotImplementedError("time.strptime(string, format) not implemented")

class struct_time:
    pass

def time():
    return _time.time()

def time_ns():
    return math.floor(time() * 1e9)

def thread_time():
    return _time.thread_time()

def thread_time_ns():
    return math.floor(thread_time() * 1e9)

def tzset():
    raise NotImplementedError("time.tzset() not implemented")

CLOCK_REALTIME = 0

altzone = 14400  # TODO
daylight = 1  # TODO
timezone = 18000  # TODO
tzname = ('EST', 'EDT')  # TODO
