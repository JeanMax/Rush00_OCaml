(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Util.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mcanal <zboub@42.fr>                       +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/07 23:34:17 by mcanal            #+#    #+#             *)
(*   Updated: 2015/11/08 19:37:59 by mcanal           ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let lGrid = ["---------";
			 "---------";
			 "---------";
			 "---------";
			 "---------";
			 "---------";
			 "---------";
			 "---------";
			 "---------"] 

let sGrid = ["---";
			 "---";
			 "---"]


let rec askIsGui () =
  print_endline "Read input from mouse?! (y/n)";
  let s = read_line () in
  if String.length s = 0 then askIsGui ()
  else 
  match s.[0] with
	'y' -> true
  | 'n' -> false
  | _   -> askIsGui ()
		  
let isGui = askIsGui()
			  
let rec askNPlayers () =
  print_endline "1 or 2 player(s) game? (1/2)";
  let s = read_line () in
  if String.length s = 0 then askNPlayers ()
  else 
  match s.[0] with
	'1' -> 1
  | '2' -> 2
  | _   -> askNPlayers ()
	
let nbPlayers = askNPlayers ()

let rec askP1Name () =			  
  print_endline "Player1 name?";
  match (read_line ()) with
	"" ->  print_endline "Cannot be empty."; askP1Name ()
  | s  -> s
	
let p1Name = askP1Name ()

let rec askP2Name () =			  
  print_endline "Player2 name?";
  match (read_line ()) with
	""                -> print_endline "Cannot be empty."; askP2Name ()
  | s when s = p1Name -> print_endline "Player1 already took that name.";
						 askP2Name ()
  | s                 -> s

let p2Name = if nbPlayers = 2 then askP2Name ()
			 else if p1Name = "X" then "O"
			 else "X"
 					   
let rec list_replace n x = function
    []                    -> []
  | _::tail when n = 0    -> x::tail
  | head::tail            -> head::(list_replace (n - 1) x tail)

let string_replace n x s =
    (String.sub s 0 n) ^ x ^ (String.sub s (n + 1) (String.length s - 1 - n))

(* /!\ not out of range protected! /!\ *)
let getGrid x y grid=
  (List.nth grid (y-1)).[x-1]

(* /!\ not out of range protected! /!\ *)
let setGrid x y p grid =
  list_replace (y-1) (string_replace (x-1) p (List.nth grid (y-1))) grid

let str_index s c = 
  let rec zboub s lim i c =
	if i >= lim then (-1)
	else if s.[i] = c then i 
	else zboub s lim (i + 1) c
  in zboub s (String.length s) 0 c
	
let str_rindex s c = 
  let rec zboub s i c =
	if i < 0 then (-1)
	  else if s.[i] = c then i
	else zboub s (i - 1) c
  in zboub s (String.length s - 1) c

