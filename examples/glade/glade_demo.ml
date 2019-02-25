(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

(* An experiment on using libglade in lablgtk *)

(* lablgladecc3 project1.ui > project1.ml *)
(* #use "project1.ml";; *)

open Project1

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s

class editor () =
  object (self)
    inherit window1 ()

    method open_file () =
     let fileSel = GWindow.file_chooser_dialog
       ~action:`OPEN
       ~title:"Open file"
       ~modal:true
       ~type_hint:`DIALOG
       ~position:`CENTER
       () in
     fileSel#add_select_button_stock `OPEN `OK;
     fileSel#add_button_stock `CANCEL `CANCEL;
     (match fileSel#run () with
      | `OK ->
          (match fileSel#filename with
              Some fn -> self#textview1#buffer#set_text (load_file fn)
            | None -> ())
      | `CANCEL -> ()
      | `DELETE_EVENT -> ()) ;
     fileSel#destroy ()

    initializer
      self#textview1#buffer#set_text "A text editor skeleton. Only File/Open and Help/About are implemented." ;
      self#open1#connect#activate ~callback:self#open_file;
      self#about1#connect#activate ~callback:(fun () ->
       let d =
        GWindow.about_dialog
         ~name:"Editor skeleton"
         ~authors:["Anonymous coward"]
         () in
       d#set_logo (GMisc.image ~file:"logo.jpg" ())#pixbuf ;
       d#show ());
      ()
  end

let main () =
  let editor = new editor () in
  (* show bindings *)
  editor#window1#connect#destroy ~callback:GMain.quit;
  GMain.main ()

let _ = main ()
