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
sGrid (3x3) : string list  
p1Name : string    
p2Name : string
nbPlayer : int
(x y : int (1-9, -1 error), p: string ("X" "O" "-"))  
  
* modules:  
Util  
Draw  
Main  
  
### Util (mcanal) ###
todo: declarer vars    -DONE-    
askNPlayers () -> int  -DONE-    
askP1Name () -> string    -DONE-    
askP2Name () -> string    -DONE-    
setGrid x y (p:string) grid -> grid    -DONE-    
getGrid x y grid -> (p:char)    -DONE-    
  
### Draw (tpayet) ###
waitMouse () -> (x, y)  
updateWindow x y p -> ()  
drawEmptyGrid () -> ()  
  
### Main ###
waitKeyboard () -> (x, y)   -DONE-    
checkIfPossible x y lGrid -> bool     -DONE-    
checkVictory sGrid lGrid (p:string) -> bool     -DONE-
updateGrids x y p sGrid lGrid -> (sGrid, lGrid) -DONE-  
