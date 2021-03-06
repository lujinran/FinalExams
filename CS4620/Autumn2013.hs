--Autumn 2013
--Q1A
--powers :: Enum a => a -> [a]
powers n = n : zipWith(\n m -> n*m) (powers n) [n,n..]
--Q1B
factorials :: [Int]
factorials = 1 : zipWith(\n m -> n*m) factorials [2..]

--Q2A
--(1)  The type definition should be ->  atLeast :: Int -> [a] -> Bool, 
--     NOT atLeast n xs :: Int -> [a] -> Bool
--(2)  
 
 --Q2B
atLeast :: Int -> [a] -> Bool
atLeast n xs = length xs >= n ( Not right, original given to us )

--Q3A
from :: Int -> [Int]
from n = [f| f <- [n..]]

--Q3B
unite :: [a] -> [a] -> [a]
unite (x:xs) (y:ys) = x : y : unite xs ys 
--Q3C
integers :: [Int]
integers = 0 : listInts (from 1)
listInts (n:ns) = n : -n : listInts ns
