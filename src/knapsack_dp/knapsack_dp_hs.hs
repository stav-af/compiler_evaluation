import System.Environment (getArgs)

knapSackDP :: [Double] -> [Double] -> Double -> Double
knapSackDP ws vs capD =
    let n     = length ws
        cap   = floor capD
        dp = [[0.0 | c <- [0..cap]] | i <- [0..n]]
        -- Fill the DP table
        fillDP i dpSoFar
          | i > n = dpSoFar
          | otherwise =
              let w = floor (ws !! (i-1))
                  v = vs !! (i-1)
                  updatedRow = [ if w > c
                                 then dpSoFar !! (i-1) !! c
                                 else let excludeVal = dpSoFar !! (i-1) !! c
                                          includeVal = v + dpSoFar !! (i-1) !! (c - w)
                                      in max excludeVal includeVal
                               | c <- [0..cap] ]
                  newDP = take i dpSoFar ++ [updatedRow] ++ drop (i+1) dpSoFar
              in fillDP (i+1) newDP
        finalDP = fillDP 1 dp
    in (finalDP !! n) !! cap

main :: IO ()
main = do
    args <- getArgs
    let n = read (head args) :: Int
    let big_weights = [fromIntegral i | i <- [1..n]]
    let big_values  = [fromIntegral i | i <- [10..(9+n)]]
    print (knapSackDP big_weights big_values 400.0)