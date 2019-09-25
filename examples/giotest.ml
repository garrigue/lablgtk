(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

open StdLabels
module Unix = UnixLabels

let l = GMain.init ()

let fd = Unix.stdin (* Unix.openfile "giotest.ml" [Unix.O_RDONLY] 0 *)
let ch = GMain.Io.channel_of_descr fd
let w = GWindow.window ~width:300 ~height:200 ()
let buffer = GText.buffer ()
let text = GText.view ~buffer ~packing:w#add ()

let () =
  prerr_endline "Input some text on <stdin>";
  GMain.Io.add_watch ch ~prio:0 ~cond:[`IN; `HUP; `ERR] ~callback:
    begin fun c -> 
      if List.mem `IN c then begin
	let buf = Bytes.create 1 in
	(* On Windows, you must use Io.read *)
	let len = Glib.Io.read ch ~buf ~pos:0 ~len:1 in
	len = 1 && (buffer#insert (Bytes.to_string buf); true) end
      else if List.mem `HUP c then begin
	prerr_endline "got `HUP, exiting in 5s" ;
	GMain.Timeout.add 5000 (fun () -> GMain.quit () ; false) ;
	false end
      else assert false
    end ;
  w#connect#destroy GMain.quit;
  w#show ();
  GMain.main ()
