# This uses a very simple linear congruential PRNG.

rand_seed = 1
rand_modulo     =   16777216
rand_multiplier = 1140671485
rand_increment  =   12820163

def seed(a=None, version=2):
    global rand_seed
    if not isinstance(a, int):
        a = 1
    rand_seed = a % rand_modulo

def getstate():
    raise NotImplementedError("random.getstate() not implemented")

def setstate(state):
    raise NotImplementedError("random.setstate(state) not implemented")

def randbytes(n):
    raise NotImplementedError("random.randbytes(n) not implemented")

def randrange(start, stop=None, step=None):
    global rand_seed
    if step is None:
        step = 1
    if stop is None:
        stop = start
        start = 0
    n = (stop - start) // step
    # use rejection method
    limit = (rand_modulo // n) * n
    while (True):
        rand_seed = (rand_seed * rand_multiplier + rand_increment) % rand_modulo
        if rand_seed < limit:
            return start + rand_seed % n * step

def randint(a, b):
    return randrange(a, b+1)

def getrandbits(k):
    raise NotImplementedError("random.getrandbits(k) not implemented")

def choice(seq):
    raise NotImplementedError("random.choice(seq) not implemented")

def shuffle(x, random=None):
    raise NotImplementedError("random.shuffle(x, random=None) not implemented")

def sample(population, k, *, counts=None):
    raise NotImplementedError("random.sample(population, k, *, counts=None) not implemented")

def random():
    return randrange(0, rand_modulo) / rand_modulo

def uniform(a, b):
    raise NotImplementedError("random.uniform(a, b) not implemented")

def triangular(low, high, mode):
    raise NotImplementedError("random.triangular(low, high, mode) not implemented")

def betavariate(alpha, beta):
    raise NotImplementedError("random.betavariate(alpha, beta) not implemented")

def expovariate(lambd):
    raise NotImplementedError("random.expovariate(lambd) not implemented")

def gammavariate(alpha, beta):
    raise NotImplementedError("random.gammavariate(alpha, beta) not implemented")

def gauss(mu, sigma):
    raise NotImplementedError("random.gauss(mu, sigma) not implemented")

def lognormvariate(mu, sigma):
    raise NotImplementedError("random.lognormvariate(mu, sigma) not implemented")

def normalvariate(mu, sigma):
    raise NotImplementedError("random.normalvariate(mu, sigma) not implemented")

def vonmisesvariate(mu, kappa):
    raise NotImplementedError("random.vonmisesvariate(mu, kappa) not implemented")

def weibullvariate(alpha, beta):
    raise NotImplementedError("random.weibullvariate(alpha, beta) not implemented")

class Random:

    def __init__(self, seed=None):
        raise NotImplementedError("random.Random class is not implemented")

class SystemRandom:

    def __init__(self, seed=None):
        raise NotImplementedError("random.SystemRandom class is not implemented")
