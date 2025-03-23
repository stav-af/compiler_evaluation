import System.Environment (getArgs)

catalan :: Int -> Integer
catalan n = cats !! n
  where cats = 1 : [ sum [ cats !! i * cats !! (j - 1 - i) | i <- [0 .. j - 1] ] | j <- [1..] ]

main :: IO ()
main = do
  args <- getArgs
  let n = read (head args) :: Int
  print (catalan n)
