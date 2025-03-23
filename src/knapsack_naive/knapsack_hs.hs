import System.Environment (getArgs)

nats :: Double -> [Double]
nats x = x : nats (x + 1.0)

myTake :: Int -> [Double] -> [Double]
myTake _ []     = []
myTake 0 _      = []
myTake n (x:xs) = x : myTake (n-1) xs

knapSack :: [Double] -> [Double] -> Double -> Double
knapSack [] _ _ = 0.0
knapSack _ [] _ = 0.0
knapSack (w:ws) (v:vs) capacity
    | capacity < 0.0 = 0.0
    | w > capacity   = knapSack ws vs capacity
    | otherwise      =
        let excludeVal = knapSack ws vs capacity
            includeVal = v + knapSack ws vs (capacity - w)
        in max excludeVal includeVal

main :: IO ()
main = do
    args <- getArgs
    let n = read (head args) :: Int
    let bigWeights = myTake n (nats 1.0)
    let bigValues  = myTake n (nats 10.0)
    print (knapSack bigWeights bigValues 400.0)