import Math.NumberTheory.Powers.Squares
-- 0.27

squares = map (\x -> x*x) [1 .. ]
isSquare1 n = n == (head $ dropWhile (<n) squares)
-- 0.75

squares2 = [d*d | d <- [1, 2 .. ]]
isSquare2 n = n `elem` takeWhile(<=n) squares2
-- 0.8

iSqrt n = round (sqrt (fromIntegral n))
isASquare n = (iSqrt n) ^ 2 == n
-- 0.5

oddsFrom3 = [3, 5 .. ]
smallPrimeDivisors n = [d | d <- takeWhile (\x -> x^2 <= n) primes,n `mod` d == 0]
primes = 2 : [n | n <- oddsFrom3, null (smallPrimeDivisors n)]

isPrime n = n `elem` takeWhile(<=n) primes

oddComposites = filter(\x-> not(isPrime x)) oddsFrom3

g = [g | g <- oddComposites, null [p | p <- takeWhile(<g) primes, isSquare' ((g-p) `div` 2)] ]