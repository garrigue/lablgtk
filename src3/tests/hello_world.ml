
Stubs_GLib.init_type();;
open Stubs_Gtk;;
Main.init();;
init_type();;

let main () =
  let w = Window.create_with_params
    (Window.make_params
     ~cont:(fun pl -> fun _ -> pl)
       ~title:"Hello world"
       ~default_width:300
       ~default_height:100 [] ()
    )
  in
  let b = Button.create_with_params
    (Button.make_params
     ~cont:(fun pl -> fun _ -> pl)
       ~label:"Hello World" [] ()
    )
  in
  ignore(GtkSignal.connect
   w
     ~sgn:Widget.S.destroy
     ~callback:Main.quit
  );
  ignore(GtkSignal.connect
   b
     ~sgn:Button.S.clicked
     ~callback:(fun () -> prerr_endline "Hello World")
  );
  ignore(GtkSignal.connect
   b
     ~sgn:Button.S.clicked
     ~callback:Main.quit
  );
  Container.add w b;
  Widget.show b;
  Widget.show w;
  Main.main()
;;

let _ = main ()