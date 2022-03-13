import Test.Tasty (defaultMain, testGroup, TestTree)
import Test.Tasty.HUnit (assertBool, testCase)
import Picosat
import GenCNF

tests :: TestTree
tests = testGroup "Tests:" [satisfiable, unsatisfiable]

satisfiable :: TestTree 
satisfiable = testGroup
    "Satisfiable Tests"
    [
        testGroup "Trivial" $
            [ testCase "n = 0" $ assertBool "n = 0 is SAT!" (checkSAT 0)
            , testCase "n = 1" $ assertBool "n = 1 is SAT!" (checkSAT 1)
            ]
        ,

        testGroup "Main" $ 
            fmap (\n -> testCase ("n = " ++ show n) $ 
                assertBool ("n = " ++ show n ++ " is SAT!") (checkSAT n)) 
            [4..20]
    ]

unsatisfiable :: TestTree 
unsatisfiable = testGroup
    "Unsatisfiable Tests"
    [   
          testCase "n = 2" $ assertBool "n = 2 is UNSAT!" (checkUNSAT 2)
        , testCase "n = 3" $ assertBool "n = 3 is UNSAT!" (checkUNSAT 3)
    ]

isCorrect :: Int -> [Int] -> Bool
isCorrect n q = let qf = filter (>0) q 
    in (length (filter (>0) qf) == n) && 
       (and [not $ fromVarToIndex n q1 `isCollision` fromVarToIndex n q2 | q1 <- qf, q2 <- qf, q1 /= q2]) 

checkSAT :: Int -> Bool 
checkSAT n = case unsafeSolve $ genCNF n of
                (Solution ans) -> isCorrect n ans
                otherwise      -> False

checkUNSAT :: Int -> Bool 
checkUNSAT n = case unsafeSolve $ genCNF n of
    Unsatisfiable -> True
    otherwise     -> False

main :: IO ()
main = defaultMain tests
