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

(* To add ML signals to an object:

   class mywidget_signals obj :mysignal1 :mysignal2 = object
     inherit somewidget_signals obj
     inherit has_ml_signals obj
     method mysignal1 = mysignal1#connect :after
     method mysignal2 = mysignal2#connect :after
   end

   class mywidget obj = object (self)
     inherit somewidget obj
     val mysignal1 = new signal obj
     val mysignal2 = new signal obj
     method connect = new mywidget_signals ?obj ?:mysignal1 ?:mysignal2
     method call1 = mysignal1#call
     method call2 = mysignal2#call
   end

   Remark: you only need to inherit once from has_ml_signals.
   If you want to add new signals do not inherit again.
*)

val next_callback_id : unit -> GtkSignal.id

class ['a] signal : 'b Gtk.obj ->
  object
    method call : 'a -> unit
    method connect : callback:('a -> unit) -> after:bool -> GtkSignal.id
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end

class has_ml_signals : 'a Gtk.obj ->
  object
    method disconnect : GtkSignal.id -> unit
  end
