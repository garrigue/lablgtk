class virtual rwidget :
  classe:string ->
  widget:#GObj.widget ->
  ?root:bool ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method virtual emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class virtual rcontainer :
  widget:#GContainer.container ->
  name:string ->
  setname:(string -> unit) ->
  ?root:bool ->
  classe:string ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rwindow :
  widget:GWindow.window ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rbox :
  dir:Gtk.Tags.orientation ->
  widget:GPack.box ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rhbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
class rvbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
class rbutton :
  widget:GButton.button ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rlabel :
  widget:GMisc.label ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rframe :
  widget:GFrame.frame ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
val new_rwidget :
  classe:string -> name:string -> setname:(string -> unit) -> rwidget
