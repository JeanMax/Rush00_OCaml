(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mcanal <zboub@42.fr>                       +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/07 23:36:09 by mcanal            #+#    #+#             *)
(*   Updated: 2015/11/08 20:43:33 by mcanal           ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(*
let print_lGrid grid =
  let rec zboub i = function
	  []          -> ()
	 | head::tail -> print_endline ( 
						 (String.sub head 0 3) ^ "|"
						 ^ (String.sub head 3 3) ^ "|"
						 ^ (String.sub head 6 3));
					 if i mod 3 = 0 && i != 9
					 then print_endline "-----------";
					 zboub (i + 1) tail
  in zboub 1 grid
 *)
let print_lGrid grid =
  let rec zboub i = function
	  []          -> ()
	| head::tail  ->
	   String.iter (fun x -> print_char x; print_char ' ') (String.sub head 0 3);
	   print_string "| ";
	   String.iter (fun x -> print_char x; print_char ' ') (String.sub head 3 3);
	   print_string "| ";
	   String.iter (fun x -> print_char x; print_char ' ') (String.sub head 6 3);
	   print_char '\n';
	   if i mod 3 = 0 && i != 9
	   then print_endline "---------------------";
	   zboub (i + 1) tail
  in zboub 1 grid

		   
let rec waitKeyboard () =
  let s = read_line () in
  if String.length s = 3 && s.[0] >= '1' && s.[0] <= '9' && s.[1] = ' '
	 && s.[2] >= '1' && s.[2] <= '9'
  then (int_of_string (String.sub s 2 1),
		int_of_string (String.sub s 0 1))
  else (print_endline "Incorrect format."; waitKeyboard ())



let checkIfPossible x y sGrid lGrid =
  let c = Util.getGrid x y lGrid in
  c != 'X' && c != 'O'
  && Util.getGrid ((x-1)/3+1) ((y-1)/3+1) sGrid = '-'


let updateGrids x y p sGrid lGrid =
  if p = "X" then
	  (Util.setGrid ((x-1)/3+1) ((y-1)/3+1) p sGrid,

	  Util.setGrid   x     y    "\\" 
	  (Util.setGrid (x+1)  y    " " 
	  (Util.setGrid (x+2)  y    "/" 
	  (Util.setGrid  x    (y+1) " " 
      (Util.setGrid (x+1) (y+1) "x" 
      (Util.setGrid (x+2) (y+1) " "
      (Util.setGrid  x    (y+2) "/" 
	  (Util.setGrid (x+1) (y+2) " "
      (Util.setGrid (x+2) (y+2) "\\" lGrid)))))))) )
  else
	  (Util.setGrid ((x-1)/3+1) ((y-1)/3+1) p sGrid,

	  Util.setGrid   x     y    "/" 
      (Util.setGrid (x+1)  y    "-" 
      (Util.setGrid (x+2)  y    "\\" 
      (Util.setGrid  x    (y+1) "|" 
      (Util.setGrid (x+1) (y+1) " " 
      (Util.setGrid (x+2) (y+1) "|" 
      (Util.setGrid  x    (y+2) "\\" 
      (Util.setGrid (x+1) (y+2) "-" 
      (Util.setGrid (x+2) (y+2) "/" lGrid)))))))) )


let checkVictory sGrid lGrid p sl =

  let checkHor x y grid =
	let c = Util.getGrid x y grid in
	(c = 'O' || c = 'X') 
	&& c = Util.getGrid (x+1) y grid
	&& c = Util.getGrid (x+2) y grid in
  
  let checkVer x y grid =
	let c = Util.getGrid x y grid in
	(c = 'O' || c = 'X') 
	&& c = Util.getGrid x (y+1) grid
	&& c = Util.getGrid x (y+2) grid in

  let checkDiag1 x y grid =
	let c = Util.getGrid x y grid in
	(c = 'O' || c = 'X') 
	&& c = Util.getGrid (x+1) (y+1) grid
	&& c = Util.getGrid (x+2) (y+2) grid in

  let checkDiag2 x y grid =
	let c = Util.getGrid x y grid in
	(c = 'O' || c = 'X') 
	&& c = Util.getGrid (x-1) (y+1) grid
	&& c = Util.getGrid (x-2) (y+2) grid in

  let checkDraw x y grid =
	let isPlayed c = (c = 'O' || c = 'X') in
	isPlayed (Util.getGrid     x     y    grid)
	&& isPlayed (Util.getGrid (x+1)  y    grid)
	&& isPlayed (Util.getGrid (x+2)  y    grid)
	&& isPlayed (Util.getGrid  x    (y+1) grid)
	&& isPlayed (Util.getGrid (x+1) (y+1) grid)
	&& isPlayed (Util.getGrid (x+2) (y+1) grid)
	&& isPlayed (Util.getGrid  x    (y+2) grid)
	&& isPlayed (Util.getGrid (x+1) (y+2) grid)
	&& isPlayed (Util.getGrid (x+2) (y+2) grid) in

  let checkSquare x y n grid =
	if checkHor x y grid || checkHor x (y+1) grid || checkHor x (y+2) grid 
	   || checkVer x y grid || checkVer (x+1) y grid || checkVer (x+2) y grid 
	   || checkDiag1 x y grid || checkDiag2 (x+2) y grid || checkDraw x y grid
	then begin if n = 0
			   then (print_endline ((if p = "X" then Util.p1Name else Util.p2Name)
									^ " wins the game!\n");
					 print_lGrid lGrid; print_endline "";
					 ignore(Draw.waitMouse());
					 Draw.eraseGrid ()) 
			   else
				 begin
				   print_endline ((if p = "X" then Util.p1Name else Util.p2Name)
								  ^ " wins the grid " ^ 
									(string_of_int n) ^ "!");
				   Draw.gridWins ((x-1)/3+1) ((y-1)/3+1) p
				 end;
			   true
		 end 
	else false in

  (* checkLVictory *)
  if sl = "l" then
	begin
	  if checkSquare 1 1 1 lGrid then updateGrids 1 1 p sGrid lGrid
	  else if checkSquare 4 1 2 lGrid then updateGrids 4 1 p sGrid lGrid
	  else if checkSquare 7 1 3 lGrid then updateGrids 7 1 p sGrid lGrid
	  else if checkSquare 1 4 4 lGrid then updateGrids 1 4 p sGrid lGrid
	  else if checkSquare 4 4 5 lGrid then updateGrids 4 4 p sGrid lGrid
	  else if checkSquare 7 4 6 lGrid then updateGrids 7 4 p sGrid lGrid
	  else if checkSquare 1 7 7 lGrid then updateGrids 1 7 p sGrid lGrid
	  else if checkSquare 4 7 8 lGrid then updateGrids 4 7 p sGrid lGrid
	  else if checkSquare 7 7 9 lGrid then updateGrids 7 7 p sGrid lGrid
	  else (sGrid, lGrid)
	end
	  
	  (* checkSVictory *)
  else if checkSquare 1 1 0 sGrid then (Util.sGrid, Util.lGrid)
  else (sGrid, lGrid)
							 


let megaChoiceIA sGrid lGrid =

  let choiceIA p =

	let check_h x y grid =
	  if (Util.getGrid    x  y grid = p
		  && Util.getGrid x (y + 1) grid = p
		  && Util.getGrid x (y + 2) grid = '-') then (x, (y + 2))
	  else if (Util.getGrid x y grid = p
			   && Util.getGrid x (y + 2) grid = p
			   && Util.getGrid x (y + 1) grid = '-') then (x, (y + 1))
	  else if (Util.getGrid x (y + 1) grid = p
			   && Util.getGrid x (y + 2) grid = p
			   && Util.getGrid x y grid = '-') then (x, y)
	  else (0, 0)
	in
	
	let check_v  x y grid =
	  if (Util.getGrid x y grid = p
		  && Util.getGrid (x + 1) y grid = p
		  && Util.getGrid (x + 2) y grid = '-') then ((x + 2), y)
	  else if (Util.getGrid x y grid = p
			   && Util.getGrid (x + 2) y grid = p
			   && Util.getGrid (x + 1) y grid = '-') then ((x + 1), y)
	  else if (Util.getGrid (x + 1) y grid = p
			   && Util.getGrid (x + 2) y grid = p
			   && Util.getGrid x y grid = '-') then (x, y)
	  else (0, 0)
	in

	let check_d1 x y grid =
	  if (Util.getGrid x y grid = p
		  && Util.getGrid (x + 1) (y + 1) grid = p
		  && Util.getGrid (x + 2) (y + 2) grid = '-') then ((x + 2), (y + 2))
	  else if (Util.getGrid x y grid = p
			   && Util.getGrid (x + 2) (y + 2) grid = p
			   && Util.getGrid (x + 1) (y + 1) grid = '-') then ((x + 1), (y + 1))
	  else if (Util.getGrid (x + 1) (y + 1) grid = p
			   && Util.getGrid (x + 2) (y + 2) grid = p
			   && Util.getGrid x y grid = '-') then (x, y)
	  else (0, 0)
	in

	let check_d2 x y grid =
	  if (Util.getGrid    (x + 2)  y grid = p
		  && Util.getGrid  x      (y + 2) grid = p
		  && Util.getGrid (x + 1) (y + 1) grid = '-') then ((x + 1), (y + 1))
	  else if (Util.getGrid    (x + 2)  y grid = p
			   && Util.getGrid (x + 1) (y + 1) grid = p
			   && Util.getGrid  x      (y + 2) grid = '-') then (x, (y + 2))
	  else if (Util.getGrid     x      (y + 2) grid = p
			   && Util.getGrid (x + 1) (y + 1) grid = p
			   && Util.getGrid (x + 2)  y grid = '-') then ((x + 2), y)
	  else (0, 0)
	in

	let check_s x y grid =
	  if      check_v x y grid  <> (0, 0) then check_v x y grid
	  else if check_v x (y+1) grid  <> (0, 0) then check_v x (y+1) grid
	  else if check_v x (y+2) grid  <> (0, 0) then check_v x (y+2) grid

	  else if check_h x y grid  <> (0, 0) then check_h x y grid
	  else if check_h (x+1) y grid  <> (0, 0) then check_h (x+1) y grid
	  else if check_h (x+2) y grid  <> (0, 0) then check_h (x+2) y grid

	  else if check_d1 x y grid <> (0, 0) then check_d1 x y grid
	  else if check_d2 x y grid <> (0, 0) then check_d2 x y grid

	  else (0, 0)
	in

	if      check_s 1 1 lGrid <> (0, 0) then check_s 1 1 lGrid
	else if check_s 4 1 lGrid <> (0, 0) then check_s 4 1 lGrid
	else if check_s 7 1 lGrid <> (0, 0) then check_s 7 1 lGrid
	else if check_s 1 4 lGrid <> (0, 0) then check_s 1 4 lGrid
	else if check_s 4 4 lGrid <> (0, 0) then check_s 4 4 lGrid
	else if check_s 7 4 lGrid <> (0, 0) then check_s 7 4 lGrid
	else if check_s 1 7 lGrid <> (0, 0) then check_s 1 7 lGrid
	else if check_s 4 7 lGrid <> (0, 0) then check_s 4 7 lGrid
	else if check_s 7 7 lGrid <> (0, 0) then check_s 7 7 lGrid
	else (0, 0)
		   
		   
  in

  let rec freeSpot y = function
	  []         -> (0, 0)
	| head::tail -> if Util.str_index head '-' != (-1)
					   && checkIfPossible ((Util.str_index head '-')+1) y sGrid lGrid
					then (((Util.str_index head '-')+1), y)
					else freeSpot (y+1) tail
  in
	
  if choiceIA 'X' <> (0, 0) then choiceIA 'X'
  else if choiceIA 'O' <> (0, 0) then choiceIA 'O'
  else freeSpot 1 lGrid


		 

let() =
	Draw.drawEmptyGrid ();
	let rec main_loop n sGrid lGrid = 
	  begin
		let p = (if (n mod 2) = 1 then "O" else "X") in
		print_endline ((if p = "X" then Util.p1Name else Util.p2Name)
					   ^ "'s turn to play.");
		let (x, y) = if (n mod 2) = 1 && Util.nbPlayers = 1
					 then megaChoiceIA sGrid lGrid 
					 else begin
						 if Util.isGui = true
						 then Draw.waitMouse()
						 else waitKeyboard()
					   end in
		if (checkIfPossible x y sGrid lGrid) = false
		then (print_endline "Illegal move.";
			  main_loop n sGrid lGrid)
		else
		  begin
			Draw.updateWindow x y p;
			let lGrid = Util.setGrid x y p lGrid in
			match checkVictory sGrid lGrid p "l" with
			  (s, l) -> let sGrid = s in
						let lGrid = l in
						match checkVictory sGrid lGrid p "s" with
						  (s, l) -> let sGrid = s in
									let lGrid = l in							
								print_lGrid lGrid;
			 					print_endline "";
								main_loop (n + 1) sGrid lGrid
		  end
	  end
	in main_loop 1 Util.sGrid Util.lGrid

