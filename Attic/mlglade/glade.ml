open Error
open Xml

exception No_such_data
exception Empty_field

let program_name = ref ""

let fst2 (x,y,z) = x
let snd2 (x,y,z) = y
let thr2 (x,y,z) = z

let gen_split c v = 
  let my_list = ref [] in
  let counter = ref 0 in
  let max = String.length v in
  let current_pos = ref 0 in
    (try 
       while !counter<max do
	 let new_pos = String.index_from v !current_pos c in
	   my_list := 
	   (String.sub v !current_pos (new_pos - !current_pos)) ::!my_list;
	   current_pos := new_pos + 1;
       done
     with  Not_found ->
       my_list := 
     (String.sub v !current_pos (max - !current_pos)) ::!my_list;
    );
    !my_list


let line_split = gen_split '\n'

    
let out_some = function Some x -> x 
  | None -> error "Invalid glade file: missing field. Please report"
 
type project = 
    {name : string ;
     program_name : string ; 
     source_directory : string ;
     pixmaps_directory : string ;
     language : string ;
     gnome_support : bool ;
     gettext_support : bool ;
    }

let current_window_name = ref ""
let pixmaps_directory = ref ""

type window_type_t = Toplevel | Dialog | Popup

exception Not_predefined

(* This might produce non typable programs. 
But this is very useful. Should we ignore that ?*)
let to_lablgtk_call s = match s with 
  | "gtk_main_quit" -> "GtkMain.Main.quit ()\n"
  | "gtk_true" -> "true\n"
  | "gtk_false" -> "false\n"
  | "gtk_widget_show" (* these need to know the current widget and
 then to emit something like 
 [self#top_!current_window#!current_widget#misc#[show...]].*)
  | "gtk_widget_hide"
  | "gtk_widget_grab_focus"
  | "gtk_window_activate_default"
  | "gtk_widget_destroy" 
  | _ -> raise Not_predefined


let to_window_type_t s = match s with  
  | Some "GTK_WINDOW_TOPLEVEL" -> Some "`TOPLEVEL"
  | Some "GTK_WINDOW_DIALOG" -> Some  "`DIALOG"
  | Some "GTK_WINDOW_POPUP" -> Some "`POPUP"
  | None -> None
  | Some s -> error ("unknown window_type "^s^"\n")


let bool_to_caml = function true -> "true" | false -> "false"

let to_window_position = function 
  | Some "GTK_WIN_POS_MOUSE" -> Some "`MOUSE"
  | Some "GTK_WIN_POS_NONE" -> Some "`NONE"
  | Some "GTK_WIN_POS_CENTER" -> Some "`CENTER"
  | Some "GTK_WIN_POS_CENTER_ALWAYS" -> Some "`CENTER_ALWAYS"
  | Some s -> error ("unknown window_position_t "^s^"\n")
  | None -> None

type std_sig_handler =
    {signal_name : string ; 
     signal_handler_path : string ; 
     default_args : string ; 
     default_code : string}

type raw_sig_handler =
    {
      raw_signal_name : string;
      raw_default_code: string
    }

type signal_handler = 
    Standard of std_sig_handler
  | Raw of raw_sig_handler

type signal = 
    { sig_handler : signal_handler ; 
      sig_handler_name : string ; 
      sig_object : string list;
      sig_data : string list;
      sig_stamp : string;
      sig_after: bool option }

exception Unknown_event of string

let rec string_to_sig_handler handler_name parent_class widget_name s = 
  let to_default default =
    try
      to_lablgtk_call handler_name
    with Not_predefined -> default 
  in
  match s with
    | "other_event" -> (* WHERE DOES IT COME FROM ????*)
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "()";
	     default_code = to_default  
	( "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }
    | "selection_clear_event" | "selection_request_event"
    | "selection_notify_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: GdkEvent.Selection.t)";
	     default_code = to_default  
(	       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }

    | "proximity_in_event" | "proximity_out_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: GdkEvent.Proximity.t)";
	     default_code = to_default  
	(       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }

    | "property_notify_event"->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: GdkEvent.Property.t)";
	     default_code = to_default  
(	       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }
	    
    | "motion_notify_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: GdkEvent.Motion.t)";
	     default_code = to_default  
	(       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }
    | "unmap_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: [`UNMAP] Gdk.event)";
	 default_code = to_default  
(	       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}

    | "map_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: [`MAP] Gdk.event)";
	 default_code = to_default  
	(       "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "key_press_event" | "key_release_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	     signal_handler_path = "event#connect#";
	     default_args = "(event: GdkEvent.Key.t)";
	 default_code = to_default  
(	   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}

    | "focus_in_event" | "focus_out_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: GdkEvent.Focus.t)";
	 default_code = to_default  
	(   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	    }
    | "expose_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: GdkEvent.Expose.t)";
	 default_code = to_default  
(	   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "enter_notify_event" | "leave_notify_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: GdkEvent.Crossing.t)";
	 default_code = to_default  
	(   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "delete_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: [`DELETE] Gdk.event)";
	 default_code = to_default  
(	   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "configure_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: GdkEvent.Configure.t)";
	 default_code = to_default  
	(   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "button_press_event" | "button_release_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: GdkEvent.Button.t)";
	 default_code = to_default  
(	   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}

    | "destroy_event" ->
	let n = Filename.chop_suffix s "_event" in
	  Standard
	    {signal_name = n;
	 signal_handler_path = "event#connect#";
	 default_args = "(event: [`DESTROY] Gdk.event)";
	 default_code = to_default  
	(   "prerr_endline \"Event "^s^" from "^widget_name^"\";false (*transmit to parent*)")
	}
    | "event" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "event#connect#any";
	 default_args = "(event:Gdk.Tags.event_type Gdk.event)";
	 default_code = to_default ("prerr_endline \"Event "^s^" from "^widget_name^"\";false ")}
    | "activate" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#activate";
	 default_args = "()";
	 default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
    | "changed" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#changed";
	 default_args = "()";
	 default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
    | "delete_text" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#delete_text";
	 default_args = "(start:int) (stop:int)";
	 default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
    | "insert_text" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#insert_text";
	 default_args = "(text:string) (pos:int)";
	 default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
    | "deselect" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#deselect";
	 default_args = "()";
	 default_code = to_default ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
  | "select" ->
	Standard
	  {signal_name = "";
	 signal_handler_path = "connect#select";
	 default_args = "()";
	 default_code = to_default ("prerr_endline \"Event "^s^" from "^widget_name^"\";() ")}
    | "draw" | "size_allocate" as s -> 
	Standard
	  {
	  signal_name = s;
	  signal_handler_path = "coerce#misc#connect#";
	  default_args = "(rectangle:Gtk.rectangle)";
	  default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	} 
    | "state_changed" as s -> 
	Standard
	  {
	  signal_name = s;
	  signal_handler_path = "coerce#misc#connect#";
	  default_args = "(state_type:Gtk.Tags.state_type)";
	  default_code = to_default  ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	}
    | "parent_set" as s -> 
	Standard
	  {
	  signal_name = s;
	  signal_handler_path = "coerce#misc#connect#";
	  default_args = "(widget_option:GObj.widget option)";
	  default_code = to_default ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	}

    | "show" | "realize" | "parent_set" | "hide" | "destroy"
    | "map" | "style_set" | "unmap" | "draw" as s ->
	(* All the GOBj.misc_signals*)
	Standard
	  {
	    signal_name = s;
	    signal_handler_path = "coerce#misc#connect#";
	    default_args = "()";
	    default_code = to_default ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	  }

	(* unit returning callbacks specific to widgets *)
    | "clicked" | "enter" | "leave" | "pressed" | "released" | "toggled"
	  (* GtkButton events *)
    | "selection_changed" 
	(* GTree events *)
	->
	  Standard
	    {signal_name = s;
	   signal_handler_path = "connect#";
	   default_args = "()";
	   default_code = to_default
	     ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	  }

    | "remove" as s -> 
	Standard
	  {signal_name = s;
	   signal_handler_path = "connect#";
	   default_args = "(widget:GObj.widget)";
	   default_code = to_default  
	     ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	  }

    | "child_attached" | "child_detached" | "add"
	(* handler_box signals taking a widget as arg for handler*)
      -> 
	Standard
	    {signal_name = s;
	 signal_handler_path = "connect#";
	 default_args = "(widget:GObj.widget)";
	 default_code = to_default  
	   ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	}

    | "drag_data_get" -> 
	let s = "data_get" in
	  Standard
	    {signal_name = s;
	   signal_handler_path = "drag#connect#";
	   default_args = "(drag_context:GObj.drag_context) \
(selection_data:GObj.selection_data) ~(info:int) ~(time:int)";
	   default_code = to_default  
	     ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	  }
    | "drag_data_received" -> 
	let s = "data_received" in
	  Standard
	    {signal_name = s;
	     signal_handler_path = "drag#connect#";
	     default_args = 
	       "(drag_context:GObj.drag_context) ~(x:int) ~(y:int) \
(selection:GObj.selection_data) ~(info:int) ~(time:int)";
	     default_code = to_default  
	    ( "prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	    }
	  
    | "drag_drop"   | "drag_motion" -> 
	let s = String.sub s 5 ((String.length s) - 5 ) in
	  Standard
	    {signal_name = s;
	   signal_handler_path = "drag#connect#";
	   default_args = 
	      "(drag_context:GObj.drag_context) ~(x:int) ~(y:int) ~(time:int)";
	   default_code = to_default  
	     ("prerr_endline \"Event "^s^" from "^widget_name^"\";true")
	  }

    | "drag_leave" -> 
	let s = "leave" in
	  Standard
	    {signal_name = s;
	   signal_handler_path = "drag#connect#";
	   default_args = "(drag_context:GObj.drag_context) ~(time:int)";
	   default_code = to_default  
	     ("prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	  }

    | "drag_data_delete" | "drag_beginning" | "drag_ending" as s  -> 
	let s = String.sub s 5 ((String.length s) - 5 ) in
	  Standard
	    {signal_name = s;
	     signal_handler_path = "drag#connect#";
	     default_args = "(drag_context: GObj.drag_context)";
	     default_code = to_default  
(	       "prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	    }
    | "drag_begin" ->  
	string_to_sig_handler handler_name parent_class widget_name 
	"drag_beginning" 
    | "drag_end" -> 
	string_to_sig_handler handler_name parent_class widget_name
	"drag_ending" 
    | "switch_page" as s -> 
	Standard
	    {signal_name = s;
	     signal_handler_path = "connect#";
	     default_args = "(page:int)";
	     default_code = to_default  
(	       "prerr_endline \"Event "^s^" from "^widget_name^"\";()")
	    }
    | s -> 
	(*i This solution is probably not correct. Until we are sure
we switch back to Unknown_event error.
Printf.printf "Unknown_event %s(using connect_by_name)WARNING THIS IS INCORRECT !\n" s ;
	Raw  {raw_signal_name = s ; 
	      raw_default_code = to_default  "prerr_endline \"Event "^s^" from "^widget_name^"\";()"
	     }
		i*)
	raise (Unknown_event s)

type direction = Vertical | Horizontal

type widget_size_t =
    { height : int option;
      width : int option }
 
type complex_packer_t = 
    { function_of_parent: string;
      coercion_of_child : string;
    }

type parent_packer_t =
    Simple_packer of string
  | Complex_packer of complex_packer_t
  | No_packer

type accelerator_t =
    {
      modifiers : string list;
      key : string;
      signal : string;
    }

type common_properties_t =
    {
      can_default : bool option;
      has_default : bool option;
      can_focus : bool option;
      has_focus : bool option;
      visible : bool option;
      sensitive : bool option;
      events : string list;
      extension_events : string option;
      accelerators : accelerator_t list;
      tooltip : string option;
      child_name : string option;
    }

let emit_option s = match s with None -> "" | Some s -> s 


(* Drawing area is the simplest widget. 
To add new widgets use at least these fields.
*)
type gtk_drawing_area_t = 
    {gtk_drawing_area_name : string;
     gtk_drawing_area_parent_packer : parent_packer_t;
     gtk_drawing_area_signals : signal list;
     gtk_drawing_area_size : widget_size_t;
     gtk_drawing_area_common_properties : common_properties_t;
     gtk_drawing_area_child : gtk_child_t option;
    }
    
(* Another simple widget which has sons and some special 
properties.*)
and gtk_frame_t = 
    {gtk_frame_name : string;
     gtk_frame_parent_packer : parent_packer_t;
     gtk_frame_signals : signal list;
     gtk_frame_size : widget_size_t;
     gtk_frame_common_properties : common_properties_t;
     gtk_frame_child : gtk_child_t option;

     gtk_frame_border_width : int option;
     gtk_frame_label : string option;
     gtk_frame_label_xalign : float option;
     gtk_frame_label_yalign : float option; (* Not in glade...*)
     gtk_frame_shadow_type : string option;
     gtk_frame_widgets : widget list; (* the sons of the widget *)
    }

and gtk_omenu_t = 
    {gtk_omenu_name : string;
     gtk_omenu_parent_packer : parent_packer_t;
     gtk_omenu_signals : signal list;
     gtk_omenu_size : widget_size_t;
     gtk_omenu_common_properties : common_properties_t;
     gtk_omenu_child : gtk_child_t option;

     gtk_omenu_border_width : int option;
     gtk_omenu_initial_choice : int option;
     gtk_omenu_items : string option; (* I will split on output *) 

    }

and gtk_window_t =
    {gtk_window_name : string;
     gtk_window_parent_packer : parent_packer_t;
     gtk_window_title : string option; 
     gtk_window_type : string option;
     gtk_window_position : string option;
     gtk_window_modal : bool option;
     gtk_window_allow_shrink : bool option;
     gtk_window_allow_grow : bool option;
     gtk_window_auto_shrink : bool option;
     gtk_window_widgets : widget list;
     gtk_window_signals : signal list;
     gtk_window_border_width : int option;
     gtk_window_common_properties : common_properties_t;
     gtk_window_size : widget_size_t
    }

and gtk_notebook_t = 
    {gtk_notebook_name : string;
     gtk_notebook_parent_packer : parent_packer_t;
     gtk_notebook_tab_pos : string option;
     gtk_notebook_tab_border : int option;
     gtk_notebook_homogeneous_tab : bool option;
     gtk_notebook_show_border : bool option;
     gtk_notebook_scrollable : bool option;
     gtk_notebook_popup : bool option;
     gtk_notebook_border_width : int option;
     gtk_notebook_size : widget_size_t;
     gtk_notebook_widgets : widget list;
     gtk_notebook_signals : signal list;
     gtk_notebook_common_properties : common_properties_t;
     gtk_notebook_child : gtk_child_t option;
    }

and gtk_combo_t =
    {gtk_combo_name : string;
     gtk_combo_parent_packer : parent_packer_t;
     gtk_combo_border_width : int option;
     gtk_combo_value_in_list : bool option;
     gtk_combo_ok_if_empty : bool option;
     gtk_combo_case_sensitive : bool option;
     gtk_combo_use_arrows : bool option;
     gtk_combo_use_arrows_always : bool option;
     gtk_combo_items : string option;
     gtk_combo_widgets : widget list;
     gtk_combo_signals : signal list;
     gtk_combo_size : widget_size_t;
     gtk_combo_child : gtk_child_t option;
     gtk_combo_common_properties : common_properties_t;
    }

and gtk_box_t =
    {gtk_box_name : string;
     gtk_box_parent_packer : parent_packer_t;
     gtk_box_homogeneous : bool option;
     gtk_box_spacing : int option;
     gtk_box_widgets : widget list;
     gtk_box_signals : signal list;
     gtk_box_size : widget_size_t;
     gtk_box_child : gtk_child_t option;
     gtk_box_common_properties : common_properties_t;
    }

and gtk_table_t =
    {gtk_table_name : string;
     gtk_table_parent_packer : parent_packer_t;
     gtk_table_homogeneous : bool option;
     gtk_table_rows: int option;
     gtk_table_columns: int option;
     gtk_table_row_spacing : int option;
     gtk_table_column_spacing : int option;
     gtk_table_border_width : int option;
     gtk_table_widgets : widget list;
     gtk_table_signals : signal list;
     gtk_table_size : widget_size_t;
     gtk_table_child : gtk_child_t option;
     gtk_table_common_properties : common_properties_t;
    }

and gtk_buttonbox_t =
    {gtk_buttonbox_name : string;
     gtk_buttonbox_parent_packer : parent_packer_t;
     gtk_buttonbox_child_width : int option;
     gtk_buttonbox_child_height : int option;
     gtk_buttonbox_child_ipadx : int option;
     gtk_buttonbox_child_ipady : int option;
     gtk_buttonbox_border_width : int option;
     gtk_buttonbox_layout : string option; 
     (* [ `DEFAULT_STYLE | `SPREAD | `EDGE | `START | `END] *)
     gtk_buttonbox_spacing : int option;
     gtk_buttonbox_widgets : widget list;
     gtk_buttonbox_signals : signal list;
     gtk_buttonbox_child : gtk_child_t option;
     gtk_buttonbox_common_properties : common_properties_t;
    }

and gtk_handlebox_t =
    {gtk_handlebox_name : string;
     gtk_handlebox_parent_packer : parent_packer_t;
     gtk_handlebox_border_width : int option;
     gtk_handlebox_size : widget_size_t;
     gtk_handlebox_widgets : widget list;
     gtk_handlebox_signals : signal list;
     gtk_handlebox_child : gtk_child_t option;
     gtk_handlebox_common_properties : common_properties_t;
    }

and gtk_pan_t =
    {gtk_pan_name : string;
     gtk_pan_parent_packer : parent_packer_t;
     gtk_pan_border_width : int option;
     gtk_pan_handle_size : int option;
     gtk_pan_gutter_size : int option;
     gtk_pan_position : int option;
     gtk_pan_size : widget_size_t;
     gtk_pan_widgets : widget list;
     gtk_pan_signals : signal list;
     gtk_pan_child : gtk_child_t option;
     gtk_pan_common_properties : common_properties_t;
    }

and gtk_statusbar_t =
    {gtk_statusbar_name : string;
     gtk_statusbar_parent_packer : parent_packer_t;
     gtk_statusbar_border_width : int option;
     gtk_statusbar_size :widget_size_t;
     gtk_statusbar_signals : signal list;
     gtk_statusbar_child : gtk_child_t option;
     gtk_statusbar_common_properties : common_properties_t;
    }

and gtk_separator_t =
    {gtk_separator_name : string;
     gtk_separator_parent_packer : parent_packer_t;
     gtk_separator_size : widget_size_t;
     gtk_separator_signals : signal list;
     gtk_separator_child : gtk_child_t option;
     gtk_separator_common_properties : common_properties_t;
    }

and gtk_child_t =
    {padding:int option;
     expand:bool option;
     fill:bool option;
     left_attach: int option;
     right_attach: int option;
     top_attach: int option;
     bottom_attach: int option;
     xpad: int option;
     ypad: int option;
     x: int option;
     y: int option;
     xexpand: bool option;
     yexpand: bool option;
     xshrink: bool option;
     yshrink: bool option;
     xfill: bool option;
     yfill: bool option;
    }

and gtk_button_t =
    {gtk_button_name:string; 
     gtk_button_parent_packer : parent_packer_t;
     gtk_button_can_focus:bool option;
     gtk_button_border_width:int option;
     gtk_button_size : widget_size_t;
     gtk_button_label:string option;
     gtk_button_relief:string option;
     gtk_button_child: gtk_child_t option;
     gtk_button_signals: signal list;
     gtk_button_common_properties : common_properties_t;
     gtk_button_draw_indicator: bool option;
     gtk_button_widgets : widget list;
    }

and gtk_checkb_t = 
    {
      gtk_checkb_name : string;
      gtk_checkb_parent_packer : parent_packer_t;
      gtk_checkb_label : string option;
      gtk_checkb_can_focus : bool option;
      gtk_checkb_active: bool option;
      gtk_checkb_draw_indicator: bool option;
      gtk_checkb_child : gtk_child_t option;
      gtk_checkb_signals : signal list;
      gtk_checkb_common_properties : common_properties_t;
    }

and gtk_tbutton_t =
    {gtk_tbutton_name:string; 
     gtk_tbutton_parent_packer : parent_packer_t;
     gtk_tbutton_can_focus:bool option;
     gtk_tbutton_active:bool option;
     gtk_tbutton_border_width:int option;
     gtk_tbutton_size : widget_size_t;
     gtk_tbutton_label:string option;
     gtk_tbutton_relief:string option;
     gtk_tbutton_child: gtk_child_t option;
     gtk_tbutton_signals: signal list;
     gtk_tbutton_common_properties : common_properties_t;
    }

and gtk_rbutton_t =
    {gtk_rbutton_name:string; 
     gtk_rbutton_parent_packer : parent_packer_t;
     gtk_rbutton_can_focus:bool option;
     gtk_rbutton_has_focus:bool option;
     gtk_rbutton_label:string option;
     gtk_rbutton_active:bool option;
     gtk_rbutton_draw_indicator: bool option;
     gtk_rbutton_group: string option;
     gtk_rbutton_border_width:int option;
     gtk_rbutton_size : widget_size_t;
     gtk_rbutton_relief:string option;
     gtk_rbutton_child: gtk_child_t option;
     gtk_rbutton_signals: signal list;
     gtk_rbutton_common_properties : common_properties_t;
    }

and gtk_toolbar_t =
    {gtk_toolbar_name:string; 
     gtk_toolbar_parent_packer : parent_packer_t;
     gtk_toolbar_can_focus:bool option;
     gtk_toolbar_has_focus:bool option;
     gtk_toolbar_border_width:int option;
     gtk_toolbar_orientation:string option;
     gtk_toolbar_style:string option;
     gtk_toolbar_space_size:int option;
     gtk_toolbar_space_style:string option;
     gtk_toolbar_tooltips : bool option;
     gtk_toolbar_relief:string option;
     gtk_toolbar_draw_indicator: bool option;
     gtk_toolbar_size : widget_size_t;
     gtk_toolbar_child: gtk_child_t option;
     gtk_toolbar_signals: signal list;
     gtk_toolbar_common_properties : common_properties_t;
     gtk_toolbar_widgets : widget list;
    }

and gtk_entry_t = 
    {gtk_entry_name : string;
     gtk_entry_parent_packer : parent_packer_t;
     gtk_entry_can_focus : bool option; 
     gtk_entry_editable : bool option;
     gtk_entry_text_visible : bool option;
     gtk_entry_text_max_length : int option;
     gtk_entry_text : string option;
     gtk_entry_child : gtk_child_t option;
     gtk_entry_signals : signal list;
     gtk_entry_common_properties : common_properties_t;
    }

and gtk_text_t = 
    {gtk_text_name : string;
     gtk_text_parent_packer : parent_packer_t;
     gtk_text_can_focus : bool option; 
     gtk_text_editable : bool option;
     gtk_text_text : string option;
     gtk_text_signals : signal list;
     gtk_text_child : gtk_child_t option;
     gtk_text_common_properties : common_properties_t;
    }

and gtk_tree_t = 
    {gtk_tree_name : string;
     gtk_tree_parent_packer : parent_packer_t;
     gtk_tree_view_line : bool option; 
     gtk_tree_selection_mode : string option;
     gtk_tree_view_mode : string option;
     gtk_tree_signals : signal list;
     gtk_tree_child : gtk_child_t option;
     gtk_tree_common_properties : common_properties_t;
    }

and gtk_label_t = 
    {
      gtk_label_name : string;
      gtk_label_parent_packer : parent_packer_t;
      gtk_label_label : string option;
      gtk_label_justify : string option;
      gtk_label_wrap: bool option;
      gtk_label_xalign : float option;
      gtk_label_yalign : float option;
      gtk_label_xpad : int option;
      gtk_label_ypad : int option;
      gtk_label_child : gtk_child_t option;
      gtk_label_signals : signal list;
      gtk_label_size : widget_size_t;
      gtk_label_common_properties : common_properties_t;}

and gtk_scrolled_window_t = 
    {
      gtk_scrolled_window_name : string;
      gtk_scrolled_window_parent_packer : parent_packer_t;
      gtk_scrolled_window_hscrollbar_policy : string option;
      gtk_scrolled_window_vscrollbar_policy : string option;
      gtk_scrolled_window_hupdate_policy : string option;
      gtk_scrolled_window_vupdate_policy : string option;
      gtk_scrolled_window_child : gtk_child_t option;
      gtk_scrolled_window_signals : signal list;
      gtk_scrolled_window_widgets : widget list;
      gtk_scrolled_window_common_properties : common_properties_t;
    }

and gtk_viewport_t =
    {
      gtk_viewport_name : string;
      gtk_viewport_parent_packer : parent_packer_t;
      gtk_viewport_shadow_type : string option;
      gtk_viewport_hscrollbar_policy : string option;
      gtk_viewport_vscrollbar_policy : string option;
      gtk_viewport_widgets : widget list;
      gtk_viewport_signals : signal list;
      gtk_viewport_child : gtk_child_t option;
      gtk_viewport_common_properties : common_properties_t;
    }

and gtk_fileselection_t =
    {gtk_fileselection_name : string; 
     gtk_fileselection_parent_packer : parent_packer_t;
     gtk_fileselection_title : string option; 
     gtk_fileselection_position : string option;
     gtk_fileselection_modal : bool option;
     gtk_fileselection_allow_shrink : bool option;
     gtk_fileselection_allow_grow : bool option;
     gtk_fileselection_auto_shrink : bool option;
     gtk_fileselection_signals : signal list;
     gtk_fileselection_border_width : int option;
     gtk_fileselection_show_file_op : bool option;
     gtk_fileselection_child : gtk_child_t option;
     gtk_fileselection_common_properties : common_properties_t;
     gtk_fileselection_widgets : widget list;

    }

and gtk_list_t =
    {
      gtk_list_name : string;
      gtk_list_parent_packer : parent_packer_t;
      gtk_list_signals : signal list;
      gtk_list_child : gtk_child_t option;
      gtk_list_selection_mode : string option;
      gtk_list_common_properties : common_properties_t;
    }


and gtk_menubar_t = 
    {
      gtk_menubar_name : string;
      gtk_menubar_parent_packer : parent_packer_t;
      gtk_menubar_shadow_type : string option;
      gtk_menubar_border_width : int option;
      gtk_menubar_widgets : widget list;
      gtk_menubar_signals : signal list;
      gtk_menubar_size : widget_size_t;
      gtk_menubar_child : gtk_child_t option;
      gtk_menubar_common_properties : common_properties_t;
    }

and gtk_menuitem_t = 
    {
      gtk_menuitem_name : string;
      gtk_menuitem_parent_packer : parent_packer_t;
      gtk_menuitem_right_justify : bool option;
      gtk_menuitem_label : string option;
      gtk_menuitem_border_width : int option;
      gtk_menuitem_widgets : widget list;
      gtk_menuitem_signals : signal list;
      gtk_menuitem_size : widget_size_t;
      gtk_menuitem_child : gtk_child_t option;
      gtk_menuitem_common_properties : common_properties_t;
    }

and gtk_pixmap_t = 
    {
      gtk_pixmap_name : string;
      gtk_pixmap_parent_packer : parent_packer_t;
      gtk_pixmap_can_focus : bool option;
      gtk_pixmap_has_focus : bool option;
      gtk_pixmap_build_insensitive : bool option;
      gtk_pixmap_xalign : float option;
      gtk_pixmap_yalign : float option;
      gtk_pixmap_xpad : int option;
      gtk_pixmap_ypad : int option;
      gtk_pixmap_filename : string option;
      gtk_pixmap_widgets : widget list;
      gtk_pixmap_signals : signal list;
      gtk_pixmap_size : widget_size_t;
      gtk_pixmap_child : gtk_child_t option;
      gtk_pixmap_common_properties : common_properties_t;
    }


and widget =
  | GtkDrawingArea of gtk_drawing_area_t
  | GtkFrame of gtk_frame_t    
  | GtkOptionMenu of gtk_omenu_t    

  | GtkCombo of gtk_combo_t
  | GtkWindow of gtk_window_t
  | GtkNotebook of gtk_notebook_t
  | GtkVBox of gtk_box_t
  | GtkHBox of gtk_box_t
  | GtkTable of gtk_table_t
  | GtkFixed of gtk_table_t
  | GtkHButtonBox of gtk_buttonbox_t
  | GtkVButtonBox of gtk_buttonbox_t
  | GtkStatusBar of gtk_statusbar_t
  | GtkHandleBox of gtk_handlebox_t
  | GtkHPan of gtk_pan_t
  | GtkVPan of gtk_pan_t
  | GtkButton of gtk_button_t
  | GtkToggleButton of gtk_tbutton_t
  | GtkRadioButton of gtk_rbutton_t
  | GtkToolbar of gtk_toolbar_t
  | GtkEntry of gtk_entry_t
  | GtkLabel of gtk_label_t
  | GtkCheckb of gtk_checkb_t
  | GtkScrolledWindow of gtk_scrolled_window_t
  | GtkViewPort of gtk_viewport_t
  | GtkText of gtk_text_t
  | GtkTree of gtk_tree_t
  | GtkHSeparator of gtk_separator_t
  | GtkVSeparator of gtk_separator_t
  | GtkFileSelection of gtk_fileselection_t
  | GtkMenuBar of gtk_menubar_t
  | GtkMenu of gtk_menuitem_t
  | GtkMenuItem of gtk_menuitem_t
  | GtkPixmap of gtk_pixmap_t
  | Placeholder
  | GtkList of gtk_list_t

let rec find_first_field f l = match l with
    [] -> None
  | (Eelement (n,_,e))::r when n=f ->  Some (r,e)
  | Eempty (n,_)::r when n=f -> raise Empty_field
  | _::r -> find_first_field f r

let rec find_all_fields f l = 
  try 
    match find_first_field f l with 
	Some (r,e) -> 
	  (Eelement (f,[],e))::(find_all_fields f r)
      | None -> []
  with
      Empty_field -> error "empty widget in find_all_fields"

let find_first_string s l =
  try 
    match find_first_field s l  with	
	Some (_ , ((Echunk s)::_ as l)) -> 
	  Some (List.fold_left (fun acc x -> 
				  match x with 
				    | Echunk s -> acc^s
				    | _ -> error "Not a chunk in find_first_string") 
		  "" l)
      | _ -> None
  with 
      Empty_field -> None

let rec find_all_strings f w = 
  match w with 
    | [] -> []
    | (Eelement (n,_,(Echunk s)::_))::r when n=f -> 
      s::(find_all_strings f r)
    | _::r -> find_all_strings f r

let find_first_bool s l =
  match find_first_string s l with
    | Some s -> Some (s="True")
    | None -> None

let find_first_int s l =
  match find_first_string s l with
    | Some s -> Some (int_of_string s)
    | None -> None

let find_first_float s l =
  match find_first_string s l with
    | Some s -> Some (float_of_string s)
    | None -> None

let analyze_size w =
   {height = find_first_int "height" w;
    width = find_first_int "width" w}

let analyze_project w = 
  { name = out_some (find_first_string "name" w);
    program_name = 
      begin
	let n = out_some (find_first_string "program_name" w) in
	  program_name:= n;
	  n
      end;
    source_directory = out_some (find_first_string "source_directory" w) ;
    pixmaps_directory = 
      (let p = out_some (find_first_string "pixmaps_directory" w) in
	pixmaps_directory := p ; p);
    language = out_some (find_first_string "language" w);
    gnome_support = 
      (try out_some (find_first_bool "gnome_support" w) with _ -> false );
      gettext_support = out_some (find_first_bool "gettext_support" w);
  }

let rec analyze_signals parent_class widget_name wl = 
  match wl with
      [] -> []
    | _ ->
	match find_first_field "signal" wl with
	  | Some (r,e) -> 
	      (let n = try 
		 let handler_name = out_some (find_first_string "handler" e) in 
		 Some {sig_handler = 
			 (let n = out_some (find_first_string "name" e) in 
			  string_to_sig_handler handler_name parent_class widget_name n);
		       sig_handler_name = handler_name;
		       sig_stamp = 
			 out_some (find_first_string "last_modification_time" e);
		       sig_object = [] (* Used to be 
					  [find_all_strings "object" e i]. 
					  But usage of object and data 
					  fields is deprecated in 
					  glade *);
		       sig_data = [] (*i [find_all_strings "data" e i]*);
		       sig_after = find_first_bool "after" e;
		      }
	       with
		   Unknown_event s ->
		     warning ("unknown event "^s) ;
		     None
	       in match n with 
		   Some n -> n::(analyze_signals parent_class widget_name r)
		 | None -> analyze_signals parent_class widget_name r)
	  | None -> []
		
let analyze_child c =	      
  match find_first_field "child" c with
    | Some (_,c) ->
	Some {padding = find_first_int "padding" c;
	      expand = find_first_bool "expand" c;
	      fill = find_first_bool "fill" c;
	      left_attach = find_first_int "left_attach" c;
	      right_attach = find_first_int "right_attach" c;
	      top_attach = find_first_int "top_attach" c;
	      bottom_attach = find_first_int "bottom_attach" c;
	      xpad = find_first_int "xpad" c;
	      ypad = find_first_int "ypad" c;
	      x = find_first_int "x" c;
	      y = find_first_int "y" c;
	      xexpand = find_first_bool "xexpand" c;
	      yexpand = find_first_bool "yexpand" c;
	      xshrink = find_first_bool "xshrink" c;
	      yshrink = find_first_bool "yshrink" c;
	      xfill = find_first_bool "xfill" c;
	      yfill = find_first_bool "yfill" c;
	     }
    | None -> 
	Some {padding = None;
	      expand = None;
	      fill = None;
	      left_attach = None;
	      right_attach = None;
	      top_attach = None;
	      bottom_attach = None;
	      xpad = None;
	      ypad = None;
	      x = find_first_int "x" c;
	      y = find_first_int "y" c;
	      xexpand = None;
	      yexpand = None;
	      xshrink = None;
	      yshrink = None;
	      xfill = None;
	      yfill = None;
	     }


let to_modifiers s = (* [GDK_CONTROL_MASK | GDK_SHIFT_MASK | GDK_MOD1_MASK] *)
  match s with 
    | Some s -> let l = gen_split ' ' s in
	List.fold_left 
	  (fun acc s -> 
	     match s with
	     | "|" -> acc
	     | _ -> (String.sub s ~pos:4 ~len:(String.length s - 9) )::acc)
	  []
	  l
    | None -> []

let to_key s = (* [GDK_*] *)
  let s = out_some s in
    String.sub s ~pos:3 ~len:(String.length s - 3) 

let to_extension_event s = (* remove [GTK_EXTENSION_EVENT_] *) 
  match s with 
    | None -> None
    | Some s -> Some (String.sub s 21 ((String.length s) - 21))

let rec analyze_accelerator wl =
  match wl with
      [] -> []
    | _ ->
	match find_first_field "accelerator" wl with
	  | Some (r,e) -> 
	      {
		modifiers = to_modifiers (find_first_string "modifiers" e);
		key = to_key (find_first_string "key" e);
		signal = out_some (find_first_string "signal" e);
	      }::analyze_accelerator r
	  | None -> []

  
let analyze_common_properties w =
  {can_default = find_first_bool "can_default" w;
   has_default = find_first_bool "has_default" w;
   can_focus = find_first_bool "can_focus" w;
   has_focus = find_first_bool "has_focus" w;
   sensitive = find_first_bool "sensitive" w;
   visible = find_first_bool "visible" w;
   tooltip = find_first_string "tooltip" w;
   child_name = find_first_string "child_name" w;
   events = [];
   extension_events = 
     to_extension_event (find_first_string "extension_events" w);
   accelerators = analyze_accelerator (find_all_fields "accelerator" w);
}

let to_policy = 
  function 
    | Some "GTK_POLICY_ALWAYS" -> Some "`ALWAYS"
    | Some "GTK_POLICY_NEVER" -> Some "`NEVER"
    | Some "GTK_POLICY_AUTOMATIC" -> Some "`AUTOMATIC"
    | Some s -> error ("Unknown policy "^s)
    | None -> None

let to_shadow = function 
  | Some "GTK_SHADOW_IN" -> Some "`IN"
  | Some "GTK_SHADOW_OUT" -> Some "`OUT"
  | Some "GTK_SHADOW_NONE" -> Some "`NONE"
  | Some "GTK_SHADOW_ETCHED_IN" -> Some "`ETCHED_IN"
  | Some "GTK_SHADOW_ETCHED_OUT" -> Some "`ETCHED_OUT"
  | None -> None
  | _ -> error "Not a shadow"

let to_view_mode = function 
  | Some "GTK_TREE_VIEW_LINE" -> Some "`LINE"
  | Some "GTK_TREE_VIEW_ITEM" -> Some "`ITEM"
  | None -> None
  | _ ->  error "Not a view mode"

let to_selection_mode = function 
  | Some "GTK_SELECTION_SINGLE" -> Some "`SINGLE"
  | Some "GTK_SELECTION_BROWSE" -> Some "`BROWSE"
  | Some "GTK_SELECTION_MULTIPLE" -> Some "`MULTIPLE"
  | Some "GTK_SELECTION_EXTENDED" -> Some "`EXTENDED"
  | None -> None
  | _ ->  error "Not a selection mode"

let to_buttonbox_layout = function 
  | Some "GTK_BUTTONBOX_START" -> Some "`START"
  | Some "GTK_BUTTONBOX_END" -> Some "`END"
  | Some "GTK_BUTTONBOX_EDGE" -> Some "`EDGE"
  | Some "GTK_BUTTONBOX_SPREAD" -> Some "`SPREAD"
  | Some "GTK_BUTTONBOX_DEFAULT_STYLE" -> Some "`DEFAULT_STYLE"
  | None -> None
  | Some v ->  error ("Not a buttonbox layout mode "^v)

let to_orientation = function 
  | Some "GTK_ORIENTATION_HORIZONTAL" -> Some "`HORIZONTAL"
  | Some "GTK_ORIENTATION_VERTICAL" -> Some "`VERTICAL"
  | None -> None
  | Some v ->  error ("Not an orientation "^v)

let to_toolbar_style = function 
  | Some "GTK_TOOLBAR_BOTH" -> Some "`BOTH"
  | Some "GTK_TOOLBAR_TEXT" -> Some "`TEXT"
  | Some "GTK_TOOLBAR_ICONS" -> Some "`ICONS"
  | None -> None
  | Some v ->  error ("Not a toolbar style "^v)

let to_toolbar_space_style = function 
  | Some "GTK_TOOLBAR_SPACE_LINE" -> Some "`LINE"
  | Some "GTK_TOOLBAR_SPACE_EMPTY" -> Some "`EMPTY"
  | None -> None
  | Some v ->  error ("Not a toolbar space style "^v)

let to_relief = function 
  | Some "GTK_RELIEF_HALF" -> Some "`HALF"
  | Some "GTK_RELIEF_NORMAL" -> Some "`NORMAL"
  | Some "GTK_RELIEF_NONE" -> Some "`NONE"
  | None -> None
  | Some v ->  error ("Not a relief "^v)

let to_tab_pos = function
  | Some "GTK_POS_TOP" -> Some "`TOP"
  | Some "GTK_POS_RIGHT" -> Some "`RIGHT"
  | Some "GTK_POS_LEFT" -> Some "`LEFT"
  | Some "GTK_POS_BOTTOM" -> Some "`BOTTOM"
  | None -> None
  | Some v -> error ("Not a tab_pos "^v) 

(* should "camlize" the name as much as possible. 
Currently we just downcase  the initial upper case and replace 
the first [-] by [_].*) 
let emit_name s = match s with 
  | "" -> "_"
  |  s -> let s = String.uncapitalize s in
       try 
	 let i = String.index s '-' in
	   String.set s i '_';
	   s
       with Not_found -> s  


(*s Build the AST for all widgets.*)
 
(* [analyze_widget p w] returns a [widget] packed with [p]
  corresponding to the xml data type w. *)
let rec analyze_widget parent_packer w =
  let class_name = out_some (find_first_string "class" w) in
    (*i  Printf.printf " (* Found class %s.*)\n" class_name ; i*)
    match class_name with
	"Placeholder" -> Placeholder
      | "GtkDrawingArea" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkDrawingArea
	      {gtk_drawing_area_name = n ;
	       gtk_drawing_area_parent_packer = parent_packer ;
	       gtk_drawing_area_size = (analyze_size w);
	       gtk_drawing_area_child = (analyze_child w);
	       gtk_drawing_area_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_drawing_area_common_properties = 
		 analyze_common_properties w;
	    }

      | "GtkFrame" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkFrame
	      {gtk_frame_name = n ;
	       gtk_frame_parent_packer = parent_packer ;
	       gtk_frame_size = (analyze_size w);
	       gtk_frame_child = (analyze_child w);
	       gtk_frame_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_frame_common_properties = 
		 analyze_common_properties w;

	       gtk_frame_border_width = 
		 (find_first_int "border_width" w);
	       gtk_frame_label = 
		 (find_first_string "label" w);
	       gtk_frame_shadow_type = 
		 (to_shadow (find_first_string "shadow_type" w));
	       gtk_frame_label_xalign = 
		 (find_first_float "label_xalign" w);
	       gtk_frame_label_yalign = 
		 (find_first_float "label_yalign" w);
	       gtk_frame_widgets = 
		 analyze_widgets  (Simple_packer  (n^"#add")) 
		   (find_all_fields "widget" w);
	    }
	  
      | "GtkOptionMenu" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkOptionMenu
	      {gtk_omenu_name = n ;
	       gtk_omenu_parent_packer = parent_packer ;
	       gtk_omenu_size = (analyze_size w);
	       gtk_omenu_child = (analyze_child w);
	       gtk_omenu_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_omenu_common_properties = 
		 analyze_common_properties w;

	       gtk_omenu_border_width = 
		 (find_first_int "border_width" w);
	       gtk_omenu_items = 
		 (find_first_string "items" w);
	       gtk_omenu_initial_choice = 
		 (find_first_int "initial_choice" w);
	    }

      | "GtkNotebook" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	  GtkNotebook
	    {gtk_notebook_name = n ;
	     gtk_notebook_parent_packer = parent_packer ;
	     gtk_notebook_tab_pos = to_tab_pos (find_first_string "tab_pos" w);
	     gtk_notebook_tab_border = find_first_int "tab_hborder" w;
	     (* What shall we do with tab_vborder ? *)
	     gtk_notebook_homogeneous_tab = find_first_bool "homogeneous" w;
	     (* Not present in glade : what is this ? *)
	     gtk_notebook_show_border = find_first_bool "show_border" w;
	     gtk_notebook_scrollable  = find_first_bool "scrollable" w;
	     gtk_notebook_popup  = find_first_bool "popup_enable" w;
	     gtk_notebook_border_width = find_first_int "border_width" w;
	     gtk_notebook_size = (analyze_size w);
	     gtk_notebook_child = (analyze_child w);
	     gtk_notebook_widgets = 
	       analyze_widgets  (Simple_packer  (n^"#add")) 
		 (find_all_fields "widget" w);
	     gtk_notebook_signals = 
	       analyze_signals class_name n (find_all_fields "signal" w);
	     gtk_notebook_common_properties = analyze_common_properties w;
	    }

      | "GtkScrolledWindow" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkScrolledWindow 
	      {
		gtk_scrolled_window_common_properties = analyze_common_properties w;
		gtk_scrolled_window_name = n;
		gtk_scrolled_window_parent_packer = parent_packer;
		gtk_scrolled_window_hscrollbar_policy = 
		 to_policy (find_first_string "hscrollbar_policy" w);
		gtk_scrolled_window_vscrollbar_policy =
		 to_policy (find_first_string "vscrollbar_policy" w);
		gtk_scrolled_window_hupdate_policy =
		 find_first_string "hupdate_policy" w;
		gtk_scrolled_window_vupdate_policy =
		 find_first_string "vupdate_policy" w;	
		gtk_scrolled_window_child =
		 analyze_child w;
		gtk_scrolled_window_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
		gtk_scrolled_window_widgets = 
		 analyze_widgets  (Simple_packer  (n^"#add")) 
		   (find_all_fields "widget" w);
	      }
      | "GtkToolbar" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkToolbar 
	      {
		gtk_toolbar_common_properties = analyze_common_properties w;
		gtk_toolbar_name = n;
		gtk_toolbar_border_width = find_first_int "border_width" w;
		gtk_toolbar_can_focus = find_first_bool "can_focus" w;
		gtk_toolbar_has_focus = find_first_bool "has_focus" w;
		gtk_toolbar_tooltips = find_first_bool "tooltips" w;
		gtk_toolbar_space_size = find_first_int "space_size" w;

		gtk_toolbar_orientation = to_orientation
					    (find_first_string "orientation" w) ;
		gtk_toolbar_style = to_toolbar_style 
					    (find_first_string "style" w);
		gtk_toolbar_space_style = to_toolbar_space_style 
					    (find_first_string "space_style" w);

		gtk_toolbar_relief = to_relief 
					    (find_first_string "relief" w);
		
		gtk_toolbar_draw_indicator = find_first_bool "draw_indicator" w;
		gtk_toolbar_size = analyze_size w;
		gtk_toolbar_parent_packer = parent_packer;
		gtk_toolbar_child =
		 analyze_child w;
		gtk_toolbar_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
		gtk_toolbar_widgets = 
		 analyze_widgets  (Simple_packer  (n^"#add")) 
		   (find_all_fields "widget" w);
	      }

      | "GtkCombo" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkCombo
	      {
		gtk_combo_common_properties = analyze_common_properties w;
		gtk_combo_name = n;
		gtk_combo_border_width = find_first_int "border_width" w;
		gtk_combo_value_in_list = find_first_bool "value_in_list" w;
		gtk_combo_ok_if_empty = find_first_bool "ok_if_empty" w;
		gtk_combo_case_sensitive = find_first_bool "case_sensitive" w;
		gtk_combo_use_arrows = find_first_bool "use_arrows" w;
		gtk_combo_use_arrows_always = find_first_bool "use_arrows_always" w;
		gtk_combo_items = find_first_string "items" w;
  

		gtk_combo_size = analyze_size w;
		gtk_combo_parent_packer = parent_packer;
		gtk_combo_child =
		 analyze_child w;
		gtk_combo_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
		gtk_combo_widgets = 
		 analyze_widgets  (Simple_packer  (n^"#add")) 
		   (find_all_fields "widget" w);
	      }
      | "GtkViewport" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkViewPort
	      {gtk_viewport_common_properties = analyze_common_properties w;
	       gtk_viewport_name = n;
	       gtk_viewport_parent_packer = parent_packer;
	       gtk_viewport_shadow_type = to_shadow 
					    (find_first_string "shadow_type" w);
	       gtk_viewport_hscrollbar_policy = 
		 to_policy (find_first_string "hscrollbar_policy" w);
	       gtk_viewport_vscrollbar_policy =
		 to_policy (find_first_string "vscrollbar_policy" w);
	       gtk_viewport_widgets = 
		 analyze_widgets  
		   (Simple_packer (n^"#add") )
		   (find_all_fields "widget" w);
	       gtk_viewport_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_viewport_child = analyze_child w;}
      | "GtkMenuBar" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkMenuBar
	      {	gtk_menubar_common_properties = analyze_common_properties w;
		gtk_menubar_name = n;
		gtk_menubar_parent_packer = parent_packer;
		gtk_menubar_shadow_type = to_shadow 
					    (find_first_string "shadow_type" w);
		gtk_menubar_border_width = find_first_int "border_width" w;
		gtk_menubar_widgets = 
		  analyze_widgets  
		    (Simple_packer (n^"#add") )
		    (find_all_fields "widget" w);
		gtk_menubar_size = analyze_size w;
		gtk_menubar_signals =	    
		  analyze_signals class_name n (find_all_fields "signal" w);
		gtk_menubar_child = analyze_child w;}
      | "GtkMenuItem" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkMenuItem
	      {gtk_menuitem_common_properties = analyze_common_properties w;
	       gtk_menuitem_name = n;
	       gtk_menuitem_parent_packer = parent_packer;
	       gtk_menuitem_label = find_first_string "label" w;
	       gtk_menuitem_border_width = find_first_int "border_width" w;
	       gtk_menuitem_right_justify = find_first_bool "right_justify" w;
	       gtk_menuitem_widgets = 
		 analyze_widgets  
		   (Simple_packer (n^"#set_submenu") )
		   (find_all_fields "widget" w);
	       gtk_menuitem_size = analyze_size w;
	       gtk_menuitem_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_menuitem_child = analyze_child w;}
      | "GtkMenu" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkMenu
	      {gtk_menuitem_common_properties = analyze_common_properties w;
	       gtk_menuitem_name = n;
	       gtk_menuitem_parent_packer = parent_packer;
	       gtk_menuitem_label = find_first_string "label" w;
	       gtk_menuitem_border_width = find_first_int "border_width" w;
	       gtk_menuitem_right_justify = find_first_bool "right_justify" w;
	       gtk_menuitem_widgets = 
		 analyze_widgets  
		   (Simple_packer (n^"#add") )
		   (find_all_fields "widget" w);
	       gtk_menuitem_size = analyze_size w;
	       gtk_menuitem_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_menuitem_child = analyze_child w;}
      | "GtkWindow" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkWindow
	      {gtk_window_name = n ;
	       gtk_window_parent_packer = parent_packer ;
	       gtk_window_title = find_first_string "title" w;
	       gtk_window_type = 
		 to_window_type_t (find_first_string "type" w) ;
	       gtk_window_position = 
		 to_window_position (find_first_string "position" w) ;
	       gtk_window_modal = find_first_bool "modal" w ;
	       gtk_window_allow_shrink = find_first_bool "allow_shrink" w ;
	       gtk_window_allow_grow = find_first_bool "allow_grow" w ;
	       gtk_window_auto_shrink = find_first_bool "auto_shrink" w ;
	       gtk_window_widgets = analyze_widgets (Simple_packer (n^"#add"))
				     (find_all_fields "widget" w);
	       gtk_window_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_window_border_width = 
		 find_first_int "border_width" w;
	       gtk_window_common_properties = analyze_common_properties w;
	       gtk_window_size = analyze_size w; }

      | "GtkFileSelection" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkFileSelection
	      {gtk_fileselection_name = n ;
	       gtk_fileselection_parent_packer = parent_packer ;
	       gtk_fileselection_title = find_first_string "title" w;
	       gtk_fileselection_position = 
		 to_window_position (find_first_string "position" w) ;
	       gtk_fileselection_modal = find_first_bool "modal" w ;
	       gtk_fileselection_allow_shrink = find_first_bool "allow_shrink" w ;
	       gtk_fileselection_allow_grow = find_first_bool "allow_grow" w ;
	       gtk_fileselection_auto_shrink = find_first_bool "auto_shrink" w ;
	       gtk_fileselection_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_fileselection_border_width = 
		 find_first_int "border_width" w;
	       gtk_fileselection_common_properties = analyze_common_properties w;
	       gtk_fileselection_show_file_op = 
		 find_first_bool "show_file_op_buttons" w;
	       gtk_fileselection_child = analyze_child w;
	       gtk_fileselection_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#add";
				  coercion_of_child=""})
		 (find_all_fields "widget" w); 
	      }
      | "GtkTree" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkTree 
	      {gtk_tree_common_properties = analyze_common_properties w;
	       gtk_tree_name = n; 
	       gtk_tree_parent_packer = parent_packer ;
	       gtk_tree_view_line = find_first_bool "view_line" w;
	       gtk_tree_view_mode = to_view_mode (find_first_string "view_mode" w);
	       gtk_tree_selection_mode = to_selection_mode 
					   (find_first_string "selection_mode" w);
	       gtk_tree_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_tree_child = analyze_child w;}
      | "GtkVBox" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkVBox 
	      {gtk_box_common_properties = analyze_common_properties w;
	       gtk_box_name = n; 
	       gtk_box_parent_packer = parent_packer ;
	       gtk_box_homogeneous = find_first_bool "homogeneous" w;
	       gtk_box_spacing = find_first_int "spacing" w;
	       gtk_box_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#pack";
						  coercion_of_child=""})
		   (find_all_fields "widget" w);
	       gtk_box_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_box_size = analyze_size w;
	       gtk_box_child = analyze_child w;}
      | "GtkHBox" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHBox 
	      {gtk_box_common_properties = analyze_common_properties w;
	       gtk_box_name = n; 
	       gtk_box_parent_packer = parent_packer ;
	       gtk_box_homogeneous = find_first_bool "homogeneous" w;
	       gtk_box_spacing = find_first_int "spacing" w;
	       gtk_box_widgets = analyze_widgets 
				   (Complex_packer 
				      {function_of_parent=n^"#pack";
				       coercion_of_child=""})
				   (find_all_fields "widget" w);
	       gtk_box_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_box_size = analyze_size w;
	       gtk_box_child = analyze_child w;

	      }
      | "GtkHPaned" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHPan 
	      {gtk_pan_common_properties = analyze_common_properties w;
	       gtk_pan_name = n; 
	       gtk_pan_parent_packer = parent_packer ;
	       gtk_pan_border_width = find_first_int "border_width" w;
	       gtk_pan_handle_size = find_first_int "handle_size" w;
	       gtk_pan_gutter_size = find_first_int "gutter_size" w;
	       gtk_pan_position = find_first_int "position" w;
	       gtk_pan_widgets = analyze_widgets 
				   (Complex_packer 
				      {function_of_parent=n^"#add";
				       coercion_of_child=""})
				   (find_all_fields "widget" w);
	       gtk_pan_signals =
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_pan_size = analyze_size w;
	       gtk_pan_child = analyze_child w;

	      }
      | "GtkVPaned" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkVPan 
	      {gtk_pan_common_properties = analyze_common_properties w;
	       gtk_pan_name = n; 
	       gtk_pan_parent_packer = parent_packer ;
	       gtk_pan_border_width = find_first_int "border_width" w;
	       gtk_pan_handle_size = find_first_int "handle_size" w;
	       gtk_pan_gutter_size = find_first_int "gutter_size" w;
	       gtk_pan_position = find_first_int "position" w;
	       gtk_pan_widgets = analyze_widgets 
				   (Complex_packer 
				      {function_of_parent=n^"#add";
				       coercion_of_child=""})
				   (find_all_fields "widget" w);
	       gtk_pan_signals =
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_pan_size = analyze_size w;
	       gtk_pan_child = analyze_child w;

	      }
      | "GtkTable" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkTable
	      {gtk_table_common_properties = analyze_common_properties w;
	       gtk_table_name = n; 
	       gtk_table_parent_packer = parent_packer ;
	       gtk_table_homogeneous = find_first_bool "homogeneous" w;
	       gtk_table_row_spacing = find_first_int "row_spacing" w;
	       gtk_table_column_spacing = find_first_int "column_spacing" w;
	       gtk_table_rows = find_first_int "rows" w;
	       gtk_table_columns = find_first_int "columns" w;
	       gtk_table_border_width = find_first_int "border_width" w;

	       gtk_table_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#attach";
						  coercion_of_child=""})
		   (find_all_fields "widget" w);
	       gtk_table_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_table_size = analyze_size w;
	       gtk_table_child = analyze_child w;}

      | "GtkFixed" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkFixed
	      {gtk_table_common_properties = analyze_common_properties w;
	       gtk_table_name = n; 
	       gtk_table_parent_packer = parent_packer ;
	       gtk_table_homogeneous = find_first_bool "homogeneous" w;
	       gtk_table_row_spacing = find_first_int "row_spacing" w;
	       gtk_table_column_spacing = find_first_int "column_spacing" w;
	       gtk_table_rows = find_first_int "rows" w;
	       gtk_table_columns = find_first_int "columns" w;
	       gtk_table_border_width = find_first_int "border_width" w;

	       gtk_table_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#put";
						  coercion_of_child=""})
		   (find_all_fields "widget" w);
	       gtk_table_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_table_size = analyze_size w;
	       gtk_table_child = analyze_child w;}

      | "GtkVButtonBox" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkVButtonBox
	      {gtk_buttonbox_common_properties = analyze_common_properties w;
	       gtk_buttonbox_name = n; 
	       gtk_buttonbox_parent_packer = parent_packer ;
	       gtk_buttonbox_spacing = find_first_int "spacing" w;
	       gtk_buttonbox_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#pack";
						  coercion_of_child=""}
				 ) 
		   (find_all_fields "widget" w);
	       gtk_buttonbox_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_buttonbox_child_width = find_first_int "child_min_width" w;
	       gtk_buttonbox_child_height = find_first_int "child_min_height" w;
	       gtk_buttonbox_child_ipadx = find_first_int "child_ipadx" w;
	       gtk_buttonbox_child_ipady = find_first_int "child_ipady" w;
	       gtk_buttonbox_border_width = find_first_int "border_width" w;
	       gtk_buttonbox_layout = to_buttonbox_layout 
					(find_first_string "layout_style" w);
	       gtk_buttonbox_child = analyze_child w; 
	      }
      | "GtkHButtonBox" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHButtonBox
	      {gtk_buttonbox_common_properties = analyze_common_properties w;
	       gtk_buttonbox_name = n; 
	       gtk_buttonbox_parent_packer = parent_packer ;
	       gtk_buttonbox_spacing = find_first_int "spacing" w;
	       gtk_buttonbox_widgets = 
		 analyze_widgets (Complex_packer {function_of_parent=n^"#pack";
						  coercion_of_child=""}) 
		   (find_all_fields "widget" w);
	       gtk_buttonbox_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_buttonbox_child_width = find_first_int "child_min_width" w;
	       gtk_buttonbox_child_height = find_first_int "child_min_height" w;
	       gtk_buttonbox_child_ipadx = find_first_int "child_ipadx" w;
	       gtk_buttonbox_child_ipady = find_first_int "child_ipady" w;
	       gtk_buttonbox_border_width = find_first_int "border_width" w;
	       gtk_buttonbox_layout = to_buttonbox_layout 
					(find_first_string "layout_style" w);
	       gtk_buttonbox_child = analyze_child w; }
      | "GtkHSeparator" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHSeparator
	      {gtk_separator_common_properties = analyze_common_properties w;
	       gtk_separator_name = n; 
	       gtk_separator_parent_packer = parent_packer ;
	       gtk_separator_size = analyze_size w;
	       gtk_separator_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_separator_child = analyze_child w}
      | "GtkVSeparator" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHSeparator
	      {gtk_separator_common_properties = analyze_common_properties w;
	       gtk_separator_name = n; 
	       gtk_separator_parent_packer = parent_packer ;
	       gtk_separator_size = analyze_size w;
	       gtk_separator_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_separator_child = analyze_child w}
      | "GtkStatusbar" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkStatusBar
	      {gtk_statusbar_common_properties = analyze_common_properties w;
	       gtk_statusbar_name = n; 
	       gtk_statusbar_parent_packer = parent_packer ;
	       gtk_statusbar_size = analyze_size w;
	       gtk_statusbar_border_width = find_first_int "border_width" w;
	       gtk_statusbar_signals =	    
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_statusbar_child = analyze_child w}
      | "GtkButton" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkButton
	      {gtk_button_common_properties = analyze_common_properties w;
	       gtk_button_name = n ; 
	       gtk_button_parent_packer = parent_packer;
	       gtk_button_can_focus = find_first_bool "can_focus" w;
	       gtk_button_label = find_first_string "label" w;
	       gtk_button_relief = find_first_string "relief" w;
	       gtk_button_border_width = find_first_int "border_width" w;
	       gtk_button_size = analyze_size w;
	       gtk_button_child = analyze_child w;
	       gtk_button_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_button_draw_indicator = 
		 (find_first_bool "draw_indicator" w);
	       gtk_button_widgets = analyze_widgets (Simple_packer (n^"#add"))
				      (find_all_fields "widget" w);


	      }
      | "GtkRadioButton" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkRadioButton
	      {gtk_rbutton_common_properties = analyze_common_properties w;
	       gtk_rbutton_name = n ; 
	       gtk_rbutton_parent_packer = parent_packer;
	       gtk_rbutton_can_focus = find_first_bool "can_focus" w;
	       gtk_rbutton_has_focus = find_first_bool "has_focus" w;
	       gtk_rbutton_label = find_first_string "label" w;
	       gtk_rbutton_active = find_first_bool "active" w;
	       gtk_rbutton_draw_indicator = find_first_bool "draw_indicator" w;
	       gtk_rbutton_group = 
		 (match 
		   find_first_string "group" w
		 with 
		   | None -> None
		   | Some s -> Some (s^"#group"));
	       gtk_rbutton_relief = find_first_string "relief" w;
	       gtk_rbutton_border_width = find_first_int "border_width" w;
	       gtk_rbutton_size = analyze_size w;
	       gtk_rbutton_child = analyze_child w;
	       gtk_rbutton_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w);
	      }
      | "GtkToggleButton" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkToggleButton
	      {gtk_tbutton_common_properties = analyze_common_properties w;
	       gtk_tbutton_name = n ; 
	       gtk_tbutton_parent_packer = parent_packer;
	       gtk_tbutton_can_focus = find_first_bool "can_focus" w;
	       gtk_tbutton_active = find_first_bool "active" w;
	       gtk_tbutton_label = find_first_string "label" w;
	       gtk_tbutton_relief = find_first_string "relief" w;
	       gtk_tbutton_border_width = find_first_int "border_width" w;
	       gtk_tbutton_size = analyze_size w;
	       gtk_tbutton_child = analyze_child w;
	       gtk_tbutton_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w)}

      | "GtkHandleBox" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkHandleBox
	      {gtk_handlebox_common_properties = analyze_common_properties w;
	       gtk_handlebox_name = n ; 
	       gtk_handlebox_parent_packer = parent_packer;
	       gtk_handlebox_border_width = find_first_int "border_width" w;
	       gtk_handlebox_size = analyze_size w;
	       gtk_handlebox_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_handlebox_widgets = 
		 analyze_widgets 
		   (Simple_packer (n^"#add")) (find_all_fields "widget" w);
	       gtk_handlebox_child = analyze_child w;}
      | "GtkEntry" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkEntry 
	      {gtk_entry_common_properties = analyze_common_properties w;
	       gtk_entry_name = n;
	       gtk_entry_parent_packer = parent_packer;
	       gtk_entry_can_focus = find_first_bool "can_focus" w;
	       gtk_entry_editable = find_first_bool "editable" w;
	       gtk_entry_text_visible = find_first_bool "text_visible" w;
	       gtk_entry_text_max_length = find_first_int "text_max_length" w;
	       gtk_entry_text = find_first_string "text" w;
	       gtk_entry_child = 
 		 analyze_child w;
	       gtk_entry_signals =
		 analyze_signals class_name n (find_all_fields "signal" w)
	      }
      | "GtkText" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkText 
	      {gtk_text_common_properties = analyze_common_properties w;
	       gtk_text_name = n;
	       gtk_text_parent_packer = parent_packer;
	       gtk_text_can_focus = find_first_bool "can_focus" w;
	       gtk_text_editable = find_first_bool "editable" w;
	       gtk_text_text = find_first_string "text" w;
	       gtk_text_signals =
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_text_child = analyze_child w}

      | "GtkLabel" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkLabel
 	      {gtk_label_common_properties = analyze_common_properties w;
	       gtk_label_name = n;
	       gtk_label_parent_packer = parent_packer;
	       gtk_label_label = find_first_string "label" w;
	       gtk_label_justify = find_first_string "justify" w;
	       gtk_label_wrap = find_first_bool "wrap" w;
	       gtk_label_xalign = find_first_float "xalign" w;
	       gtk_label_yalign = find_first_float "yalign" w;
	       gtk_label_xpad = find_first_int "xpad" w;
	       gtk_label_ypad = find_first_int "ypad" w;
     	       gtk_label_child = analyze_child w;
	       gtk_label_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_label_size = analyze_size w;}
      | "GtkPixmap" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkPixmap
 	      {gtk_pixmap_common_properties = analyze_common_properties w;
	       gtk_pixmap_name = n;
	       gtk_pixmap_can_focus = find_first_bool "can_focus" w;
	       gtk_pixmap_has_focus = find_first_bool "has_focus" w;
	       gtk_pixmap_build_insensitive = 
		 find_first_bool "build_insensitive" w;
      	       gtk_pixmap_parent_packer = parent_packer;
	       gtk_pixmap_filename = find_first_string "filename" w;
	       gtk_pixmap_xalign = find_first_float "xalign" w;
	       gtk_pixmap_yalign = find_first_float "yalign" w;
	       gtk_pixmap_xpad = find_first_int "xpad" w;
	       gtk_pixmap_ypad = find_first_int "ypad" w;
     	       gtk_pixmap_child = analyze_child w;
	       gtk_pixmap_signals= 
		 analyze_signals class_name n (find_all_fields "signal" w);
	      gtk_pixmap_widgets = 
		 analyze_widgets (Simple_packer (n^"#misc")) w;
	       gtk_pixmap_size = analyze_size w;}

      | "GtkCheckButton" ->
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkCheckb
	      {gtk_checkb_common_properties = analyze_common_properties w;
	       gtk_checkb_name = n;
		gtk_checkb_parent_packer = parent_packer;
		gtk_checkb_label = find_first_string "label" w;
		gtk_checkb_can_focus = find_first_bool "can_focus" w;
		gtk_checkb_active = find_first_bool "active" w;
		gtk_checkb_draw_indicator = find_first_bool "draw_indicator" w;
     		gtk_checkb_child = analyze_child w;
		gtk_checkb_signals= 
		  analyze_signals class_name n (find_all_fields "signal" w)}

      | "GtkList" -> 
	  let n = emit_name (out_some (find_first_string "name" w)) in
	    GtkList 
	      {gtk_list_name = n; 
	       gtk_list_parent_packer = parent_packer ;
	       gtk_list_selection_mode = 
		 to_selection_mode (find_first_string "selection_mode" w);
	       gtk_list_signals = 
		 analyze_signals class_name n (find_all_fields "signal" w);
	       gtk_list_child = analyze_child w;
	       gtk_list_common_properties = analyze_common_properties w;
	      }
      | s -> Printf.printf "Unimplemented class %s \nPlease upgrade\n" s;
	  Placeholder

and analyze_widgets parent_packer wl = 
  match wl with
      [] -> []
    | _  -> 
	match 
	  find_first_field "widget" wl with
	    | Some (r,e) -> 
		let e = analyze_widget parent_packer e in
		  e::(analyze_widgets parent_packer r)
	    | None -> []


type generated_source = 
    {for_main : string*string; 
     for_interface : string*string*string;
     for_interface_mli : string;
     for_callbacks : string list * (string*string*string) list; 
     (* header list , (tag,generated_profile,modifiable body) list *)
     for_sig_connect : string
    }

let empty_source = {for_main = "","";
		    for_interface = "","","";
		    for_callbacks = [],[];
		    for_sig_connect = "";
		    for_interface_mli = ""}

let (@@) = fun (l1,l2) (l'1,l'2) -> (l1@l'1) , (l2@l'2)

let concat_source s1 s2 = 
  {for_main =
     (fst s1.for_main)^(fst s2.for_main),
     (snd s1.for_main)^(snd s2.for_main);
   for_interface =   
     (fst2 s1.for_interface)^(fst2 s2.for_interface),
     (snd2 s1.for_interface)^(snd2 s2.for_interface),
     (thr2 s1.for_interface)^(thr2 s2.for_interface);
   for_callbacks = s1.for_callbacks @@ s2.for_callbacks;		   
   for_sig_connect = s1.for_sig_connect ^ s2.for_sig_connect;
   for_interface_mli = s1.for_interface_mli ^ s2.for_interface_mli} 


(*s Emiting functions *)

(* Emit different arguments depending on theyr types.*)


let emit_optional_string label_to_emit arg =
    match arg with 
      | None ->  ""
      | Some v -> label_to_emit ^ " \"" ^ v ^ "\"\n" 

let emit_optional_string_list label_to_emit arg =
  match arg with 
    | None ->  ""
    | Some v -> 
	let v = line_split v in
	  label_to_emit 
	  ^ " [" 
	  ^ (List.fold_left (fun acc e -> ("\"" ^ e ^ "\";")^acc) "" v) 
	  ^ "]\n"

let emit_optional_string_complex before arg after =
  match arg with 
    | None ->   before ^ " \"/usr/share/pixmaps/yes.xpm\"" ^ 
	after ^ "\n" 
    | Some v -> before ^ " \"" ^ 
	(Filename.concat !pixmaps_directory  v) ^ 
	"\"" ^ after ^ "\n"

let emit_optional_cons label_to_emit arg =
  match arg with 
    | None ->  ""
    | Some v -> label_to_emit ^ v ^ "\n" 

let emit_optional_bool label_to_emit arg =
  match arg with 
    | None ->  ""
    | Some v -> label_to_emit ^ (bool_to_caml v) ^ "\n"

let emit_optional_int label_to_emit arg =
  match arg with 
    | None ->  ""
    | Some v -> label_to_emit ^ (string_of_int v) ^ "\n"

let emit_optional_float label_to_emit arg =
  match arg with 
    | None ->  ""
    | Some v -> 
	label_to_emit
	^(let s = string_of_float v in 
	    if String.contains s '.' then s
	    else s^".") 
	^ "\n"

let emit_optional_expand_type l x y =
  try 
    let x = out_some x in
    let y = out_some y in
      l^(match x,y with
	   |true,true -> "`BOTH"
	   |true,false -> "`X"
	   |false,true -> "`Y"
	   |false,false -> "`NONE")^"\n"
  with _ -> ""


let emit_optional_child child =
  match child with 
    | None ->  ""
    | Some v -> 	
	(emit_optional_int "~x:" v.x)^
	(emit_optional_int "~y:" v.y)^
	(emit_optional_int "~padding:" v.padding)^ 
	(emit_optional_bool "~fill:" v.fill)^
	(emit_optional_bool "~expand:" v.expand)^
	(emit_optional_int "~left:" v.left_attach)^
	(emit_optional_int "~top:" v.top_attach)^
	(emit_optional_int "~right:" v.right_attach)^
	(emit_optional_int "~bottom:" v.bottom_attach)^
	(emit_optional_int "~xpadding:" v.xpad)^
	(emit_optional_int "~ypadding:" v.ypad)^
	(emit_optional_expand_type "~expand:" v.xexpand v.yexpand)^
	(emit_optional_expand_type "~shrink:" v.xshrink v.yshrink)^
	(emit_optional_expand_type "~fill:" v.xfill v.yfill)

let emit_optional_size {height= h ; width= w} = 
    (emit_optional_int "~height:" h)^
    (emit_optional_int "~width:" w)

let emit_optional_property_bool pref name arg =
 match arg with
     None -> ""
   | Some v -> 
       Printf.sprintf "let _ = %s %s %s in\n" pref name (bool_to_caml v)

let emit_optional_property_int pref arg =
 match arg with
     None -> ""
   | Some v -> 
       Printf.sprintf "let _ = %s %d in\n" pref v

let emit_optional_property_bool_if_true pref name test =
 match test with
     None -> ""
   | Some v -> 
       if v then 
       Printf.sprintf "let _ = %s %s in\n" pref name
       else ""

let emit_optional_property_bool_if_false pref name test =
 match test with
     None -> ""
   | Some v -> 
       if not v then 
       Printf.sprintf "let _ = %s %s in\n" pref name
       else ""

let emit_optional_property_string pref name str =
 match str with
     None -> ""
   | Some v -> 
       Printf.sprintf "let _ = %s %s \"%s\" in\n" pref name v


let emit_optional_property_cons pref str =
 match str with
     None -> ""
   | Some v -> 
       Printf.sprintf "let _ = %s `%s in\n" pref v

let emit_optional_packer label_to_pack packer child_args =
  match packer with 
    | Simple_packer s -> 
	label_to_pack^s^"\n"
    | Complex_packer p -> 
	(match child_args with 
	     None -> label_to_pack^p.function_of_parent^"\n"
	   | Some child -> label_to_pack^
	       "("^p.function_of_parent^" "^
	       (emit_optional_child (Some child))^")\n")
    | No_packer -> assert false

let rec emit_signals_code emitter_name sl = match sl with 
    [] -> [] 
  | {sig_handler=h;sig_handler_name=n;sig_stamp=s;sig_object=d;sig_data=sg;
     sig_after=after;}
    ::r -> 
	(match h with
	     Standard h -> 
	       {for_main = "","";
		for_interface_mli = "";
		for_interface =  "","","";
		for_sig_connect =
		  (Printf.sprintf "let _ =  %s#%s%s%s
\t~callback:callbacks#%s in\n"
		     emitter_name h.signal_handler_path 
		     (match after with 
			| Some false | None -> ""
			| Some true -> "after#"
		     )
		     h.signal_name
		     n );
		for_callbacks=
		  [],
		  [n,(Printf.sprintf 
			"method %s %s =\n" 
			n h.default_args)
		     ,h.default_code^"\n"]
	       }
	   |Raw h -> assert false
(*i	       {for_main = "","";
		for_interface_mli = "";
		for_interface =  "","","";
		for_sig_connect =
		  (Printf.sprintf 
		     "let _ = GtkSignal.connect_by_name %s#as_widget 
~name:\"%s\"
\t~callback:callbacks#%s in\n"
		     emitter_name h.raw_signal_name
		     n);
		for_callbacks=
		   [],[n,(Printf.sprintf 
			"method %s gtkArgv_t =\n" 
			n)
		     ,h.raw_default_code]
	       }
  i*)
	)
	::
	(emit_signals_code emitter_name r) 

let emit_sigs_code n sl = 
  List.fold_left 
    concat_source
    empty_source
    (emit_signals_code n sl)

let emit_optional_tooltip tip name = 
  match tip with 
    | None -> ""
    | Some s -> Printf.sprintf 
	  "let _ = tooltips#set_tip ~text:\"%s\" %s#coerce in\n" s name

let rec emit_accelerators accel name = 
  match accel with
    | [] -> ""
    | (accel::r) -> Printf.sprintf 
"let _ = %s#misc#add_accelerator
  ~group:accel_group 
  GdkKeysyms.%s
  ~sgn:{ GtkSignal.name = \"%s\"; 
  GtkSignal.marshaller = GtkSignal.marshal_unit }
  ~modi:[%s]
in\n" name accel.key accel.signal 
	(List.fold_left (fun s l -> ("`"^l^";")^s ) "" (accel.modifiers))

let emit_common_properties w n = 
  (emit_optional_property_bool 
     "GtkBase.Widget.set_can_focus"
     (n^"#as_widget") 
     w.can_focus) 
  ^(emit_optional_property_bool 
      "GtkBase.Widget.set_can_default" 
      (n^"#as_widget")
      w.can_default)
  ^(emit_optional_property_bool_if_true 
      "GtkBase.Widget.grab_default" 
      (n^"#as_widget")
      w.has_default)
  ^(emit_optional_property_bool_if_true 
      "GtkBase.Widget.grab_focus" 
      (n^"#as_widget")
      w.has_focus)
  ^(emit_optional_property_bool 
     "GtkBase.Widget.set_sensitive"
     (n^"#as_widget") 
     w.sensitive) 
  ^(emit_optional_property_bool_if_true 
      "GtkBase.Widget.show" 
      (n^"#as_widget")
      w.visible)
  ^(emit_optional_property_bool_if_false 
      "GtkBase.Widget.hide" 
      (n^"#as_widget")
      w.visible)
  ^(emit_optional_tooltip w.tooltip n)
  ^(emit_accelerators w.accelerators n)
  ^(emit_optional_property_cons (n^"#event#set_extensions") w.extension_events)

(* Each widget has a corresponding emitting function.*)

let rec emit_code_gtk_drawing_area w = 
  let n =  w.gtk_drawing_area_name in
  let sigs_code = emit_sigs_code n w.gtk_drawing_area_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMisc.drawing_area\n%s%s()\nin\n%s"
	     w.gtk_drawing_area_name 
	     (emit_optional_packer "~packing:" 
		w.gtk_drawing_area_parent_packer w.gtk_drawing_area_child)
	     (emit_optional_size w.gtk_drawing_area_size)
 	     (emit_common_properties w.gtk_drawing_area_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; }]

and emit_code_gtk_frame w = 
  let n =  w.gtk_frame_name in
  let sigs_code = emit_sigs_code n w.gtk_frame_signals in
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_frame_widgets)
  in
    (concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GBin.frame\n%s%s%s%s%s%s%s()\nin\n%s"
	     w.gtk_frame_name 
	     (emit_optional_packer "~packing:" 
		w.gtk_frame_parent_packer w.gtk_frame_child)
	     (emit_optional_size w.gtk_frame_size)

	     (emit_optional_int "~border_width:" w.gtk_frame_border_width)
	     (emit_optional_string "~label:" w.gtk_frame_label)
	     (emit_optional_float "~label_xalign:" w.gtk_frame_label_xalign)
	     (emit_optional_float "~label_yalign:" w.gtk_frame_label_yalign)
	     (emit_optional_cons "~shadow_type:" w.gtk_frame_shadow_type)

 	     (emit_common_properties w.gtk_frame_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; })::sons_code

and emit_code_gtk_omenu w = 
  let n =  w.gtk_omenu_name in
  let sigs_code = emit_sigs_code n w.gtk_omenu_signals in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMenu.option_menu\n%s%s()\nin\n%s%s"
	     w.gtk_omenu_name 
	     (emit_optional_packer "~packing:" 
		w.gtk_omenu_parent_packer w.gtk_omenu_child)
	     (emit_optional_size w.gtk_omenu_size)

	     (emit_optional_property_int
			     (n^"#set_border_width") w.gtk_omenu_border_width)
 		     	
(*TODO: build the corresponding menu
  (emit_optional_string_list "~items:" w.gtk_omenu_items)
  (emit_optional_int "~initial_choice:" w.gtk_omenu_initial_choice)
*)
 	     (emit_common_properties w.gtk_omenu_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; }]

and emit_code_gtk_window w = 
  let n = w.gtk_window_name in 
  let _ = current_window_name := n in
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_window_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_window_signals in
    { for_main = 
	"let "^n^" = new "^(String.capitalize !program_name)^"_glade_interface.top_"^n^" callbacks in\n",
	"let _ = GtkBase.Widget.add_events "^n^"#"^n^"#as_widget [`ALL_EVENTS] in
let _ = "^n^"#"^n^"#show() in\n" ;
      for_interface_mli = "val top_"^n^" : unit -> GWindow.window";
      for_interface =
	(
	  Printf.sprintf "
class top_%s callbacks =
%s%slet %s = GWindow.window\n%s%s%s%s%s%s%s%s%s()\nin
%s
let _ = %s#add_accel_group accel_group in\n"
	   n
	   "let tooltips = GData.tooltips () in\n"
	   "let accel_group = GtkData.AccelGroup.create () in\n"
	   n
	   (emit_optional_string "~wm_name:" w.gtk_window_title)
	   (emit_optional_cons "~position:" w.gtk_window_position)
	   (emit_optional_cons "~kind:" w.gtk_window_type) 
	   (emit_optional_bool "~modal:" w.gtk_window_modal)
	   (emit_optional_bool "~allow_shrink:" w.gtk_window_allow_shrink)
	   (emit_optional_bool "~allow_grow:" w.gtk_window_allow_grow) 
	   (emit_optional_bool "~auto_shrink:" w.gtk_window_auto_shrink)
	   (emit_optional_int "~border_width:" w.gtk_window_border_width)
	   (emit_optional_size w.gtk_window_size)
	   (emit_common_properties w.gtk_window_common_properties n)
	   n
	),Printf.sprintf "method tooltips = tooltips
method %s = %s
method accel_group = accel_group\n" n n,
	("initializer callbacks#set_"^n^" self\n")
	;
      for_sig_connect = sigs_code.for_sig_connect;
      for_callbacks =   
	(
	  "val mutable top_"^n^"_ = (None : "^(String.capitalize !program_name)^"_glade_interface.top_"^n^" option)
method top_"^n^" =
    match top_"^n^"_ with
      | None -> assert false
      | Some c -> c
method set_"^n^" c = top_"^n^"_ <- Some c")::(fst sigs_code.for_callbacks) , (snd sigs_code.for_callbacks)
    }::sons_code

and emit_code_gtk_selection_window_sons n w = match w with
  | [] -> []
  | w1::r -> let others = emit_code_gtk_selection_window_sons n r in
    let this = match w1 with
      | GtkButton b -> 
	  let n = 
	    match (b.gtk_button_common_properties.child_name) with
	      | Some "FileSel:ok_button"   
	      | Some "ColorSel:ok_button"
	      | Some "FontSel:ok_button" -> 
		  n^"#ok_button"
	      | Some "FileSel:cancel_button" 
	      | Some "ColorSel:cancel_button" 
	      | Some "FontSel:cancel_button" -> 
		  n^"#cancel_button"
	      | Some "FileSel:help_button"
	      | Some "ColorSel:help_button" 
	      | Some "FontSel:help_button" -> 
		  n^"#help_button"
	      | Some "FontSel:apply_button" -> 
		  n^"#apply_button"
	      | _ -> 
		  error "illegal button in selection window\n";
	  in
	  let sigs_code = emit_sigs_code n b.gtk_button_signals
	  in
	    concat_source sigs_code
	       {for_main = "","";
		for_interface_mli = "";
		for_interface = 
		  (Printf.sprintf
	     "let %s = %s in\n%s%s"
	     b.gtk_button_name n 
	     (emit_optional_property_int 
		(b.gtk_button_name^"#set_border_width") 
		b.gtk_button_border_width)
 	     (emit_common_properties b.gtk_button_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" 
		    b.gtk_button_name b.gtk_button_name 
		    ,"";
	for_sig_connect = "";
	for_callbacks = [],[]; }
      | _ -> empty_source
    in this::others
	      
and emit_code_gtk_file_selection w = 
  let n = w.gtk_fileselection_name in 
  let sons_code = 
    emit_code_gtk_selection_window_sons n w.gtk_fileselection_widgets 
  in
  let sigs_code = emit_sigs_code n w.gtk_fileselection_signals in
    {for_main = 
       "let "^n^" = new "^(String.capitalize !program_name)^"_glade_interface.top_"^n^" callbacks in\n",
       "let _ = GtkBase.Widget.add_events "^n^"#"^n^"#as_widget [`ALL_EVENTS] in
let _ = "^n^"#"^n^"#show() in\n" ;
     for_interface_mli = "val top_"^n^" : unit -> GWindow.file_selection";
     for_interface =
       (Printf.sprintf "
class top_%s callbacks =
%s%slet %s = GWindow.file_selection\n%s%s%s%s%s%s%s%s()\nin\n%s"
	  n
	  "let tooltips = GData.tooltips () in\n"
	  "let accel_group = GtkData.AccelGroup.create () in\n"
	  n
	  (emit_optional_string "~wm_name:" w.gtk_fileselection_title)
	  (emit_optional_cons "~position:" w.gtk_fileselection_position)
	  (emit_optional_bool "~modal:" w.gtk_fileselection_modal)
	  (emit_optional_bool "~allow_shrink:" w.gtk_fileselection_allow_shrink)
	  (emit_optional_bool "~allow_grow:" w.gtk_fileselection_allow_grow) 
	  (emit_optional_bool "~auto_shrink:" w.gtk_fileselection_auto_shrink)
	  (emit_optional_int "~border_width:" w.gtk_fileselection_border_width)
	  (emit_optional_bool "~fileop_buttons:" 
	     w.gtk_fileselection_show_file_op)
	  (emit_common_properties w.gtk_fileselection_common_properties n)
       ),
       Printf.sprintf "method tooltips = tooltips
method %s = %s
method accel_group = accel_group\n" n n,
	("initializer callbacks#set_"^n^" self\n")
	 ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = 	(
	  "val mutable top_"^n^"_ = (None : "^(String.capitalize !program_name)^"_glade_interface.top_"^n^" option)
method top_"^n^" =
    match top_"^n^"_ with
      | None -> assert false
      | Some c -> c
method set_"^n^" c = top_"^n^"_ <- Some c")::(fst sigs_code.for_callbacks) , (snd sigs_code.for_callbacks)
    }::sons_code

and  emit_code_gtk_box dir w = 
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_box_widgets) in
  let n = w.gtk_box_name in
  let sigs_code = emit_sigs_code n w.gtk_box_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.%cbox\n%s%s%s%s()\nin\n%s"
			n (match dir with Horizontal -> 'h'
			     | Vertical -> 'v') 
			(emit_optional_int "~spacing:" w.gtk_box_spacing)
			(emit_optional_bool "~homogeneous:"w.gtk_box_homogeneous)
			(emit_optional_size w.gtk_box_size)
			(emit_optional_packer "~packing:" 
			   w.gtk_box_parent_packer w.gtk_box_child)
 			(emit_common_properties w.gtk_box_common_properties n))
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_notebook w = 
  let sons_code = List.flatten 
		    (List.map emit_widget_code w.gtk_notebook_widgets) 
  in
  let n = w.gtk_notebook_name in
  let sigs_code = emit_sigs_code n w.gtk_notebook_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.notebook\n%s%s%s%s%s%s%s%s%s()\nin\n%s"
			n  
			(emit_optional_cons "~tab_pos:" w.gtk_notebook_tab_pos)
			(emit_optional_int "~tab_border:" w.gtk_notebook_tab_border)
			(emit_optional_bool 
			   "~homogeneous_tabs" 
			   w.gtk_notebook_homogeneous_tab)
			(emit_optional_bool "~show_border:"
			   w.gtk_notebook_show_border)
			(emit_optional_bool "~scrollable:" 
			   w.gtk_notebook_scrollable)
			(emit_optional_bool "~popup:" 
			   w.gtk_notebook_popup)
			(emit_optional_int "~border_width:" 
			   w.gtk_notebook_border_width)

			(emit_optional_size w.gtk_notebook_size)
			(emit_optional_packer "~packing:" 
			   w.gtk_notebook_parent_packer 
			   w.gtk_notebook_child)
 			(emit_common_properties w.gtk_notebook_common_properties n))
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_pan dir w = 
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_pan_widgets) in
  let n = w.gtk_pan_name in
  let sigs_code = emit_sigs_code n w.gtk_pan_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.paned\n%s%s%s%s%s()\nin\n%s"
			n (match dir with Horizontal -> " `HORIZONTAL"
			     | Vertical -> " `VERTICAL") 
			(emit_optional_int "~handle_size:" w.gtk_pan_handle_size)
			(emit_optional_int "~border_width:" 
			   w.gtk_pan_border_width)
			(emit_optional_size w.gtk_pan_size)
			(emit_optional_packer "~packing:" 
			   w.gtk_pan_parent_packer w.gtk_pan_child)
 			(emit_common_properties w.gtk_pan_common_properties n))
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_table w = 
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_table_widgets) in
  let n = w.gtk_table_name in
  let sigs_code = emit_sigs_code n w.gtk_table_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.table\n%s%s%s%s%s%s%s%s()\nin\n%s"
			n
			(emit_optional_int "~rows:" w.gtk_table_rows)
			(emit_optional_int "~columns:" w.gtk_table_columns)
			(emit_optional_int "~row_spacings:" w.gtk_table_row_spacing)
			(emit_optional_int
			   "~col_spacings:"
			   w.gtk_table_column_spacing)
			(emit_optional_int "~border_width:" w.gtk_table_border_width)
			(emit_optional_bool "~homogeneous:"w.gtk_table_homogeneous)
			(emit_optional_size w.gtk_table_size)
			(emit_optional_packer "~packing:" 
			   w.gtk_table_parent_packer w.gtk_table_child)
 			(emit_common_properties w.gtk_table_common_properties n))
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_fixed w = 
  let sons_code = List.flatten (List.map emit_widget_code w.gtk_table_widgets) in
  let n = w.gtk_table_name in
  let sigs_code = emit_sigs_code n w.gtk_table_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.fixed\n%s%s%s()\nin\n%s"
			n
			(emit_optional_int "~border_width:" 
			   w.gtk_table_border_width)
			(emit_optional_size w.gtk_table_size)
			(emit_optional_packer "~packing:" 
			   w.gtk_table_parent_packer w.gtk_table_child)
 			(emit_common_properties w.gtk_table_common_properties n))
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_buttonbox dir w = 
  let sons_code = List.flatten 
		    (List.map emit_widget_code w.gtk_buttonbox_widgets)
  in
  let n = w.gtk_buttonbox_name in
  let sigs_code = emit_sigs_code n w.gtk_buttonbox_signals in
    {for_main = "","";
     for_interface_mli = "";
     for_interface = (Printf.sprintf
			"let %s = GPack.button_box %s\n%s%s%s%s%s%s%s%s()\nin\n%s"
			n (match dir with Horizontal -> "`HORIZONTAL"
			     | Vertical -> "`VERTICAL") 
			(emit_optional_int "~spacing:" w.gtk_buttonbox_spacing)
			(emit_optional_int "~child_width:" 
			   w.gtk_buttonbox_child_width)
			(emit_optional_int "~child_height:" 
			   w.gtk_buttonbox_child_height)
			(emit_optional_int "~child_ipadx:" 
			   w.gtk_buttonbox_child_ipadx)
			(emit_optional_int "~child_ipady:" 
			   w.gtk_buttonbox_child_ipady)
			(emit_optional_int "~border_width:" 
			   w.gtk_buttonbox_border_width)
			(emit_optional_cons "~layout:" 
			   w.gtk_buttonbox_layout)
			(emit_optional_packer "~packing:"
			   w.gtk_buttonbox_parent_packer w.gtk_buttonbox_child)
			(emit_common_properties w.gtk_buttonbox_common_properties n) 
		     )
		       ,Printf.sprintf "method %s = %s\n" n n,"" ;
     for_sig_connect = sigs_code.for_sig_connect;
     for_callbacks = sigs_code.for_callbacks
    }::sons_code

and  emit_code_gtk_scrolled_window w = 
  let n = w.gtk_scrolled_window_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_scrolled_window_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_scrolled_window_signals in
    concat_source 
      sigs_code
      {for_main = "","";
       for_interface_mli = "";
       for_interface = (Printf.sprintf
			  "let %s = GBin.scrolled_window\n%s%s%s()\nin\n%s"
			  n
			  (emit_optional_cons "~hpolicy:" 
			     w.gtk_scrolled_window_hscrollbar_policy)
			  (emit_optional_cons "~vpolicy:"
			     w.gtk_scrolled_window_vscrollbar_policy)
			  (emit_optional_packer "~packing:" 
			     w.gtk_scrolled_window_parent_packer 
			     w.gtk_scrolled_window_child)
			  (emit_common_properties w.gtk_scrolled_window_common_properties n)
 		       )
			 ,Printf.sprintf "method %s = %s\n" n n,"";
       for_sig_connect = "";
       for_callbacks =  [],[]
      }::sons_code

and  emit_code_gtk_viewport w = 
  let n = w.gtk_viewport_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_viewport_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_viewport_signals in
    concat_source sigs_code
      {for_main = "","";
       for_interface_mli = "";
       for_interface = (Printf.sprintf
			  "let %s = GBin.viewport %s%s()\nin\n%s"
			  n
			  (emit_optional_cons "~shadow_type:" 
			     w.gtk_viewport_shadow_type)
			  (emit_optional_packer "~packing:" 
			     w.gtk_viewport_parent_packer w.gtk_viewport_child)
 		     	  (emit_common_properties w.gtk_viewport_common_properties n)
		       )
			 ,Printf.sprintf "method %s = %s\n" n n,"";
       for_sig_connect = "" ;
       for_callbacks =  [],[]
      }::sons_code

and  emit_code_gtk_menubar w = 
  let n = w.gtk_menubar_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_menubar_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_menubar_signals in
    concat_source sigs_code
      {for_main = "","";
       for_interface_mli = "";
       for_interface = (Printf.sprintf
			  "let %s = GMenu.menu_bar %s%s()\nin\n%s%s"
			  n
			  (emit_optional_int "~border_width:" 
			     w.gtk_menubar_border_width)
			  (emit_optional_packer "~packing:" 
			     w.gtk_menubar_parent_packer w.gtk_menubar_child)
			  (emit_optional_property_int (n^"#set_border_width")
			     w.gtk_menubar_border_width)
 		     	  (emit_common_properties w.gtk_menubar_common_properties n)
		       )
			 ,Printf.sprintf "method %s = %s\n" n n,"";
       for_sig_connect = "" ;
       for_callbacks =  [],[]
      }::sons_code

and  emit_code_gtk_menuitem w = 
  let n = w.gtk_menuitem_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_menuitem_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_menuitem_signals in
    concat_source sigs_code
      {for_main = "","";
       for_interface_mli = "";
       for_interface = (Printf.sprintf
			  "let %s = GMenu.menu_item %s%s%s%s%s()\nin\n%s%s"
			  n
			  (emit_optional_string "~label:" 
			     w.gtk_menuitem_label)
			  (emit_optional_int "~border_width:" 
			     w.gtk_menuitem_border_width)
			  (emit_optional_packer "~packing:" 
			     w.gtk_menuitem_parent_packer w.gtk_menuitem_child)
			  (emit_optional_int "~border_width:" 
			     w.gtk_menuitem_border_width)
			  (emit_optional_size w.gtk_menuitem_size)
			  (emit_optional_property_bool_if_true 
			     (n^"#right_justify") "()" 
			     w.gtk_menuitem_right_justify)
 		     	  (emit_common_properties w.gtk_menuitem_common_properties n)
		       )
			 ,Printf.sprintf "method %s = %s\n" n n,"";
       for_sig_connect = "" ;
       for_callbacks =  [],[]
      }::sons_code

and  emit_code_gtk_menu w = 
  let n = w.gtk_menuitem_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_menuitem_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_menuitem_signals in
    concat_source sigs_code
      {for_main = "","";
       for_interface_mli = "";
       for_interface = (Printf.sprintf
			  "let %s = GMenu.menu %s%s()\nin\n%s%s"
			  n
			  (emit_optional_int "~border_width:" 
			     w.gtk_menuitem_border_width)
			  (emit_optional_packer "~packing:" 
			     w.gtk_menuitem_parent_packer w.gtk_menuitem_child)
			  (emit_optional_property_int
			     (n^"#set_border_width") w.gtk_menuitem_border_width)
 		     	  (emit_common_properties w.gtk_menuitem_common_properties n)
		       )
			 ,Printf.sprintf "method %s = %s\n" n n,"";
       for_sig_connect = "" ;
       for_callbacks =  [],[]
      }::sons_code

and emit_code_gtk_button w = 
  let n =  w.gtk_button_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_button_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_button_signals
  in
    (concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GButton.button\n%s%s%s%s()\nin\n%s"
	     w.gtk_button_name 
	     (emit_optional_packer "~packing:" 
		w.gtk_button_parent_packer w.gtk_button_child)
	     (emit_optional_string "~label:" w.gtk_button_label)
	     (emit_optional_int "~border_width:" w.gtk_button_border_width)
	     (emit_optional_size w.gtk_button_size)
 	     (emit_common_properties w.gtk_button_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; })::sons_code

and emit_code_gtk_rbutton w = 
  let n =  w.gtk_rbutton_name in
  let sigs_code = emit_sigs_code n w.gtk_rbutton_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GButton.radio_button\n%s%s%s%s%s%s%s()\nin\n%s"
	     w.gtk_rbutton_name
 	     (emit_optional_cons "~group:" w.gtk_rbutton_group)
	     (emit_optional_packer "~packing:" 
		w.gtk_rbutton_parent_packer w.gtk_rbutton_child)
	     (emit_optional_string "~label:" w.gtk_rbutton_label)
	     (emit_optional_bool 
		"~draw_indicator:" w.gtk_rbutton_draw_indicator)
	     (emit_optional_bool "~active:" w.gtk_rbutton_active)
	     (emit_optional_int "~border_width:" w.gtk_rbutton_border_width)
	     (emit_optional_size w.gtk_rbutton_size)
 	     (emit_common_properties w.gtk_rbutton_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; }]

and emit_code_gtk_tbutton w = 
  let n =  w.gtk_tbutton_name in
  let sigs_code = emit_sigs_code n w.gtk_tbutton_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GButton.toggle_button\n%s%s%s%s%s()\nin\n%s"
	     w.gtk_tbutton_name 
	     (emit_optional_packer "~packing:" 
		w.gtk_tbutton_parent_packer w.gtk_tbutton_child)
	     (emit_optional_bool "~active:" w.gtk_tbutton_active)
	     (emit_optional_string "~label:" w.gtk_tbutton_label)
	     (emit_optional_int "~border_width:" w.gtk_tbutton_border_width)
	     (emit_optional_size w.gtk_tbutton_size)
 	     (emit_common_properties w.gtk_tbutton_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks = [],[]; }]

and emit_code_gtk_handlebox w = 
  let n =  w.gtk_handlebox_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_handlebox_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_handlebox_signals
  in
    (concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GBin.handle_box\n%s%s%s\n()\nin\n%s"
	     w.gtk_handlebox_name 
	     (emit_optional_packer "~packing:" w.gtk_handlebox_parent_packer 
		w.gtk_handlebox_child)
	     (emit_optional_int "~border_width:" w.gtk_handlebox_border_width)
	     (emit_optional_size w.gtk_handlebox_size)
	     (emit_common_properties w.gtk_handlebox_common_properties n)

	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       })::sons_code

and emit_code_gtk_separator dir w = 
  let n =  w.gtk_separator_name in
  let sigs_code = emit_sigs_code n w.gtk_separator_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMisc.separator\n%s%s%s\n()\nin\n%s"
	     w.gtk_separator_name 
	     (match dir with Horizontal -> "`HORIZONTAL"
		| Vertical -> "`VERTICAL")
	     (emit_optional_packer "~packing:" 
		w.gtk_separator_parent_packer w.gtk_separator_child)
	     (emit_optional_size w.gtk_separator_size)
 	     (emit_common_properties w.gtk_separator_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       }]

and emit_code_gtk_statusbar w = 
  let n =  w.gtk_statusbar_name in
  let sigs_code = emit_sigs_code n w.gtk_statusbar_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMisc.statusbar\n%s%s%s()\nin\n%s"
	     w.gtk_statusbar_name 
	     (emit_optional_packer "~packing:" w.gtk_statusbar_parent_packer 
		w.gtk_statusbar_child)
	     (emit_optional_size w.gtk_statusbar_size)
	     (emit_optional_int "~border_width:" w.gtk_statusbar_border_width)
 	     (emit_common_properties w.gtk_statusbar_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       }]

and emit_code_gtk_entry w = 
  let n =  w.gtk_entry_name in
  let sigs_code = emit_sigs_code n w.gtk_entry_signals
  in
    [concat_source sigs_code 
       {for_interface_mli = "";
	for_main = "","";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GEdit.entry\n%s%s%s%s%s()\nin\n%s"
	     n 
	     (emit_optional_packer "~packing:" w.gtk_entry_parent_packer
		w.gtk_entry_child)
	     (emit_optional_string "~text:" w.gtk_entry_text) 
	     (emit_optional_int "~max_length:" w.gtk_entry_text_max_length)
	     (emit_optional_bool "~visibility:" w.gtk_entry_text_visible)
	     (emit_optional_bool "~editable:" w.gtk_entry_editable)
 	     (emit_common_properties w.gtk_entry_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       }]

and emit_code_gtk_toolbar w = 
  let n =  w.gtk_toolbar_name in
  let sons_code = List.flatten (List.map emit_widget_code 
				  w.gtk_toolbar_widgets)
  in
  let sigs_code = emit_sigs_code n w.gtk_toolbar_signals
  in
    (concat_source sigs_code 
       {for_interface_mli = "";
	for_main = "","";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GButton.toolbar\n%s%s%s%s%s%s%s%s%s()\nin\n%s"
	     n 
	     (emit_optional_packer "~packing:" w.gtk_toolbar_parent_packer
		w.gtk_toolbar_child)
	     (emit_optional_cons "~orientation:" w.gtk_toolbar_orientation) 
	     (emit_optional_cons "~style:" w.gtk_toolbar_style)
	     (emit_optional_cons "~button_relief:" w.gtk_toolbar_relief)
	     (emit_optional_bool "~tooltips:" w.gtk_toolbar_tooltips)
	     (emit_optional_int "~space_size:" w.gtk_toolbar_space_size)
	     (emit_optional_int "~border_width:" w.gtk_toolbar_border_width)
	     (emit_optional_cons "~space_style:" w.gtk_toolbar_space_style)
	     (emit_optional_size w.gtk_toolbar_size)
 	     (emit_common_properties w.gtk_toolbar_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       })::sons_code


(* This one is not finished: values in the list etc. *)
and emit_code_gtk_combo w = 
  let n =  w.gtk_combo_name in
  let sons_code = [] (* and not [List.flatten (List.map
			emit_widget_code w.gtk_combo_widgets)]
			because it is done by default.*)
  in
  let sigs_code = emit_sigs_code n w.gtk_combo_signals
  in
    (concat_source sigs_code 
       {for_interface_mli = "";
	for_main = "","";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GEdit.combo\n%s%s%s%s%s%s%s%s()\nin\n%s"
	     n 
	     (emit_optional_packer "~packing:" w.gtk_combo_parent_packer
		w.gtk_combo_child)
	     (emit_optional_bool "~value_in_list:" w.gtk_combo_value_in_list)
	     (emit_optional_bool "~ok_if_empty:" w.gtk_combo_ok_if_empty)
	     (emit_optional_bool "~case_sensitive:" w.gtk_combo_case_sensitive)
	     (emit_optional_cons "~use_arrows:" 
		(match 
		   w.gtk_combo_use_arrows_always,w.gtk_combo_use_arrows 
		 with
		   | Some true,_ -> Some "`ALWAYS"
		   | _,Some true -> Some "`DEFAULT" 
		   | _,Some false -> Some "`NEVER"
		   | _,_ -> None )
	     )
	     (emit_optional_string_list "~popdown_strings:" w.gtk_combo_items)
	     (emit_optional_int "~border_width:" w.gtk_combo_border_width)
	     (emit_optional_size w.gtk_combo_size)
 	     (emit_common_properties w.gtk_combo_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]
       })::sons_code

and emit_code_gtk_text w = 
  let n = w.gtk_text_name in
  let sigs_code = emit_sigs_code  n  w.gtk_text_signals
  in
    [concat_source sigs_code 
       {for_main = "","";   
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GEdit.text\n%s%s()\nin\n
 let _ = %s#insert_text ~pos:0 \"%s\" in\n%s"
	     w.gtk_text_name 
	     (emit_optional_packer "~packing:" w.gtk_text_parent_packer
		w.gtk_text_child)
	     (emit_optional_bool "~editable:" w.gtk_text_editable) 
	     w.gtk_text_name
	     (try (out_some w.gtk_text_text) with _ -> "")
	     (emit_common_properties w.gtk_text_common_properties n)
	  )
	  ,Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "" ;
	for_callbacks =  [],[];}]

and emit_code_gtk_checkb w = 
  let n = w.gtk_checkb_name in
  let sigs_code = 
    emit_sigs_code n w.gtk_checkb_signals in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GButton.check_button\n%s%s()\nin\n%s"
	     w.gtk_checkb_name 
	     (emit_optional_string "~label:" w.gtk_checkb_label)
	     (emit_optional_packer "~packing:" w.gtk_checkb_parent_packer 
		w.gtk_checkb_child)
 	     (emit_common_properties w.gtk_checkb_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]}]

and emit_code_gtk_label w = 
  if w.gtk_label_common_properties.child_name <> Some "Notebook:tab" then
  let n = w.gtk_label_name in
  let sigs_code = 
    emit_sigs_code n w.gtk_label_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMisc.label\n%s%s%s%s%s%s%s%s()\nin\n%s"
	     n 
	     (emit_optional_string "~text:" w.gtk_label_label)
	     (emit_optional_packer "~packing:" w.gtk_label_parent_packer 
		w.gtk_label_child)
	     (emit_optional_float "~xalign:" w.gtk_label_xalign)	
	     (emit_optional_float "~yalign:" w.gtk_label_yalign)	
	     (emit_optional_int "~xpad:" w.gtk_label_xpad)	
	     (emit_optional_int "~ypad:" w.gtk_label_ypad)	
	     (emit_optional_bool "~line_wrap:" w.gtk_label_wrap)
	     (emit_optional_size w.gtk_label_size)
 	     (emit_common_properties w.gtk_label_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "" ;
	for_callbacks =  [],[]}]
  else
    [] (* TODO what should we emit to change the label of at
	  notebook tab ? *)

and emit_code_gtk_pixmap w = 
  let n = w.gtk_pixmap_name in
  let sigs_code = 
    emit_sigs_code n w.gtk_pixmap_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GMisc.pixmap\n%s%s%s%s%s%s%s()\nin\n%s"
	     n 
	     (emit_optional_string_complex
		("(GDraw.pixmap_from_xpm ~window:"^
		 !current_window_name^
		 " ~file:") w.gtk_pixmap_filename "())")
	     (emit_optional_packer "~packing:" w.gtk_pixmap_parent_packer 
		w.gtk_pixmap_child)
	     (emit_optional_float "~xalign:" w.gtk_pixmap_xalign)	
	     (emit_optional_float "~yalign:" w.gtk_pixmap_yalign)	
	     (emit_optional_int "~xpad:" w.gtk_pixmap_xpad)	
	     (emit_optional_int "~ypad:" w.gtk_pixmap_ypad)	
	     (emit_optional_size w.gtk_pixmap_size)
 	     (emit_common_properties w.gtk_pixmap_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "" ;
	for_callbacks =  [],[]}]

and emit_code_gtk_tree w = 
  let n =  w.gtk_tree_name in
  let sigs_code = emit_sigs_code n w.gtk_tree_signals in
    [concat_source sigs_code 
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GTree.tree\n%s\n%s%s%s()\nin\n%s"
	     w.gtk_tree_name 
	     (emit_optional_cons "~selection_mode:" w.gtk_tree_selection_mode) 
	     (emit_optional_bool "~view_lines:" w.gtk_tree_view_line) 
	     (emit_optional_cons "~view_mode:" w.gtk_tree_view_mode)
	     (emit_optional_packer "~packing:" w.gtk_tree_parent_packer 
		w.gtk_tree_child)
 	     (emit_common_properties w.gtk_tree_common_properties n)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "";
	for_callbacks =  [],[]}]

and emit_code_gtk_list w = 
  let n = w.gtk_list_name in
  let sigs_code = 
    emit_sigs_code n w.gtk_list_signals
  in
    [concat_source sigs_code
       {for_main = "","";
	for_interface_mli = "";
	for_interface = 
	  (Printf.sprintf
	     "let %s = GList.liste\n%s%s()\nin\n"
	     n 
	     (emit_optional_cons "~selection_mode:" w.gtk_list_selection_mode)
	     (emit_optional_packer "~packing:" w.gtk_list_parent_packer 
		w.gtk_list_child)
	  ),Printf.sprintf "method %s = %s\n" n n,"";
	for_sig_connect = "" ;
	for_callbacks = sigs_code.for_callbacks}]



and emit_widget_code w =
  let print_string s = () in 
    match w with
      | GtkDrawingArea w ->
	  print_string "Emiting drawingarea\n";
	  emit_code_gtk_drawing_area w
      | GtkFrame w ->
	  print_string "Emiting frame\n";
	  emit_code_gtk_frame w

      | GtkOptionMenu w ->
	  print_string "Emiting option menu\n";
	  emit_code_gtk_omenu w

      | GtkNotebook w -> print_string "Emiting notebook\n";
	  emit_code_gtk_notebook w
      |	GtkCombo w -> print_string "Emiting combo\n";
	  emit_code_gtk_combo w
      | GtkList w -> print_string "Emiting list\n"; 
	  emit_code_gtk_list w
      | Placeholder -> print_string "Emiting placeholder\n"; []
      | GtkFileSelection w -> print_string "Emiting fileselection\n"; 
	  emit_code_gtk_file_selection w
      | GtkStatusBar w -> 
	  print_string "Emiting statusbar\n"; emit_code_gtk_statusbar w
      | GtkWindow w -> print_string "Emiting window\n"; emit_code_gtk_window w
      | GtkVSeparator w -> print_string "Emiting vseparator\n"; 
	  emit_code_gtk_separator Vertical w
      | GtkHSeparator w -> print_string "Emiting hseparator\n"; 
	  emit_code_gtk_separator Horizontal w
      | GtkButton w -> print_string "Emiting button\n"; emit_code_gtk_button w
      | GtkToggleButton w -> print_string "Emiting toggle button\n";
	  emit_code_gtk_tbutton w
      | GtkRadioButton w -> print_string "Emiting radio button\n";
	  emit_code_gtk_rbutton w
      | GtkTable w -> print_string "Emiting table\n"; 
	  emit_code_gtk_table w
      | GtkFixed w -> print_string "Emiting fixed\n"; 
	  emit_code_gtk_fixed w
      | GtkHBox w -> print_string "Emiting hbox\n"; 
	  emit_code_gtk_box Horizontal w
      | GtkVBox w -> print_string "Emiting vbox\n"; 
	  emit_code_gtk_box Vertical w
      | GtkHPan w -> print_string "Emiting hpan\n"; 
	  emit_code_gtk_pan Horizontal w
      | GtkVPan w -> print_string "Emiting vpan\n"; 
	  emit_code_gtk_pan Vertical w
      | GtkVButtonBox w -> print_string "Emiting vbuttonbox\n"; 
	  emit_code_gtk_buttonbox Vertical w
      | GtkHButtonBox w -> print_string "Emiting hbuttonbox\n"; 
	  emit_code_gtk_buttonbox Horizontal w
      | GtkEntry w -> print_string "Emiting entry\n"; emit_code_gtk_entry w
      | GtkLabel w -> print_string "Emiting label\n"; emit_code_gtk_label w
      | GtkPixmap w -> print_string "Emiting pixmap\n"; emit_code_gtk_pixmap w
      | GtkCheckb w -> print_string "Emiting check button\n"; 
	  emit_code_gtk_checkb w
      | GtkToolbar w -> print_string "Emiting toolbar\n"; 
	  emit_code_gtk_toolbar w
      | GtkScrolledWindow w -> print_string "Emiting scrolled window\n"; 
	  emit_code_gtk_scrolled_window w
      | GtkViewPort w -> 
	  print_string "Emiting viewport\n"; 
	  emit_code_gtk_viewport w
      | GtkMenuBar w -> 
	  print_string "Emiting menu bar\n"; 
	  emit_code_gtk_menubar w
      | GtkMenuItem w  -> 
	  print_string "Emiting menu item\n"; 
	  emit_code_gtk_menuitem w
      | GtkMenu w ->
	  print_string "Emiting menu\n"; 
	  emit_code_gtk_menu w
      | GtkText w -> 
	  print_string "Emiting text\n"; 
	  emit_code_gtk_text w
      | GtkTree w -> 
	  print_string "Emiting tree\n"; 
	  emit_code_gtk_tree w
      | GtkHandleBox w -> 
	  print_string "Emiting handlebox\n"; 
	  emit_code_gtk_handlebox w

let generate_project_skel project_t = 
  {for_main = 
     "open GMain
class customized_callbacks = object(self)
inherit "^(String.capitalize project_t.program_name)^"_glade_callbacks.default_callbacks
end
let main () = 
let callbacks = new customized_callbacks in\n",
     "Main.main ()\n\nlet _ = Printexc.print main ()\n";
    for_interface_mli = "";
    for_sig_connect = "";
    for_interface = "","","";
    for_callbacks =  [],[]
   }

let generate_callbacks meth initializers s = 
  Printf.fprintf s "(* THIS IS A GENERATED FILE. DO NOT EDIT.*)\n";
  Printf.fprintf s "class default_callbacks = object(self)\n";
  List.iter (function x -> if x<>"" then 
	       Printf.fprintf s "%s\n" x) initializers;
  List.iter (function tag,profile,body ->
	    Printf.fprintf s "%s %s\n" profile body ) meth;
  Printf.fprintf s "end\n"

let output_codes opt_file project_t proj widgs = 
  let dir = 
    match opt_file with 
      |None -> ""
      |Some s -> Filename.dirname s
  in
  let open_out s = open_out (Filename.concat dir s) in

  let main = 
    (fst proj.for_main)^(List.fold_right
			   (fun widg acc -> 
			      (List.fold_right 
				 (fun c acc  -> (fst c.for_main)^acc^(snd c.for_main)) 
				 widg "") ^ acc)
			   widgs "")^(snd proj.for_main)
  in
  let interfaces = 
    List.map 
      (function widg -> 
	 let left = 
	   List.fold_right
  	     (fun c acc  -> 
		(fst2 c.for_interface)^acc^ 
		c.for_sig_connect)
	     widg "" 
	 in
	 let right = 
	   List.fold_right
  	     (fun c acc  -> 
		(snd2 c.for_interface)^acc)
	     widg ""
	 in let initial = 
	     List.fold_right
  	       (fun c acc  -> 
		  (thr2 c.for_interface)^acc)
	       widg ""

	 in
	   if left="" then "" 
	   else left^"object(self)\n"^right^initial^
	     "end\n"
      )
      widgs
  in
  let interface =  (fst2 proj.for_interface)^ 
		   (List.fold_right (fun x acc -> x^acc) interfaces "")^
		   (snd2 proj.for_interface)
  in
  let interface_mli = 
    proj.for_interface_mli^
    (List.fold_right
       (fun widg acc -> 
	  (List.fold_right 
	     (fun c acc  -> (acc^"\n"^c.for_interface_mli)) 
	     widg "") ^ acc)
       widgs "")
  in
  let callbacks,initializers =
    let flattened_wigs = List.flatten widgs in
      (snd proj.for_callbacks)@
      (List.fold_left (fun acc widg -> (snd widg.for_callbacks) @ acc) []
	 flattened_wigs),
      (List.fold_left (fun acc widg -> (fst widg.for_callbacks) @ acc) []
	 flattened_wigs)
  in 

  let project_file = (project_t.program_name^"_glade_main.ml") in
    if not (Sys.file_exists project_file) 
    then 
      let main_c = open_out project_file in
	output_string main_c "(* THIS FILE WILL NEVER BE OVERWRITTEN.
Use it as a template for your own main module.*)\n";
	output_string main_c main;
	close_out main_c
    else warning (project_file ^" exists and is preserved");
    begin    
      let interface_c = 
	open_out (project_t.program_name^"_glade_interface.ml")
      in
	output_string interface_c 
	  "(* THIS IS A GENERATED FILE : DO NOT EDIT ! *)\n";
	output_string interface_c interface;
	close_out interface_c
    end;
    begin
      let callbacks_c = 
	open_out (project_t.program_name^"_glade_callbacks.ml") 
      in
	generate_callbacks callbacks initializers callbacks_c;
	close_out callbacks_c;
    end;
    if not (Sys.file_exists "makefile") 
    then 
      let n = project_t.program_name in
	let makefile_c = open_out "makefile" in
	      output_string makefile_c (n^": dummy
\tocamlc  -c -I +lablgtk -labels -c "^n^"_glade_interface.ml
\tocamlc  -c -i -I +lablgtk -labels -c "^n^"_glade_callbacks.ml
\tocamlc  -c -I +lablgtk -c "^n^"_glade_main.ml
\tocamlc -I +lablgtk -o "^n^" lablgtk.cma gtkInit.cmo "^n^"_glade_callbacks.cmo "^n^"_glade_interface.cmo "^n^"_glade_main.cmo
"^n^".opt: dummy
\tocamlopt -c -I +lablgtk -labels -c "^n^"_glade_interface.ml
\tocamlopt -c -I +lablgtk -labels -c "^n^"_glade_callbacks.ml
\tocamlopt -c -I +lablgtk -c "^n^"_glade_main.ml
\tocamlopt -I +lablgtk -labels -o "^n^".opt lablgtk.cmxa gtkInit.cmx "^n^"_glade_callbacks.cmx "^n^"_glade_interface.cmx "^n^"_glade_main.cmx
clean:
\trm -f *.cm* *.o a.out "^n^" "^n^".opt
dummy:
");
	      close_out makefile_c
	  else warning "makefile already exists and is preserved"

let process_elt opt_file c elt = match elt with
    Eelement ("GTK-Interface",[], r) ->
      let r,project_info = out_some (find_first_field "project" r) in
      let project_t = analyze_project project_info in
      let widgets = analyze_widgets No_packer r in
      let project_code = generate_project_skel project_t in
      let widgets_codes = (List.map emit_widget_code widgets) in
      output_codes opt_file project_t project_code widgets_codes
  | _ -> error "No GTK-Interface"

let process_doc opt_file c doc =
  match doc with 
      XML(Prolog(Some XMLDecl (ver,None,None),None,propil),elt,[]) -> process_elt opt_file c elt
    | _ -> error "Probably not a glade document because of prolog or process instr."

(*i This code could be for the next version.
class basic_widget = object(self)
  val mutable name = (None:string option)
  method emit_name () = emit_option name
  method parse_name w = name <- find_first_string "name" w

  val mutable parent_packer = (None:parent_packer_t option)
  method set_parent_packer s = parent_packer <- Some s
  method emit_parent_packer () = emit_optional_packer "~packing:" 
				   (out_some parent_packer)
  method parse_parent_packer w = find_first_string "packing" 

  val mutable size = (None:widget_size_t option)
  method set_size s = parent_packer <- Some s
  method emit_size () = emit_optional_size (out_some size)
  method parse_size w = analyze_size w

  method emit () = ("let " ^(self#emit_name ())^" =\n") , " in\n" 

  method parse w = 
    self#parse_name w ; 
    self#parse_parent_packer w; 
    self#parse_size w
end

class window = object(self)
  inherit basic_widget as super
  val mutable title = (None:string option)
  method set_title s = parent_packer <- Some s
  method emit_title () = emit_optional_string "~title" title
			   
  method emit () = let f,s = super#emit () in
   f^"Window.create "^(self#emit_title ()),s
end

i*)
