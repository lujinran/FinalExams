import Graph -- For Q2

--Q1

--(a)
data List a = EmptyList | L a (List a) deriving Show

--(b)
count :: (Eq a) => a -> List a -> Int
count _ EmptyList = 0
count x (L y xs)
    | y == x    = 1 + count x xs
    | otherwise = count x xs

append :: List a -> List a -> List a
append EmptyList ys = ys
append (L x xs) ys  = L x (append xs ys)

--Q2
data Search = BFS | DFS

join :: [ a ] -> [ a ] -> Search -> [ a ]
join xs ys search = case search of
                       BFS -> xs ++ ys
                       DFS -> ys ++ xs

reach :: Graph -> Node -> Search -> [ Node ]
reach g s search = reach' g search [ ] [ s ]

reach' :: Graph -> Search -> [ Node ] -> [ Node ] -> [ Node ]
reach' _ _  _ [ ] = [ ]
reach' g search seen ( n : ns )
    | elem n seen = reach' g search seen ns
    | otherwise   = n : reach' g search ( n : seen ) ( join ns ( neighbours n g ) search )

-- Tested with these examples:
-- map n2s (reach g1 (s2n "A") BFS)
--   > ["A","B","C","E","D","F","G"]
-- map n2s (reach g1 (s2n "A") DFS)
--   > ["A","B","D","E","C","F","G"]

--Q3

--(a)

-- z takes an integer s1 (in this case it is 3) and sums the top s1 elements on
-- the stack, the result will be on top of the stack.
--
-- After "1 2 3 4 5 6 7 3 z ." is run, the stack is as follows (5 + 6 + 7 = 18):
--                                                    18
--                                                    4
--                                                    3
--                                                    2
--                                                    1

--(b) I have tested the following and it works.

-- 1. Define a function in the factor interpretor called eval'repeat, as follows:

    --eval'repeat :: [ Token ] -> Stack -> Environment -> String
    --eval'repeat ts ( Sinteger n : Squotation q : ss ) env =
    --        eval' ( ( repeatList q n ) ++ ts ) ss env

    ---- repeatList xs n : the list containing the contents of list 'xs' 'n' times
    --repeatList :: [ a ] -> Integer -> [ a ]
    --repeatList xs 0 = [ ]
    --repeatList xs n = xs ++ ( repeatList xs ( n - 1 ) )

-- 2. Change eval' to be defined as follows:

-- eval' tokens stack env : the result of interpreting the token list 'tokens'
--                          using the stack 'stack' and the environment 'env'

    --eval' :: [ Token ] -> Stack -> Environment -> String

    --eval' [ ]        _     _   = ""

    --eval' ( t : ts ) stack env = ...
    --                             if t == "if" then
    --                                ...
    --                             else
    --                             if t == "repeat" then
    --                                eval'repeat ts stack env
    --                             else
    --                             case t of
    --                                ...