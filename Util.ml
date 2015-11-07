(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Util.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mcanal <zboub@42.fr>                       +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/07 23:34:17 by mcanal            #+#    #+#             *)
(*   Updated: 2015/11/08 00:27:01 by mcanal           ###   ########.fr       *)
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
			 "---------";] 

let sGrid = "---------"

let rec askNPlayers () =
  print_endline "1 or 2 player(s) game? (1/2)";
  match (read_line ()).[0] with
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
					   
