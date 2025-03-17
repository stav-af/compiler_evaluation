import System.Environment (getArgs)

fib :: Int -> Integer
fib n
  | n < 2     = fromIntegral n
  | otherwise = fib (n - 1) + fib (n - 2)

main :: IO ()
main = do
  args <- getArgs
  let n = read (head args) :: Int
  print (fib n)