(* $Id$ *)

let test_string2 = String.concat ~sep:"" [
  "<html>\n";
  "<head><title>The Gtk/XmHTML test</title></head>\n";
  "This is the Gtk/XmHTML test program<p>\n";
  "You can invoke this program with a command line argument, like this:\n";
  "<hr>";
  "<tt>./xtest filename.html</tt>";
  "<hr>";
  "Click here to load a different <a href=\"nothing\">test message</a>";
  "</html>";
]

let read_file file =
  let ic = open_in file in
  let b = Buffer.create 16384 and s = String.create 1024 and len = ref 0 in
  while len := input ic ~buf:s ~pos:0 ~len:1024; !len > 0 do
    Buffer.add_substring b s ~pos:0 ~len:!len
  done;
  Buffer.contents b

open GMain

let _ =
  let w = GWindow.window ~width:600 ~height:500 () in
  w#connect#destroy ~callback:Main.quit;
  let source =
    if Array.length Sys.argv > 1 then begin
      Sys.chdir (Filename.dirname Sys.argv.(1));
      read_file (Filename.basename Sys.argv.(1))
    end
    else test_string2 in
  let html = GHtml.xmhtml ~source ~packing:w#add () in
  html#set_anchor_buttons false;
  html#set_anchor_underline [`SINGLE;`DASHED];
  w#show ();
  Main.main ()
