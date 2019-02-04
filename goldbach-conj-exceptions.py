from itertools import count
from time import time
import math

primes = [2, 3]


def isPrime(n):
    (limit, i) = (math.sqrt(n), 0)
    while getPrime(i) <= limit:
        if n % getPrime(i) == 0:
            return False
        i += 1
    else:
        return True


def getPrime(index=0):
    if index < len(primes):
        return primes[index]
    else:
        for odd in count(getPrime(index-1) + 2, 2):
            if isPrime(odd):
                primes.append(odd)
                return primes[index]


def compositeOdds():
    for odd in count(3, 2):
        if not isPrime(odd):
            yield odd


def isASquare(n):
    return n**0.5 == int(n**0.5)


def isExceptionalComp(comp):
    i = 0
    while(comp > getPrime(i)):
        if isASquare((comp - getPrime(i))/2):
            return False
        i += 1
    return True


def getGoldbackConjException():
    for comp in compositeOdds():
        if isExceptionalComp(comp):
            yield comp


def getNGoldbackConjException(n):
    g = getGoldbackConjException()
    for i in range(n):
        print(next(g))


start = time()
getNGoldbackConjException(2)
end = time()
print("Time:", end-start)
