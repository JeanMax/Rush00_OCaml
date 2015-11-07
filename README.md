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
nbPlayer : int
(x y : int (1-9, -1 error), p: char (X O))  
  
* modules:  
Util  
Draw  
Main  
  
### Util (mcanal) ###
todo: declarer vars    -DONE-    
askNPlayers () -> int  -DONE-    
askP1Name () -> string    -DONE-    
askP2Name () -> string    -DONE-    
  
### Draw (tpayet) ###
waitMouse () -> (x, y)  
updateWindow x y p -> ()  
drawEmptyGrid () -> ()  
  
### Main ###
waitKeyboard () -> (x, y)  
updateLGrid x y p -> ()  
updateSGrid () -> ()  
checkIfPossible x y -> bool  
checkVictory () -> p  