(* $Id$ *)

(* An experiment on using libglade in lablgtk *)

class window1 ~file =
  let xml = Glade.create ~file ~root:"window1" in
  object (self)
    val window1 =
      new GWindow.window (GtkWindow.Window.cast
                            (Glade.get_widget xml ~name:"window1"))
    val text1 =
      new GEdit.text (GtkEdit.Text.cast
                       (Glade.get_widget xml ~name:"text1"))
    method xml = xml

    method open_file () =
      let fs = GWindow.file_selection ~title:"Open file" ~modal:true () in
      fs#cancel_button#connect#clicked ~callback:fs#destroy;
      fs#ok_button#connect#clicked ~callback:
        begin fun () ->
          text1#delete_text ~start:0 ~stop:text1#length;
          fs#destroy ()
        end;
      fs#show ()
    initializer
      Glade.bind_handlers xml
        ~extra:["on_open1_activate", `Simple self#open_file];
      text1#set_editable true
  end

(* This is to show bindings *)
let ($) f g x = g (f x)
let show_option sh = function None -> "None" | Some x -> "Some " ^ sh x
let f ~handler ~signal ~after ?target obj =
  Printf.printf "object=%s, signal=%s, handler=%s, target=%s\n"
   (Glade.get_widget_name (GtkBase.Widget.cast obj)) signal handler
   (show_option (GtkBase.Widget.cast $ Glade.get_widget_name) target)

let main () =
  Glade.init ();
  let window1 = new window1 ~file:"project1.glade" in
  (* show bindings *)
  Glade.signal_autoconnect window1#xml ~f; flush stdout;
  GtkMain.Main.main ()

let _ = main ()
