(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let _ = GMain.init ()

let css_provider_from_data data =
  let provider = GObj.css_provider () in
  provider#load_from_data data;
  provider

let () =
  GtkData.StyleContext.add_provider_for_screen
    (Gdk.Screen.default ())
    (css_provider_from_data "* { color: blue }")#as_css_provider
    GtkData.StyleContext.ProviderPriority.application

let window = GWindow.window ~border_width: 10 ()

let () =
  window#misc#style_context#add_provider (* Does not cascade! *)
    (css_provider_from_data "* { background-color: red }")
    GtkData.StyleContext.ProviderPriority.application

let button = GButton.button ~label:"Hello World" ~packing: window#add ()

let main () =
  window#event#connect#delete 
    ~callback:(fun _ -> prerr_endline "Delete event occured"; true);
  window#connect#destroy ~callback:GMain.quit;
  button#connect#clicked ~callback:(fun () -> prerr_endline "Hello World");
  button#connect#clicked ~callback:window#destroy;
  window#show ();
  GMain.main ()

let _ = Printexc.print main ()
