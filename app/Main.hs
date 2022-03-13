module Main where

import System.Environment (getArgs)
import GenCNF (genCNF, fromIndexToVar, fromVarToIndex)
import Picosat
                          
main :: IO ()
main = do
    input <- getArgs
    let n = read $ input!!0 :: Int 
    solution <- solve $ genCNF n

    let -- пустая доска
        board :: [Char]
        board = replicate (n^2) '.'
        -- разрезаем на строки
        group :: Int -> [a] -> [[a]]
        group _ [] = []
        group n l = (take n l) : (group n (drop n l))
        -- расставляем королев
        placeQueens :: [Int] -> [Char] -> [Char]
        placeQueens [] b = b
        placeQueens (q:qs) b | q>0  = placeQueens qs $ (take (q-1) b) ++ "Q" ++ (drop q b)
                             | q<=0 = placeQueens qs b
        
        addSpaces :: [Char] -> [Char]
        addSpaces xs = concat $ map (\x -> [x]++" ") xs
        
    putStrLn $ case solution of
                (Solution ans) -> concat . (map (++"\n")) . (group (2*n)) . addSpaces . (placeQueens ans) $ board
                Unsatisfiable  -> "Unsatisfiable"
                Unknown        -> "Error"     
        