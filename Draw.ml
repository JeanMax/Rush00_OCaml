let drawEmptyGrid () =
	Graphics.open_graph " 900x900";
	Graphics.moveto 100 0; Graphics.lineto 100 900;
	Graphics.moveto 200 0; Graphics.lineto 200 900;
	Graphics.moveto 400 0; Graphics.lineto 400 900;
	Graphics.moveto 500 0; Graphics.lineto 500 900;
	Graphics.moveto 700 0; Graphics.lineto 700 900;
	Graphics.moveto 800 0; Graphics.lineto 800 900;
	Graphics.moveto 0 100; Graphics.lineto 900 100;
	Graphics.moveto 0 200; Graphics.lineto 900 200;
	Graphics.moveto 0 400; Graphics.lineto 900 400;
	Graphics.moveto 0 500; Graphics.lineto 900 500;
	Graphics.moveto 0 700; Graphics.lineto 900 700;
	Graphics.moveto 0 800; Graphics.lineto 900 800;
	Graphics.set_color 0xFF0000;
	Graphics.set_line_width 3;
	Graphics.moveto 300 0; Graphics.lineto 300 900;
	Graphics.moveto 600 0; Graphics.lineto 600 900;
	Graphics.moveto 0 300; Graphics.lineto 900 300;
	Graphics.moveto 0 600; Graphics.lineto 900 600

let displayP1 x y =
	Graphics.set_color 0x0000FF;
	Graphics.set_line_width 3;
	Graphics.draw_circle ((x * 100) - 50) (900 - ((y * 100) - 50)) 40

let displayP2 x y =
	Graphics.set_color 0x339933;
	Graphics.set_line_width 3;
	Graphics.moveto ((x * 100) - 80) (900 - (y * 100) + 80);
	Graphics.lineto ((x * 100) - 20) (900 - (y * 100) + 20);
	Graphics.moveto ((x * 100) - 20) (900 - (y * 100) + 80);
	Graphics.lineto ((x * 100) - 80) (900 - (y * 100) + 20)

let updateWindow x y p =
	if p = "O" then displayP1 x y
	else if p = "X" then displayP2 x y

let waitMouse () =
	let status = Graphics.wait_next_event ([Graphics.Button_up]) in
	(* (status.mouse_x, status.mouse_y); *)
	let x = ((status.mouse_x / 100) + 1) in
	let y = (9 - (status.mouse_y / 100))in
	(x, y)

let gridWins x y p = (* Draw.gridWins (((x - 1) / 3) + 1) (((y - 1) / 3) + 1) "O"; *)
	if p = "O" then
		begin
			Graphics.set_color 0x0000FF;
			Graphics.set_line_width 9;
			Graphics.draw_circle ((x * 300) - 150) (900 - ((y * 300) - 150)) 120
		end
	else
		begin
			Graphics.set_color 0x339933;
			Graphics.set_line_width 9;
			Graphics.moveto ((x * 300) - 240) (900 - (y * 300) + 240);
			Graphics.lineto ((x * 300) - 60) (900 - (y * 300) + 60);
			Graphics.moveto ((x * 300) - 60) (900 - (y * 300) + 240);
			Graphics.lineto ((x * 300) - 240) (900 - (y * 300) + 60)
		end
