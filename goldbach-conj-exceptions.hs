import Math.NumberTheory.Powers.Squares
-- 0.27

squares = map (\x -> x*x) [1 .. ]
isASquare1 n = n == head (dropWhile (<n) squares)
-- 0.75

squares2 = [d*d | d <- [1, 2 .. ]]
isASquare2 n = n == head (dropWhile (<n) squares2)
-- 0.77

iSqrt n = round (sqrt (fromIntegral n))
isASquare n = (iSqrt n) ^ 2 == n
-- 0.5

lastDigit num | num < 0 = ((-1) * num) `rem` 10 | otherwise = num `rem` 10
isASquare3 n | lastDigit n `elem` [0, 1, 4, 5, 6, 9] = isASquare n | otherwise = False
-- 0.72

oddsFrom3 = [3, 5 .. ]
smallPrimeDivisors n = [d | d <- takeWhile (\x -> x^2 <= n) primes, n `mod` d == 0]
primes = 2 : [n | n <- oddsFrom3, null (smallPrimeDivisors n)]

isPrime n = n == head (dropWhile (<n) primes)

oddComposites = filter(\x-> not(isPrime x)) oddsFrom3

goldbachExceptions = [g | g <- oddComposites, null [p | p <- takeWhile(<g) primes, isASquare ((g-p) `div` 2)] ]