(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    There is no specific licensing policy, but you may freely           *)
(*    take inspiration from the code, and copy parts of it in your        *)
(*    application.                                                        *)
(*                                                                        *)
(**************************************************************************)

(* This file demonstrates how one can add and connect to a custom key binding.
 * Do:
 * ocamlc -c -I +lablgtk2 key_binding.ml
 * ocamlc -o key_binding.tpo -g -I . -I +lablgtk2 lablgtk.cma key_binding.cmo
 * ./key_binding.tpo
 *
 * Just hit [Enter] within the text field.
 *)

module MessageText =
  struct
	module S =
	  struct
		let key_press =
		  { GtkSignal.name="key_press"
		  ; classe=`textview
		  ; marshaller=fun f argv ->
			match Gobject.Closure.get_args argv with
			| _ :: `INT n :: `STRING s :: _ -> f n s
			| _ -> assert false }
	  end
	class view_signals obj =
	  object(self)
		inherit GText.view_signals obj
		method key_press = self#connect S.key_press
	  end
	class view obj =
	  object(self)
		inherit GText.view_skel obj
		method connect = new view_signals obj
	  end
	let view ?buffer =
		let parent = Gobject.Type.from_name "GtkTextView" in
		let (_,_,class_size,instance_size) =
		  Gobject.Type.query parent in
		let info = Gobject.Type.create_info ()
		  ~class_size ~instance_size
		  ~class_init: begin fun g_class ->
			prerr_endline "class_init: create signal";
			let _ = GtkSignal.create ()
			  ~name: "key_press"
			  ~itype: (Gobject.Type.of_class g_class)
			  ~flags: [`RUN_FIRST; `ACTION]
			  ~params: [|`INT; `STRING|]
			  ~return_type: (Gobject.Type.from_name "void") in
			prerr_endline "class_init: add signal";
			let keyname = "Return" in
			let keyval = Gdk.Key.val_from_name keyname in
			GtkMain.Rc.parse_string
			  ("binding \"send-message\"
			  {
			    bind \"Return\" { \"key_press\" ("
			      ^ (string_of_int keyval)
			      ^ ", \""^keyname^"\") }
			  }
			  class \"MessageText\" binding \"send-message\"");
			prerr_endline "class_init: signal added";
		  end in
		let g_type = Gobject.Type.register_static ()
		  ~parent ~info ~name: "MessageText" in
		let create params =
			let obj = Gobject.unsafe_create g_type params in
			GtkObject._ref_and_sink obj; obj in
		GtkText.View.make_params []
		  ~cont: (GContainer.pack_container
		    ~create: begin fun pl ->
			let obj = create [] in
			(match buffer with
			| Some b -> GtkText.View.set_buffer obj b#as_buffer
			| _ -> ());
			Gobject.set_params obj pl; new view obj end)
  end

let locale = GtkMain.Main.init ()

let main () =
	let window = GWindow.window () in
	let _ = window#connect#destroy
	  ~callback: GMain.quit in
	let sw = GBin.scrolled_window ()
	  ~shadow_type: `ETCHED_IN
	  ~hpolicy: `NEVER
	  ~vpolicy: `AUTOMATIC
	  ~packing: window#add in
	let text_input = MessageText.view ()
	  ~packing: sw#add in
	prerr_endline "attach callback";
	let _ = text_input#connect#key_press
	  ~callback: begin fun keyval opt ->
		prerr_endline ("callback: " ^ (string_of_int keyval)
		  ^ " " ^ (Gaux.may_default (fun x -> x) ~opt "None"))
	  end in
	window#set_default_size
	  ~width: 200 ~height: 100;
	window#show ();
	window#move ~x: 10 ~y: 10;
	GMain.main ()
;;
main ()

