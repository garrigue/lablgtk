(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)
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
  GMain.init ();
  start#connect#clicked
    (fun () -> cont:= true; ignore (Thread.create body ()));
  stop#connect#clicked (fun () -> cont := false);
  w#connect#destroy GMain.quit;
  w#show ();
  GMain.main ()
