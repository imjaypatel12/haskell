from itertools import count
from time import time
import math

# v1
primes = [2, 3]
def getPrime(index=0):
    if index < len(primes):
        return primes[index]
    else:
        for odd in count(getPrime(index-1) + 2,2):
            flag = True
            for p in range(index):
                if odd % getPrime(p) == 0:
                    flag = False
                    break
            if flag:
                primes.append(odd)
                break
        return primes[index]

def isPrime(n):
    i = 0
    while getPrime(i) <= math.sqrt(n):
        if getPrime(i) == n: return True
        i+=1
    else:
        return getPrime(i) == n


# v2
primes2 = [2, 3]
def getPrime2(index=0):
    if index < len(primes2):
        return primes2[index]
    else:
        for odd in count(getPrime2(index-1) + 2,2):
            if isPrime2(odd):
                primes2.append(odd)
                break
        return primes2[index]

def isPrime2(n):
    """Returns True if n is prime."""
    if n in [2, 3]:
        return True
    if n % 2 == 0 or n % 3 ==0:
        return False

    i, w = 5, 2
    
    while i * i <= n:
        if n % i == 0:
            return False

        i += w
        w = 6 - w

    return True

# switch the impls
is_prime = isPrime2
get_prime = getPrime2

def getCompositeOdd():
    for odd in count(3,2):
        if not is_prime(odd):
            yield odd

def isASquare(n):
    return n**0.5 == int(n**0.5)

def isValidComp(comp):
    i = 0
    while(comp > get_prime(i)):
        if isASquare((comp - get_prime(i))/2): 
            return False
        i+=1
    return True

def getGoldbackConjException():
    for comp in getCompositeOdd():
        if isValidComp(comp):
            yield comp

def getNGoldbackConjException(n):
    g = getGoldbackConjException()
    for i in range(n):
        print(next(g))

start = time()
getNGoldbackConjException(2)
end = time()
print("Time:", end-start)
