(* $Id$ *)

open GObj

(* The memo class provides an easy way to remember the real class of
   a widget.
   Insert all widgets of class in one single t memo, and you can then
   recover their original ML object with #find.
*)

class ['a] memo : unit ->
  object
    constraint 'a = #gtkobj
    val tbl : (int, 'a) Hashtbl.t
    method add : 'a -> unit
    method find : #gtkobj -> 'a
    method remove : #gtkobj -> unit
  end

(* To add ML signals to an object:

   class mywidget_signals obj :mysignal1 :mysignal2 ?:after = object
     inherit somewidget_signals obj ?:after
     method mysignal1 = mysignal1#connect ?:after
     method mysignal2 = mysignal2#connect ?:after
   end

   class mywidget obj = object (self)
     inherit somewidget obj
     inherit has_ml_signals obj
     val mysignal1 = new signal
     val mysignal2 = new signal
     method connect = new mywidget_signals ?obj ?:mysignal1 ?:mysignal2
     method call1 = mysignal1#call
     method call2 = mysignal2#call
     initializer
       self#add_signal mysignal1;
       self#add_signal mysignal2
   end

   Remark: you only need to inherit once from has_ml_signals.
   If you want to add new signals do not inherit again.
*)

val next_callback_id : unit -> GtkSignal.id

class ['a] signal :
  object
    method call : 'a -> unit
    method connect : callback:('a -> unit) -> ?after:bool -> GtkSignal.id
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end

class has_ml_signals : 'a Gtk.obj ->
  object
    method private add_signal : 'b signal -> unit
    method disconnect : GtkSignal.id -> unit
  end
