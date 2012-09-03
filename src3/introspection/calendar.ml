open Stubs_Gtk;;
Main.init();;
init_type();;
 let w =Window.create (Window.make_params 
	~cont:(fun pl -> fun _ ->pl) 
	~title:"Caendar" 
	~default_width:300 
	~default_height:100 [] ()
	);;
 let _ = GtkSignal.connect w 
	~sgn:Widget.S.destroy 
	~callback:Main.quit
	
let cal = Calendar.create (Calendar.make_params
	~cont:(fun pl -> fun _ ->pl) [] ());;
 Container.add w cal;;
  Widget.show cal;;
 Widget.show w;;
 Main.main();;