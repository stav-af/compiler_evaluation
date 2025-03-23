import System.Environment (getArgs)

catalan :: Integer -> Integer
catalan 0 = 1
catalan n = catalanSum n 0

catalanSum :: Integer -> Integer -> Integer
catalanSum n i
  | i == n    = 0
  | otherwise = catalan i * catalan (n - 1 - i) + catalanSum n (i + 1)

main :: IO ()
main = do
  args <- getArgs
  let n = read (head args) :: Integer
  print (catalan n)