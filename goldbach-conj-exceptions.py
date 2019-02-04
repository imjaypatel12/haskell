from itertools import count
from time import time
import math

primes = [2, 3]

def isPrime(n: int) -> bool:
    """
    Primality Check; checks for all the possible prime divisors of n till sqrt(n)
    """
    (limit, i) = (math.sqrt(n), 0)
    while getPrime(i) <= limit:
        if n % getPrime(i) == 0:
            return False
        i += 1
    else:
        return True


def getPrime(index: int = 0) -> int:
    """
    returns a prime number at index from the primes list; if not found, calculates
    recursively by checking every odds following the last known prime
    """
    if index < len(primes):
        return primes[index]
    else:
        for odd in count(getPrime(index-1) + 2, 2):
            if isPrime(odd):
                primes.append(odd)
                return primes[index]


def compositeOdds() -> int:
    """
    generates the composite odds sequentially using generator
    """
    for odd in count(3, 2):
        if not isPrime(odd):
            yield odd


def isASquare(n: int) -> bool:
    """
    a simple math check for if the given number is a perfect square or not
    """
    return n**0.5 == int(n**0.5)


def isExceptionalComp(comp: int) -> bool:
    """
    checks wether a given composite odd number is a exception to the Goldback's
    Conjecture: Every odd composite number can be expressed as the sum of a prime and
    twice a square.
    """
    i = 0
    while(comp > getPrime(i)):
        if isASquare((comp - getPrime(i))/2):
            return False
        i += 1
    return True


def getGoldbackConjException() -> int:
    """
    Generates all the exceptions to the Goldback's conjecture sequencially
    """
    for comp in compositeOdds():
        if isExceptionalComp(comp):
            yield comp


def getNGoldbackConjException(n: int):
    """
    returns n exceptions to the Goldback's conj
    """
    g = getGoldbackConjException()
    for i in range(n):
        print(next(g))


start = time()
getNGoldbackConjException(2)
end = time()
print("Time:", end-start)
