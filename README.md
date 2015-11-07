# OCaml_Rush #


	     //  
	   _oo\  
	  (__/ \  _  _  
	     \  \/ \/ \  
	     (         )\  
	      \_______/  \  
	       [[] [[]  
		   [[] [[]  
  


### TODO: ###

* var:
lGrid (9x9) : string list  
sGrid (3x3) : string    
p1Name : string    
p2Name : string    
(x y : int (1-9, -1 error), p: char (X O))  
  
* modules:  
Util  
Draw  
Main  
  
### Util ###
todo: declarer vars  
askNPlayers () -> int  
askP1Name () -> string  
askP2Name () -> string  
  
### Draw ###
waitMouse () -> (x, y)  
updateWindow x y p -> ()  
drawEmptyGrid () -> ()  
  
### Main ###
waitKeyboard () -> (x, y)  
updateLGrid x y p -> ()  
updateSGrid () -> ()  
checkIfPossible x y -> bool  
checkVictory () -> p  