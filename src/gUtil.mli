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

class virtual ml_signals :
  object ('a)
    val after : bool
    method after : 'a
  end

class virtual ml_disconnect :
  object
    method disconnect : GtkSignal.id -> unit
    method private virtual disconnectors : (GtkSignal.id -> bool) list
  end
class virtual add_ml_disconnect :
  object
    method disconnect : GtkSignal.id -> unit
    method private virtual disconnectors : (GtkSignal.id -> bool) list
    method virtual misc : GObj.widget_misc
  end

(* To add ML signals to a LablGTK object:

   class mywidget_signals obj ~mysignal1 ~mysignal2 = object
     inherit somewidget_signals obj
     method mysignal1 = mysignal1#connect ~after
     method mysignal2 = mysignal2#connect ~after
   end

   class mywidget obj = object (self)
     inherit somewidget obj
     inherit add_ml_disconnect
     val mysignal1 = new signal obj
     val mysignal2 = new signal obj
     method private disconnectors =
       [mysignal1#disconnect; mysignal2#disconnect]
     method connect = new mywidget_signals obj ~mysignal1 ~mysignal2
     method call1 = mysignal1#call
     method call2 = mysignal2#call
   end

   You can also add ML signals to an arbitrary object; just inherit
   from ml_signals in place of widget_signals, and replace add_ml_disconnect
   by ml_disconnect.

   class mysignals ~mysignal1 ~mysignal2 = object
     inherit ml_signals
     method mysignal1 = mysignal1#connect ~after
     method mysignal2 = mysignal2#connect ~after
   end
   class myobject = object (self)
     ...
     inherit ml_disconnect
     method private disconnectors = ...
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
  end

class ['a] variable : 'a ->
  object
    val accessed : unit signal
    val changed : 'a signal
    val mutable x : 'a
    method connect : 'a variable_signals
    method disconnect : GtkSignal.id -> unit
    method private disconnectors : (GtkSignal.id -> bool) list
    method get : 'a
    method set : 'a -> unit
  end
