(* $Id$ *)

open GObj

(* The memo class provides an easy way to remember the real class of
   a widget.
   Insert all widgets of class in one single t memo, and you can then
   recover their original ML object with #find.
*)

class ['a] memo : unit ->
  object
    constraint 'a = #widget
    val tbl : (int, 'a) Hashtbl.t
    method add : 'a -> unit
    method find : widget -> 'a
    method remove : widget -> unit
  end

(* The ML signal mechanism allows one to add GTK-like signals to
   arbitrary objects.
*)

val next_callback_id : unit -> GtkSignal.id

class ['a] signal :
  unit ->
  object
    val mutable callbacks : (GtkSignal.id * ('a -> unit)) list
    method call : 'a -> unit
    method connect : after:bool -> callback:('a -> unit) -> GtkSignal.id
    method disconnect : GtkSignal.id -> bool
  end
class ml_signals :
  object ('a)
    val after : bool
    method after : 'a
    method disconnect : GtkSignal.id -> unit
    method private disconnectors : (GtkSignal.id -> bool) list
  end
class add_ml_signals :
  'a Gtk.obj ->
  object
    method disconnect : GtkSignal.id -> unit
    method private disconnectors : (GtkSignal.id -> bool) list
  end

(* To add ML signals to a LablGTK object:

   class mywidget_signals obj ~mysignal1 ~mysignal2 = object
     inherit somewidget_signals obj
     inherit add_ml_signals obj as super
     method mysignal1 = mysignal1#connect ~after
     method mysignal2 = mysignal2#connect ~after
     method disconnectors =
       [mysignal1#disconnect; mysignal2#disconnect] @ super#disconnectors
   end

   class mywidget obj = object (self)
     inherit somewidget obj
     val mysignal1 = new signal obj
     val mysignal2 = new signal obj
     method connect = new mywidget_signals obj ~mysignal1 ~mysignal2
     method call1 = mysignal1#call
     method call2 = mysignal2#call
   end

   You can also add ML signals to an arbitrary object; just inherit
   from ml_signals in place of widget_signals+add_ml_signals.

   class mysignals ~mysignal1 ~mysignal2 = object
     inherit ml_signals as super
     method mysignal1 = mysignal1#connect ~after
     method mysignal2 = mysignal2#connect ~after
     method disconnectors =
       [mysignal1#disconnect; mysignal2#disconnect] @ super#disconnectors
   end
*)

(* The variable class provides an easy way to propagate state modifications.
   A new variable is created by [new variable init]. [changed] and
   [accessed] are called respectively when [set] and [get] are used.
*)

class ['a] variable_signals :
  changed:'a signal -> accessed:unit signal ->
  object ('b)
    val after : bool
    method after : 'b
    method accessed : callback:(unit -> unit) -> GtkSignal.id
    method changed : callback:('a -> unit) -> GtkSignal.id
    method disconnect : GtkSignal.id -> unit
    method private disconnectors : (GtkSignal.id -> bool) list
  end

class ['a] variable : 'a ->
  object
    val accessed : unit signal
    val changed : 'a signal
    val mutable x : 'a
    method connect : 'a variable_signals
    method get : 'a
    method set : 'a -> unit
  end

