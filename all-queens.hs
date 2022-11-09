import System.Environment
import Prelude

is_attacked :: [Int] -> Int -> Int -> Bool
is_attacked board i0 j0 = aux_rec board i0 j0 0 where
    aux_rec board i0 j0 i
        | i == length board = False
        | otherwise           = ((b_i>=0) &&
                                    ((b_i==j0)||(i-b_i == i0-j0)||(i+b_i == i0+j0)))
                                || aux_rec board i0 j0 (i+1) where b_i = board !! i

put_col :: Int -> Int -> [Int] -> [Int]
put_col row col (x:xs) = if row==0 then col:xs else x:(put_col (row-1) col xs)

all_n_queens :: Int -> Int
all_n_queens n = rec_aux board n 0 where
    board = take (n) (repeat (-1))
    rec_aux :: [Int] -> Int -> Int -> Int
    rec_aux board n row
        | row >= n  = 1
        | otherwise = foldl (\x col ->
            x+(if (is_attacked board row col) then 0 else (rec_aux (put_col row col board) n (row+1)))
                ) 0 [0..n-1]

board = take (4) (repeat (-1))
main :: IO() = do
    args <- getArgs
    if length args /= 1 then (print "Usage: program [-v] n") else (
                    let n = (args !! 0)  in (print $ all_n_queens (read n)))
                        --(put_col 1 1 board)))