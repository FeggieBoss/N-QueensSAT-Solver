module GenCNF where

import GHC.Base (divInt, modInt)
import Control.Monad.Identity (guard)

type Var = Int 
type CNFclause = [Var]
type CNF = [CNFclause]

-- конвертируем индекс матрицы в соответствующую переменную кнф-формулы
fromIndexToVar :: Int -> (Int, Int) -> Var 
fromIndexToVar n (i,j) = i*n + j + 1

-- конвертируем переменную кнф-формулы в соответствующий индекс матрицы
fromVarToIndex :: Int -> Var -> (Int, Int)
fromVarToIndex n v = ((v-1) `divInt` n, (v-1) `modInt` n)

-- проверяем бьют ли друг друга королевы
isCollision :: (Int, Int) -> (Int, Int) -> Bool
isCollision (i1,j1) (i2,j2) = or [i1==i2, j1==j2, abs (i1-i2) == abs(j1-j2)]

-- генерируем КНФ-формулу 
genCNF :: Int -> CNF
genCNF n = collisions ++ goodplacement
    where fromIndexToVarN = fromIndexToVar n
          fromVarToIndexN = fromVarToIndex n
          -- КНФ-формула - королевы не бьют друг друга
          collisions = do
              q1 <- [1..n^2]
              q2 <- [q1+1..n^2]
              guard $ fromVarToIndexN q1 `isCollision` fromVarToIndexN q2
              return [-q1, -q2]
          -- в каждой строке и в каждом столбце есть королева
          goodplacement = do
              row <- [0..n-1]
              return [fromIndexToVarN (row, col) | col <- [0..n-1]]

