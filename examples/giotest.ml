open StdLabels
module Unix = UnixLabels
open GMain

let l = Main.init ()

let fd = Unix.stdin (* Unix.openfile "giotest.ml" [Unix.O_RDONLY] 0 *)
let ch = Io.channel_of_descr fd
let w = GWindow.window ~width:300 ~height:200 ()
let buffer = GText.buffer ()
let text = GText.view ~buffer ~packing:w#add ()

let () =
  prerr_endline "Input some text on <stdin>";
  Io.add_watch ch ~prio:0 ~cond:`IN ~callback:
    begin fun () -> 
      let buf = " " in
      (* On Windows, you must use Io.read *)
      let len = Io.read ch ~buf ~pos:0 ~len:1 in
      len = 1 && (buffer#insert buf; true)
    end;
  w#connect#destroy quit;
  w#show ();
  main ()
