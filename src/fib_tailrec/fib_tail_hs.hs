import System.Environment (getArgs)

fib :: Int -> Integer
fib n = fibHelper n 0 1
  where
    fibHelper 0 a _ = a
    fibHelper n a b = fibHelper (n - 1) b (a + b)

main :: IO ()
main = do
  args <- getArgs
  let n = read (head args) :: Int
  print (fib n)