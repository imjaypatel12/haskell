{- install package arithmoi; 
   isSquare function from this package gives the best time -}
import Math.NumberTheory.Powers.Squares
-- 0.17 s

{- Method A
   generates a list of squares -}
squares2 :: [Integer]
squares2 = [d*d | d <- [1, 2 .. ]]

{- dropWhile starts a list from the first element that is not less than the given
   input n, and then the head of this list is checked wether it is n or not -}
isASquare2 n = n == head (dropWhile (<n) squares2)
-- 0.68 s

{- Method B; Dr Abbott's method; best after the arithmoi lib's function
   A simple mathematical check for a perfect square -}
iSqrt :: Integer -> Integer
iSqrt n = round (sqrt (fromIntegral n))

isASquare :: Integer -> Bool
isASquare n = (iSqrt n) ^ 2 == n
-- 0.39

{- Method C
   includes an initial screen i.e. prime always ends with [0,1,4,5,6,9] --}
lastDigit :: Integer -> Integer
lastDigit num | num < 0 = ((-1) * num) `rem` 10 | otherwise = num `rem` 10

isASquare3 :: Integer -> Bool
isASquare3 n | lastDigit n `elem` [0, 1, 4, 5, 6, 9] = isASquare n | otherwise = False
-- 0.61

oddsFrom3 :: [Integer]
oddsFrom3 = [3, 5 .. ]

{- generate prime numbers recursively; checks for all odd numbers that if there
   exists a number that is less than or equals to the sqrt of the current odd number.
   If yes, current odd number is prime. --}
smallPrimeDivisors :: Integer -> [Integer]
smallPrimeDivisors n = [d | d <- takeWhile (\x -> x^2 <= n) primes, n `mod` d == 0]

primes :: [Integer]
primes = 2 : [n | n <- oddsFrom3, null (smallPrimeDivisors n)]

{- evaluates the mod operation for a given input against all the previous primes
   this evaluation is limited till the sqrt(n) as, for any number N, there exists
   a factor f1 that is <= sqrt(N).
   This optimization grately improves the primality test -}
isPrime :: Integer -> Bool
isPrime n = null [p | p <- takeWhile(<= iSqrt n) primes, n `mod` p == 0]

-- generates a list of composite numbers. composites are the odd numbers (excuding 1) that are not prime.
oddComposites :: [Integer]
oddComposites = filter(\x-> not(isPrime x)) oddsFrom3

{- Goldbach’s-other-conjecture problem; finds composites that does not follow:
   "Every odd composite number can be expressed as the sum of a prime and twice a square."
   Use different impl of isASquare to check various methods. Use * isSquare * for arithmoi lib -}
goldbachExceptions :: [Integer]
goldbachExceptions = [g | g <- oddComposites, null [p | p <- takeWhile(<g) primes, isASquare ((g-p) `div` 2)] ]
