(** Action-based menus and toolbars *)

(** {3 GtkAction} *)

(** @since GTK 2.4
    @gtkdoc gtk GtkAction *)
class action_signals :
  ([> Gtk.action ] as 'b) Gobject.obj ->
  object ('a)
    val obj : 'b Gobject.obj
    val after : bool
    method after : < after : 'a; .. > as 'a
    method activate : callback:(unit -> unit) -> GtkSignal.id
    method connect_proxy : callback:(GObj.widget -> unit) -> GtkSignal.id
    method disconnect_proxy : callback:(GObj.widget -> unit) -> GtkSignal.id
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkAction *)
class action_skel :
  ([> Gtk.action ] as 'a) Gobject.obj ->
  object
    val obj : 'a Gobject.obj
    method activate : unit -> unit
    method as_action : Gtk.action Gobject.obj
    method connect_accelerator : unit -> unit
    method connect_proxy : GObj.widget -> unit
    method disconnect_accelerator : unit -> unit
    method disconnect_proxy : GObj.widget -> unit
    method get_proxies : GObj.widget list
    method hide_if_empty : bool
    method is_important : bool
    method label : string
    method name : string
    method sensitive : bool
    method set_hide_if_empty : bool -> unit
    method set_is_important : bool -> unit
    method set_label : string -> unit
    method set_sensitive : bool -> unit
    method set_short_label : string -> unit
    method set_stock_id : GtkStock.id -> unit
    method set_tooltip : string -> unit
    method set_visible : bool -> unit
    method set_accel_path : string -> unit
    method short_label : string
    method stock_id : GtkStock.id
    method tooltip : string
    method visible : bool
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkAction *)
class action :
  ([> Gtk.action ] as 'a) Gobject.obj ->
  object
    inherit action_skel
    val obj : 'a Gobject.obj
    method connect : action_signals
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkAction *)
val action : name:string -> unit -> action


(** @since GTK 2.4
    @gtkdoc gtk GtkToggleAction *)
class toggle_action_signals :
  ([> Gtk.toggle_action ] as 'b) Gobject.obj ->
  object
    inherit action_signals
    val obj : 'b Gobject.obj
    method toggled : callback:(unit -> unit) -> GtkSignal.id
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkToggleAction *)
class toggle_action_skel :
  ([> Gtk.toggle_action ] as 'a) Gobject.obj ->
  object
    inherit action_skel
    val obj : 'a Gobject.obj
    method draw_as_radio : bool
    method get_active : bool
    method set_active : bool -> unit
    method set_draw_as_radio : bool -> unit
    method toggled : unit -> unit
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkToggleAction *)
class toggle_action :
  ([> Gtk.toggle_action ] as 'a) Gobject.obj ->
  object
    inherit toggle_action_skel
    method connect : toggle_action_signals
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkToggleAction *)
val toggle_action : name:string -> unit -> toggle_action

(** @since GTK 2.4
    @gtkdoc gtk GtkRadioAction *)
class radio_action_signals :
  ([> Gtk.radio_action] as 'b) Gobject.obj ->
  object
    inherit toggle_action_signals
    val obj : 'b Gobject.obj
    method changed :
      callback:(int -> unit) -> GtkSignal.id
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkRadioAction *)
class radio_action :
  ([> Gtk.radio_action] as 'a) Gobject.obj ->
  object
    inherit toggle_action_skel
    val obj : 'a Gobject.obj
    method connect : radio_action_signals
    method as_radio_action : Gtk.radio_action Gobject.obj
    method get_current_value : int
    method set_group : Gtk.radio_action Gtk.group -> unit
    method set_value : int -> unit
    method value : int
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkRadioAction *)
val radio_action : name:string -> value:int -> unit -> radio_action

(** {3 GtkActionGroup} *)

(** @since GTK 2.4
    @gtkdoc gtk GtkActionGroup *)
class action_group :
  ([> Gtk.action_group ] as 'a) Gobject.obj ->
  object
    val obj : 'a Gobject.obj
    method add_action : #action_skel -> unit
    method as_group : Gtk.action_group Gobject.obj
    method get_action : string -> action
    method list_actions : action list
    method name : string
    method remove_action : #action_skel -> unit
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkActionGroup *)
val action_group : name:string -> unit -> action_group


type 'a entry = action_group -> 'a

val add_action :
  string ->
  ?callback:(action -> unit) ->
  ?stock:GtkStock.id ->
  ?label:string ->
  ?accel:string ->
  ?tooltip:string ->
  unit entry
val add_toggle_action :
  string ->
  ?active:bool ->
  ?callback:(toggle_action -> unit) ->
  ?stock:GtkStock.id ->
  ?label:string ->
  ?accel:string ->
  ?tooltip:string ->
  unit entry
val add_radio_action :
  string ->
  int ->
  ?stock:GtkStock.id ->
  ?label:string ->
  ?accel:string ->
  ?tooltip:string ->
  radio_action entry
val group_radio_actions :
  ?init_value:int ->
  ?callback:(int -> unit) ->
  radio_action entry list ->
  unit entry

val add_actions : action_group -> unit entry list -> unit



(** {3 GtkUIManager} *)

(** @since GTK 2.4
    @gtkdoc gtk GtkUIManager *)
class ui_manager_signals :
  ([> Gtk.ui_manager] as 'b) Gtk.obj ->
  object ('a)
    val after : bool
    val obj : 'b Gtk.obj
    method actions_changed : callback:(unit -> unit) -> GtkSignal.id
    method add_widget : callback:(GObj.widget -> unit) -> GtkSignal.id
    method after : 'a
  end

type ui_id

(** @since GTK 2.4
    @gtkdoc gtk GtkUIManager *)
class ui_manager :
  ([> Gtk.ui_manager] as 'a) Gtk.obj ->
  object
    val obj : 'a Gtk.obj
    method add_tearoffs : bool
    method add_ui_from_file : string -> ui_id
    method add_ui_from_string : string -> ui_id
    method connect : ui_manager_signals
    method ensure_update : unit -> unit
    method get_accel_group : Gtk.accel_group
    method get_action : string -> action
    method get_action_groups : action_group list
    method get_widget : string -> GObj.widget
    method insert_action_group : action_group -> int -> unit
    (* method new_merge_id : ui_id *)
    method remove_action_group : action_group -> unit
    method remove_ui : ui_id -> unit
    method set_add_tearoffs : bool -> unit
    method ui : string
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkUIManager *)
val ui_manager : unit -> ui_manager
