posOcupadas _ _ 0 _ = []
posOcupadas x y t s
	| s == "vertical" = (x,y):posOcupadas x (y+1) (t-1) s
	| otherwise = (x,y):posOcupadas (x+1) y (t-1) s


compListas [] _ = True
compListas _ [] = True
compListas (x:xs) y 
	| x `elem` y = False
	| otherwise = compListas xs y 


main = do
	x_n1 <- getLine
	y_n1 <- getLine
	tam_n1 <- getLine
	sentido_n1 <- getLine
	x_n2 <- getLine
	y_n2 <- getLine
	tam_n2 <- getLine
	sentido_n2 <- getLine

	let pos_n1 = posOcupadas (read x_n1) (read y_n1) (read tam_n1) sentido_n1 
	let pos_n2 = posOcupadas (read x_n2) (read y_n2) (read tam_n2) sentido_n2 

	let result = compListas pos_n1 pos_n2

	print result