check(LEFTCAN,LEFTMIS,RIGHTCAN,RIGHTMIS) :- %checks if the move is correct according to the game's rules
	LEFTMIS >= 0, LEFTCAN >= 0, RIGHTMIS >= 0, RIGHTCAN >= 0, %ensures that the number of missionaries and cannibals on both banks is non-negative.
	(LEFTMIS >= LEFTCAN ; LEFTMIS = 0), %checks that cannibals don't outnumber missionaries in left 
	(RIGHTMIS >= RIGHTCAN ; RIGHTMIS = 0). %checks that cannibals don't outnumber missionaries in right 


move([LEFTCAN,LEFTMIS,left,RIGHTCAN,RIGHTMIS],[LEFTCAN,LEFTMIS2,right,RIGHTCAN,RIGHTMIS2]):- %moves two missionaries to the right
	RIGHTMIS2 is RIGHTMIS + 2, %adds 2 to the number of missionaries on the right
	LEFTMIS2 is LEFTMIS - 2, %subtracts 2 from the number of missionaries on the left
	check(LEFTCAN,LEFTMIS2,RIGHTCAN,RIGHTMIS2). %checks if the move is correct according to the game's rules

%all the move predicate work the same, so i will skip explanation for those parts. The only change is the amount of people moved from one side to another.

move([LEFTCAN,LEFTMIS,left,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS,right,RIGHTCAN2,RIGHTMIS]):- %moves two cannibals to the right
	RIGHTCAN2 is RIGHTCAN + 2,
	LEFTCAN2 is LEFTCAN - 2,
	check(LEFTCAN2,LEFTMIS,RIGHTCAN2,RIGHTMIS).

move([LEFTCAN,LEFTMIS,left,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS2,right,RIGHTCAN2,RIGHTMIS2]):- %moves one missionary and one cannibal to the right
	RIGHTCAN2 is RIGHTCAN + 1,
	LEFTCAN2 is LEFTCAN - 1,
	RIGHTMIS2 is RIGHTMIS + 1,
	LEFTMIS2 is LEFTMIS - 1,
	check(LEFTCAN2,LEFTMIS2,RIGHTCAN2,RIGHTMIS2).

move([LEFTCAN,LEFTMIS,left,RIGHTCAN,RIGHTMIS],[LEFTCAN,LEFTMIS2,right,RIGHTCAN,RIGHTMIS2]):- %moves one missionary to the right 
	RIGHTMIS2 is RIGHTMIS + 1,
	LEFTMIS2 is LEFTMIS - 1,
	check(LEFTCAN,LEFTMIS2,RIGHTCAN,RIGHTMIS2).

move([LEFTCAN,LEFTMIS,left,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS,right,RIGHTCAN2,RIGHTMIS]):- %moves one cannibal to the right
	RIGHTCAN2 is RIGHTCAN + 1,
	LEFTCAN2 is LEFTCAN - 1,
	check(LEFTCAN2,LEFTMIS,RIGHTCAN2,RIGHTMIS).

move([LEFTCAN,LEFTMIS,right,RIGHTCAN,RIGHTMIS],[LEFTCAN,LEFTMIS2,left,RIGHTCAN,RIGHTMIS2]):- %moves two missionaries to the left
	% Two missionaries cross right to left.
	RIGHTMIS2 is RIGHTMIS - 2,
	LEFTMIS2 is LEFTMIS + 2,
	check(LEFTCAN,LEFTMIS2,RIGHTCAN,RIGHTMIS2).

move([LEFTCAN,LEFTMIS,right,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS,left,RIGHTCAN2,RIGHTMIS]):- %moves two cannibals to the left
	RIGHTCAN2 is RIGHTCAN - 2,
	LEFTCAN2 is LEFTCAN + 2,
	check(LEFTCAN2,LEFTMIS,RIGHTCAN2,RIGHTMIS).

move([LEFTCAN,LEFTMIS,right,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS2,left,RIGHTCAN2,RIGHTMIS2]):- 	%moves one missionary and one cannibal to the left
	RIGHTCAN2 is RIGHTCAN - 1,
	LEFTCAN2 is LEFTCAN + 1,
	RIGHTMIS2 is RIGHTMIS - 1,
	LEFTMIS2 is LEFTMIS + 1,
	check(LEFTCAN2,LEFTMIS2,RIGHTCAN2,RIGHTMIS2).

move([LEFTCAN,LEFTMIS,right,RIGHTCAN,RIGHTMIS],[LEFTCAN,LEFTMIS2,left,RIGHTCAN,RIGHTMIS2]):- %moves one missionary to the left
	RIGHTMIS2 is RIGHTMIS - 1,
	LEFTMIS2 is LEFTMIS + 1,
	check(LEFTCAN,LEFTMIS2,RIGHTCAN,RIGHTMIS2).

move([LEFTCAN,LEFTMIS,right,RIGHTCAN,RIGHTMIS],[LEFTCAN2,LEFTMIS,left,RIGHTCAN2,RIGHTMIS]):- %moves one cannibal to the left
	RIGHTCAN2 is RIGHTCAN - 1,
	LEFTCAN2 is LEFTCAN + 1,
	check(LEFTCAN2,LEFTMIS,RIGHTCAN2,RIGHTMIS).


solve([LEFTCAN1,LEFTMIS1,B1,RIGHTCAN1,RIGHTMIS1],[LEFTCAN2,LEFTMIS2,B2,RIGHTCAN2,RIGHTMIS2],States,Solution) :- %uses two states (current and target), a list of checked states and a list which stores moves that contribute to the solution.
   move([LEFTCAN1,LEFTMIS1,B1,RIGHTCAN1,RIGHTMIS1],[LEFTCAN3,LEFTMIS3,B3,RIGHTCAN3,RIGHTMIS3]),  %calls the move predicate to run a valid move from the current state to a new state
   not(member([LEFTCAN3,LEFTMIS3,B3,RIGHTCAN3,RIGHTMIS3],States)), %checks if the new state has not been explored before and ensures there are no loops
   solve([LEFTCAN3,LEFTMIS3,B3,RIGHTCAN3,RIGHTMIS3],[LEFTCAN2,LEFTMIS2,B2,RIGHTCAN2,RIGHTMIS2],[[LEFTCAN3,LEFTMIS3,B3,RIGHTCAN3,RIGHTMIS3]|States],[ [[LEFTCAN3,LEFTMIS3,B3,RIGHTCAN3,RIGHTMIS3],[LEFTCAN1,LEFTMIS1,B1,RIGHTCAN1,RIGHTMIS1]] | Solution ]). %uses recursion to solve the problem more efficiently

% Solution found
solve([LEFTCAN,LEFTMIS,B,RIGHTCAN,RIGHTMIS],[LEFTCAN,LEFTMIS,B,RIGHTCAN,RIGHTMIS],_,Solution):- %if the current state is equal to the target state, then the solution has been found
	output(Solution). %prints the list of moves that lead from the initial state to the goal state.

% Printing
output([]) :- nl. %prints a new line when there is nothing left to print
output([[A,B]|Solution]) :- %takes A and B which are the moves from the solution
	output(Solution),  %prints the solution recursively
   	write(B), write(' -> '), write(A), nl. %formats the solution so the steps are shown graphically

run :- 
   solve([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],_). %calls solve function with a start and a goal state, a checked state and a placeholder for the solution
