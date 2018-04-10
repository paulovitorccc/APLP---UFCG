total :: Double -> String -> Double
total qtdPessoas veiculo
  | veiculo == "carro" = 5.0 + (1.5 * qtdPessoas) 
  | veiculo == "moto" = 2.0 + (1.5 * qtdPessoas)
  | veiculo == "van" = 15.0 + (1.5 * qtdPessoas)
  | veiculo == "onibus" = 50.0 + (1.5 * qtdPessoas)
  | otherwise = 1.5 * qtdPessoas
  



main = do 
  veiculo <- getLine
  x <- getLine
  let qtdPessoas = (read x)
  print ( total qtdPessoas veiculo ) 
	