isPrime :: Int -> Int-> Int
isPrime x n
  | n == 0 = 0
  | n == 1 = 1
  | x `mod` n == 0 = 0
  | otherwise = isPrime x (n-1)


main = do
  x <- getLine
  let var = (read x)
  if isPrime var (var-1) == 1 then 
    if isPrime (var+2) (var+1) == 1 then
      print "PRIMO CASADO!"
    else print "PRIMO!"
  else
    print "NAO PRIMO!"