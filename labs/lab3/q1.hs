mudaSeq:: [char] -> [char]
mudaSeq [] = []
mudaSeq (x:xs) = [head xs] ++ [x] ++ mudaSeq (tail xs)


main = do
	nome <- getLine
	let result = mudaSeq nome 
	putStrLn result