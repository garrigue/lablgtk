(* $Id$ *)

(* An experiment on using libglade in lablgtk *)

(* labgladecc project1.glade > project1.ml *)
#use "project1.ml";;

class editor () =
  object (self)
    inherit window1 ()

    method open_file () =
      let fs = GWindow.file_selection ~title:"Open file" ~modal:true () in
      fs#cancel_button#connect#clicked ~callback:fs#destroy;
      fs#ok_button#connect#clicked ~callback:
        begin fun () ->
          self#textview1#get_buffer#set_text "";
          fs#destroy ()
        end;
      fs#show ()

    initializer
      self#bind ~name:"on_open1_activate" ~callback:self#open_file
  end

let main () =
  let editor = new editor () in
  (* show bindings *)
  Glade.print_bindings stdout editor#xml;
  GtkMain.Main.main ()

let _ = main ()
