open Gtk.Tags
open GObj
open GPack
open GFrame
open GMisc
open GButton
open GWindow
open GContainer

open Property


let rec list_remove pred:f = function
  | [] -> []
  | hd :: tl -> if f hd then tl else hd :: (list_remove pred:f tl)

let rec list_split pred:f = function
  | [] -> [], []
  | hd :: tl -> let g, d = list_split pred:f tl in
    if f hd then (hd :: g, d) else (g, hd :: d)



class virtual rwidget :classe :widget ?:root [<false>]
    name:n :setname =
  object(self : 's)
    val classe : string = classe
    val mutable name : string = n
    val evbox =
      if root then None
      else let ev = new event_box in ev#add widget; Some ev
    val widget = (widget :> widget)

    val mutable parent : 's option = None
    val mutable proplist : (string * property) list = []

(* pack_type et int servent dans le cas des boites
   (pas int pour l'instant) *)
    val mutable children : ('s * pack_type * int) list = []

    method name = name
    method proplist = proplist
    method change_name_in_proplist : string -> string -> unit =
      failwith (name ^ "::change_name_in_proplist")

    method set_name n : unit =
      if (name <> n) && (test_unique n) then begin
	let oldname = name in name <- n; setname n;
	begin match parent with
	|	None -> ()
	|	Some p when p#classe = "vbox" || p#classe = "hbox" ->
	    p#change_name_in_proplist oldname n
	| _	-> () end;
	property_update ()
      end

    method base = match evbox with
    | None -> widget
    | Some ev -> (ev :> widget)
    method classe = classe
    method widget = widget
    method set_parent p = parent <- Some p
    method parent = match parent with
    | None -> failwith "parent not defined"
    | Some c -> c
(*  method destroy = widget#destroy a revoir *)

    method pack : 's -> ?from:pack_type -> unit = failwith (name ^ "::pack")
    method add        : 's -> unit = failwith (name ^ "::add")
    method remove     : 's -> unit = failwith (name ^ "::remove")

    method private emit_start_code : Oformat.c -> unit = fun _ -> ()
    method private emit_end_code : Oformat.c -> unit = fun _ -> ()
    method virtual emit_code : Oformat.c -> unit

    initializer
      proplist <-  proplist @
	[  "name", String (new rval init:name setfun:self#set_name); 
           "width",        Int (new rval init:(-2)
	     setfun:(fun v -> widget#misc#set width:v));
           "height",       Int (new rval init:(-2)
	     setfun:(fun v -> widget#misc#set height:v))  ]
end

class virtual rcontainer widget:(container : #container) :name :setname ?:root [<false>] :classe = object(self)
  inherit rwidget widget:container :name :setname :root :classe

  method add rw =
    container#add (rw#base);
    children <- [ rw, `START, 0 ]
  method remove rw =
    container#remove (rw#base);
    children <- []

  method emit_code c =
    self#emit_start_code c;
    Format.fprintf c#formatter
      "%s#set_border_width %d;@\n"
      name (get_int_prop "border width" in:proplist);
    begin match children with
    | [] -> Format.fprintf c#formatter "();@\n"
    | [ child, _, _ ] ->
	child#emit_code c;
	Format.fprintf c#formatter "%s#add %s;@\n" name child#name
    | _ -> failwith "bug: rwindow#emit_code"
    end;
    self#emit_end_code c;

  initializer
      proplist <-  proplist @ [
	"border width", Int (new rval init:0
	     setfun:(fun v -> container#set_border_width v)) ]
end

class rwindow widget:(window : window) :name :setname = object(self)
  inherit rcontainer classe:"window" root:true :name :setname widget:window as rwidget

  method private emit_start_code c =
    Format.fprintf c#formatter
      "@[<v 0>open GObj@\nopen GData@\nopen GWindow@\nopen GPack@\nopen GFrame@\nopen GMisc@\nopen GEdit@\nopen GButton@\nopen GMain@\n@\nlet %s () =@\n@]"
      name;
    Format.fprintf c#formatter
      "@[<v 2>let %s  = new window show:true title:\"%s\" allow_shrink:%s@ \
        allow_grow:%s auto_shrink:%s %s %s %s %s in@\n"
      name (get_string_prop "title" in:proplist)
      (get_enum_prop "allow_shrink" in:proplist)
      (get_enum_prop "allow_grow" in:proplist)
      (get_enum_prop "auto_shrink" in:proplist)
      (let x =  get_int_prop "x position" in:proplist in
        if x>0 then (" x:" ^ (string_of_int x)) else "")
      (let y = get_int_prop "y position" in:proplist in
        if y>0 then (" y:" ^ (string_of_int y)) else "")
      (let w = get_int_prop "width" in:proplist in
        if w>0 then (" width:" ^ (string_of_int w)) else "")
      (let h = get_int_prop "height" in:proplist in
        if h>0 then (" height:" ^ (string_of_int h)) else "")

  method private emit_end_code c =
    Format.fprintf c#formatter
      "%s@\n@]@." name

  initializer
    proplist <-	proplist @  [
          "title",
          String (new rval init:name
	    setfun:(fun v -> window#set_wm title:v));
	"allow_shrink", Bool (new rval init:true inits:"true"
	   setfun:(fun v -> window#set_policy allow_shrink:v));
	"allow_grow",   Bool (new rval init:true inits:"true"
	setfun:(fun v -> window#set_policy allow_grow:v));
      "auto_shrink",  Bool (new rval init:false inits:"false"
	setfun:(fun v -> window#set_policy auto_shrink:v));
      "x position",   Int (new rval init:(-2)
	     setfun:(fun v -> window#misc#set x:v));
      "y position",   Int (new rval init:(-2)
	     setfun:(fun v -> window#misc#set y:v))  ]
end

let new_rwindow :name = new rwindow widget:(new window show:true title:name) :name



class rbox dir:(dir : orientation) widget:(box : box) :name :setname =
  let start_index = ref 0 and end_index = ref 0 in
  object(self)
    inherit rcontainer :name :setname widget:box
	classe:(match dir with `VERTICAL -> "vbox" | _ -> "hbox") as rwidget

    method change_name_in_proplist oldn newn =
      proplist <- List.fold_left acc:proplist fun:
	  (fun acc:pl propname ->
	    let prop = List.assoc (oldn ^ propname) in:pl in
	    ((newn ^ propname), prop) ::
	      (List.remove_assoc (oldn ^ propname) in:pl))
	  [ "::expand"; "::fill"; "::padding" ];
      property_update ()
	    
    method pack rw ?from:dir [< `START >] =
      box#pack from:dir (rw#base);
      children <- (rw, dir, !start_index) :: children;
      incr start_index;
      let n = rw#name in
      proplist <-  proplist @ [
        (n ^ "::expand"),  Bool (new rval init:true inits:"true"
	  setfun:(fun v -> box#set_child_packing (rw#base) expand:v));
        (n ^ "::fill"),      Bool (new rval init:true inits:"true"
	  setfun:(fun v -> box#set_child_packing (rw#base) fill:v));
        (n ^ "::padding"),   Int (new rval init:0
	  setfun:(fun v -> box#set_child_packing (rw#base) padding:v))
      ]
         
    method add = self#pack from:`START

    method remove rw =
      box#remove (rw#base);
      children <- list_remove pred:(fun (ch, _, _) -> ch = rw) children;
      let n = rw#name in
      proplist <-  List.fold_left
	  fun:(fun :acc n -> List.remove_assoc n in:acc)
	  acc:proplist [
            (n ^ "::expand"); (n ^ "::fill"); (n ^ "::padding")  ]

    method emit_code c =
      Format.fprintf c#formatter
	"let %s = new box %s homogeneous:%s spacing:%d in@\n"
	name
	(match dir with `VERTICAL -> "`VERTICAL" | _ -> "`HORIZONTAL")
	(get_enum_prop "homogeneous" in:proplist)
	(get_int_prop "spacing" in:proplist);

      let startl, endl =
	list_split pred:(fun (_, dir, _) -> dir=`START) children in
      List.iter
	fun:(fun (rw, _, _) -> rw#emit_code c;
	  Format.fprintf c#formatter
	    "%s#pack %s expand:%s fill:%s padding:%d;@\n"
	    name rw#name
	    (get_enum_prop (rw#name ^ "::expand") in:proplist)
	    (get_enum_prop (rw#name ^ "::fill") in:proplist)
	    (get_int_prop (rw#name ^ "::padding") in:proplist))
	(List.rev startl);
      List.iter
	fun:(fun (rw, _, _) -> rw#emit_code c;
	  Format.fprintf c#formatter
	    "%s#pack from: `END %s expand:%s fill:%s padding:%d;@\n"
	    name rw#name
	    (get_enum_prop (rw#name ^ "::expand") in:proplist)
	    (get_enum_prop (rw#name ^ "::fill") in:proplist)
	    (get_int_prop (rw#name ^ "::padding") in:proplist))
	(List.rev endl);
		    
         
  initializer
    proplist <-  proplist @ [
      "homogeneous",  Bool (new rval init:false inits:"false"
	setfun:(fun v -> box#set_packing homogeneous:v));
      "spacing",      Int (new rval init:0
	setfun:(fun v -> box#set_packing spacing:v)) ]
end

class rhbox = rbox dir:`HORIZONTAL
class rvbox = rbox dir:`VERTICAL

let new_rhbox :name = new rhbox widget:(new box `HORIZONTAL) :name
let new_rvbox :name = new rvbox widget:(new box `VERTICAL) :name



class rbutton widget:(button : button) :name :setname = object(self)
  inherit rcontainer classe:"button" :name :setname widget:button as rwidget

  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "label",   String (new rval init:name
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_rbutton :name = new rbutton
    widget:(let b = new button label:name in
    b#connect#event#enter_notify
      callback:(fun _ -> b#stop_emit "enter_notify_event"; true);
    b#connect#event#leave_notify
      callback:(fun _ -> b#stop_emit "leave_notify_event"; true); b)
    :name



class rcheck_button widget:(button : check_button) :name :setname = object(self)
  inherit rcontainer classe:"check_button" :name :setname widget:button as rwidget

  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new check_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "label",   String (new rval init:name
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_rcheck_button :name = new rcheck_button
    widget:(let b = new check_button label:name in
(*    b#connect#event#enter_notify
      callback:(fun _ -> b#stop_emit "enter_notify_event"; true);
    b#connect#event#leave_notify
      callback:(fun _ -> b#stop_emit "leave_notify_event"; true); *) b)
    :name



class rtoggle_button widget:(button : toggle_button) :name :setname = object(self)
  inherit rcontainer classe:"toggle_button" :name :setname widget:button as rwidget

  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new toggle_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "label",   String (new rval init:name
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_rtoggle_button :name = new rtoggle_button
    widget:(let b = new toggle_button label:name in
    b#connect#event#enter_notify
      callback:(fun _ -> b#stop_emit "enter_notify_event"; true);
    b#connect#event#leave_notify
      callback:(fun _ -> b#stop_emit "leave_notify_event"; true); b)
    :name



class rlabel widget:(label : label) :name :setname = object(self)
  inherit rwidget classe:"label" :name :setname widget:label as rwidget

  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new label text:\"%s\" in@\n" name
      (get_string_prop "text" in:proplist)
         
  initializer
    label#set_text name;
    proplist <-  proplist @ [
      "text",   String (new rval init:name
             setfun:(fun v -> label#set_text v))
    ]
end

let new_rlabel :name = new rlabel widget:(new label) :name



class rframe widget:(frame : frame) :name :setname = object(self)
  inherit rcontainer classe:"frame" :name :setname widget:frame as rwidget

  method private emit_start_code c =
    Format.fprintf c#formatter
      "let %s = new frame label:\"%s\" label_xalign:%1.1f shadow_type:`%s in@\n"
      name (get_string_prop "label" in:proplist) 
      (get_float_prop "label xalign" in:proplist)
      (get_enum_prop "shadow" in:proplist)
         
  initializer
    frame#set_label name;
    proplist <-  proplist @ [
          "label", String (new rval init:name
	     setfun:(fun v -> frame#set_label v));
          "label xalign", Float (new rval init:0.0 value_list:["min", 0. ; "max", 1.]
             setfun:(fun v -> frame#set_label xalign:v));
          "shadow", Shadow (new rval init:`ETCHED_IN inits:"ETCHED_IN"
	     setfun:(fun v -> frame#set_shadow_type v))
    ]
end

let new_rframe :name = new rframe widget:(new frame) :name


class rscrolled_window widget:(scrolled_window : scrolled_window)
    :name :setname = object(self)
  inherit rcontainer classe:"scrolled_window" :name :setname widget:scrolled_window as rwidget

  method add rw =
    scrolled_window#add_with_viewport (rw#base);
    children <- [ rw, `START, 0 ]

  method private emit_start_code c =
    Format.fprintf c#formatter
      "let %s = new scrolled_window hpolicy:`%s vpolicy:`%s in@\n"
      name
      (get_enum_prop "hscrollbar policy" in:proplist)
      (get_enum_prop "vscrollbar policy" in:proplist)
         
  initializer
    proplist <-  proplist @ [
          "hscrollbar policy", Policy (new rval init:`ALWAYS inits:"ALWAYS"
	     setfun:(fun v -> scrolled_window#set_scrolled hpolicy:v));
          "vscrollbar policy", Policy (new rval init:`ALWAYS inits:"ALWAYS"
	     setfun:(fun v -> scrolled_window#set_scrolled vpolicy:v));
    ]
end

let new_rscrolled_window :name = new rscrolled_window widget:(new scrolled_window) :name


let new_class_list = [
  "window", new_rwindow;
  "hbox",   new_rhbox;
  "vbox",   new_rvbox;
  "button", new_rbutton;
  "check_button", new_rcheck_button;
  "toggle_button", new_rtoggle_button;
  "label",  new_rlabel;
  "frame",  new_rframe;
  "scrolled_window", new_rscrolled_window
]

let new_rwidget :classe = List.assoc classe in:new_class_list




