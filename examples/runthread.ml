(* runthread.ml: Test threads *)
(* lablgtk2 -localdir -thread -noinit runthread.ml *)

open GtkThread

let locale = GMain.init ()
let w = GWindow.window ()
let vbox = GPack.vbox ~packing:w#add ()
let start = GButton.button ~label:"Start" ~packing:vbox#pack ()
let stop = GButton.button ~label:"Stop" ~packing:vbox#pack ()
let text = GEdit.entry ~packing:vbox#pack ()

let cont = ref true
let n = ref 0

let body () =
  prerr_endline "started";
  while !cont do
    incr n;
    async text#set_text (string_of_int !n);
    Thread.delay 1.
  done

let () =
  start#connect#clicked
    (fun () -> cont:= true; ignore (Thread.create body ()));
  stop#connect#clicked (fun () -> cont := false);
  w#connect#destroy GMain.quit;
  w#show ();
  main ()
