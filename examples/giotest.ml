open StdLabels
module Unix = UnixLabels
open GMain

let l = Main.init ()

let ch = Io.channel_of_descr Unix.stdin
let w = GWindow.window ~width:300 ~height:200 ()
let text = GText.view ~packing:w#add ()

let () =
  prerr_endline "Input some text on <stdin>";
  Io.add_watch ch ~cond:`IN ~callback:
    begin fun () -> 
      let buf = String.create 128 in
      let len = Unix.read Unix.stdin ~buf ~pos:0 ~len:1 in
      if len = 0 then w#destroy ();
      text#buffer#insert (String.sub buf ~pos:0 ~len);
      true
    end;
  w#connect#destroy quit;
  w#show ();
  main ()
