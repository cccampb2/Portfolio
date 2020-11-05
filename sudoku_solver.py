sudoku_board =  [
		 [0,0,0,0,2,7,9,6,0],
		 [0,9,0,3,0,0,0,1,0],
		 [7,1,0,9,0,0,0,0,0],
		 
		 [0,0,0,0,0,0,0,3,0],
		 [4,0,0,7,0,9,0,0,1],
		 [0,5,0,0,0,0,0,0,0],
		 
		 [0,0,0,0,0,3,0,8,9],
		 [0,7,0,0,0,6,0,5,0],
		 [0,4,3,8,1,0,0,0,0]
		 ]

blank =  [
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0],
		 
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0],
		 
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0],
		 [0,0,0,0,0,0,0,0,0]
		 ]

def isEmpty(sBoard):
	#Find empty space (represented by a 0)

	for i in range(len(sBoard)):
		for k in range(len(sBoard[0])):
			if sBoard[i][k] == 0:
				return (i,k)


	return None

def isValid(number, sBoard, pos):
	#Check column
	for i in range(len(sBoard[0])):
			if sBoard[i][pos[1]] == number and i != pos[0]:
				return False

	#Check row
	for i in range(len(sBoard)):
			if sBoard[pos[0]][i] == number and i != pos[1]:
				return False

	#Check 3x3 Square

	x_Square = pos[0] // 3
	y_Square = pos[1] // 3


	for i in range(x_Square*3, x_Square*3 + 3):
		for j in range(y_Square*3, y_Square*3 + 3):
			if sBoard[i][j] == number and pos != (i,j):
				return False

	return True

def print_board(sBoard):
	for i in range(len(sBoard)):
		if i % 3 == 0 and i != 0:
			print("-"*21)
		for j in range(len(sBoard[0])):
			if j % 3 == 0 and j != 0:
				print("|", end=" ")
			if j == 8:
			
				print(sBoard[i][j], end='\n')
			else:
				print(sBoard[i][j], end=" ")

def sudoku_solver(Sb):
	#Param 'Sb' is a 2D integer array
	#returns 'True' if solved

	emptyCoordinates = isEmpty(Sb)

	if emptyCoordinates:
		row, col = emptyCoordinates
	else:
		return True

	for i in range(1,10):
		if isValid(i,Sb,(row,col)):
			Sb[row][col] = i
			

			if sudoku_solver(Sb):
				return True

			Sb[row][col] = 0

	return False




print_board(sudoku_board)

sudoku_solver(sudoku_board)
print("---"*15)
print_board(sudoku_board)











