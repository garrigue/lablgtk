open StdLabels
module Unix = UnixLabels
open GMain

let l = Main.init ()

let ch = Io.channel_of_descr Unix.stdin
let w = GWindow.window ()
let text = GEdit.text ~packing:w#add ()

let () =
  Io.add_watch ch ~cond:`IN ~callback:
    begin fun () -> 
      let buf = String.create 128 in
      let len = Unix.read Unix.stdin ~buf ~pos:0 ~len:1 in
      text#insert (String.sub buf ~pos:0 ~len);
      true
    end;
  w#connect#destroy quit;
  w#show ();
  main ()
