fatores :: Int -> [Int]
fatores valor = [num | num <- [1..valor-1], (valor `mod` num) == 0]

perfeito :: Int -> Bool
perfeito valor 
  | ((sum (fatores valor)) == valor) = True
  | otherwise = False

main = do
  x <- getLine
  print (perfeito (read x))

