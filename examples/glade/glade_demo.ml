(* $Id$ *)

(* An experiment on using libglade in lablgtk *)

let _ = Glade.init ()

let xml = Glade.create ~file:"project1.glade" ~root:"window1"
let _ =
  Glade.add_handler ~name:"on_open1_activate"
    (`Simple(fun () ->
      ignore(GWindow.file_selection ~title:"Open file" ~show:true ())));
  Glade.bind_handlers xml

(* This is to show initialization *)
let ($) f g x = g (f x)
let show_option sh = function None -> "None" | Some x -> "Some " ^ sh x
let f ~handler ~signal ~after ?target obj =
  Printf.printf "object=%s, signal=%s, handler=%s, target=%s\n"
   (Glade.get_widget_name (GtkBase.Widget.cast obj)) signal handler
   (show_option (GtkBase.Widget.cast $ Glade.get_widget_name) target)
let _ = Glade.signal_autoconnect xml ~f; flush stdout

let _ = GtkMain.Main.main ()
