(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mcanal <zboub@42.fr>                       +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/07 23:36:09 by mcanal            #+#    #+#             *)
(*   Updated: 2015/11/08 14:36:02 by mcanal           ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(* just to let you know:
let print_grid () =
  print_string ( 
	  ((String.sub (List.nth Util.lGrid 0) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 1) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 2) 0 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 0) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 1) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 2) 3 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 0) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 1) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 2) 6 3)) ^ "\n"

	  ^ "-----------\n"

	  ^ ((String.sub (List.nth Util.lGrid 3) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 4) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 5) 0 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 3) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 4) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 5) 3 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 3) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 4) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 5) 6 3)) ^ "\n"

	  ^ "-----------\n"

	  ^ ((String.sub (List.nth Util.lGrid 6) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 7) 0 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 8) 0 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 6) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 7) 3 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 8) 3 3)) ^ "\n"

	  ^ ((String.sub (List.nth Util.lGrid 6) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 7) 6 3)) ^ "|"
	  ^ ((String.sub (List.nth Util.lGrid 8) 6 3)) ^ "\n"
	)
 *)


  
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



let rec print_sGrid = function
  []           -> ()
  | head::tail -> print_endline head; print_sGrid tail


let rec waitKeyboard () =
  let ft_string_all f str =
	let rec zboub n =
      if n >= 0 then f(str.[n]) && zboub(n - 1) else true
	in zboub (String.length str - 1) in

  let str_index s c = 
	let rec zboub s lim i c =
	  if i >= lim then (-1)
	  else if s.[i] = c then i 
	  else zboub s lim (i + 1) c
	in zboub s (String.length s) 0 c in
  
  let str_rindex s c = 
	let rec zboub s i c =
	  if i < 0 then (-1)
	  else if s.[i] = c then i
	  else zboub s (i - 1) c
  in zboub s (String.length s - 1) c in

  let s = read_line () in
  let i = str_index s ' ' in

  if i != (-1) && str_rindex s ' ' = i && String.length s < 4 
	 && ft_string_all (fun x -> (x >= '1' && x <= '9') || x = ' ') s
  then (int_of_string (String.sub s (i + 1) (String.length s - 1 - i)),
		int_of_string (String.sub s 0 i))
  else (print_endline "Incorrect format."; waitKeyboard ())



let checkIfPossible x y sGrid lGrid = (* TODO : a finir !!! *)
  let c = Util.getGrid x y lGrid in
   c != 'X' && c != 'O'


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
      (Util.setGrid (x+2) (y+2) "/" sGrid)))))))) )


(* TODO: test this big ugly function... *)
let checkVictory sGrid lGrid p =

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
	&& c = Util.getGrid (x-1) (y-1) grid
	&& c = Util.getGrid (x-2) (y-2) grid in

  let checkSquare x y n grid =
	if checkHor x y grid || checkHor x (y+1) grid || checkHor x (y+2) grid 
	   || checkVer x y grid || checkVer (x+1) y grid || checkVer (x+2) y grid 
	   || checkDiag1 x y grid || checkDiag2 (x+2) y grid
	then begin if n = 0
			   then (print_endline (p ^ " wins the game!"); exit 0) 
					(* TODO: remove exit if we can launch new game *)
			   else print_endline (p ^ " wins the grid " ^ 
									 (string_of_int n) ^ "!");
					(* TODO: update lGrid/sGrid *)  
			   true
		 end 
	else false in

  (* checkLVictory *)
  ignore(checkSquare 1 1 1 lGrid);
  ignore(checkSquare 4 1 2 lGrid);
  ignore(checkSquare 7 1 3 lGrid);
  ignore(checkSquare 1 4 4 lGrid);
  ignore(checkSquare 4 4 5 lGrid);
  ignore(checkSquare 7 4 6 lGrid);
  ignore(checkSquare 1 7 7 lGrid);
  ignore(checkSquare 4 7 8 lGrid);
  ignore(checkSquare 7 7 9 lGrid);

  (* checkSVictory *)
  checkSquare 1 1 0 sGrid (* TODO: launch new game if this return true *)


  


let() =
  (* match updateGrids 4 7 "X" Util.sGrid Util.lGrid with
	(s, l) -> let sGrid = s in
			  let lGrid = l in

			 print_lGrid lGrid;
			 print_endline "";
			 print_sGrid sGrid *)

	Draw.drawEmptyGrid ();
	let rec main_loop n sGrid lGrid = 
		if n = 0 then exit 1
		else
			begin
				let p = (if (n mod 2) = 1 then "O" else "X") in
				print_endline ((if p = "O" then Util.p1Name else Util.p2Name) ^ "'s turn to play.");
				let (x, y) = Draw.waitMouse()
				in 
				if (checkIfPossible x y sGrid lGrid) = false then main_loop n sGrid lGrid
				else 
					Draw.updateWindow x y p;
					let lGrid = Util.setGrid x y p lGrid in
					checkVictory sGrid lGrid p; (* (TODO: a finir) *)
					print_lGrid lGrid;
			 		print_endline "";
					print_sGrid sGrid;
					main_loop (n + 1) sGrid lGrid
			end
		in main_loop 6 Util.sGrid Util.lGrid