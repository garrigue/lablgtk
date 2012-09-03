open Stubs_Gtk;;
Main.init();;
init_type();;
 let w =Window.create (Window.make_params 
	~cont:(fun pl -> fun _ ->pl) 
	~title:"Hello world" 
	~default_width:300 
	~default_height:100 [] ()
	);;
 let b = Button.create (Button.make_params 
	~cont:(fun pl -> fun _ ->pl) 
	~label:"Hello World" [] ()
	);;
 let _ = GtkSignal.connect w 
	~sgn:Widget.S.destroy 
	~callback:Main.quit
 and _ = GtkSignal.connect b 
	~sgn:Button.S.clicked 
	~callback:(fun () -> prerr_endline "Hello World")
 and _ = GtkSignal.connect b 
	~sgn:Button.S.clicked 
	~callback:Main.quit;;
 Container.add w b;;
 Widget.show b;;
 Widget.show w;;
 Main.main();;