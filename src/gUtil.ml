(* $Id$ *)

open GObj

class ['a] memo () = object
  constraint 'a = #widget
  val tbl = Hashtbl.create 7
  method add (obj : 'a) =
    Hashtbl.add tbl ~key:obj#get_id ~data:obj
  method find (obj : widget) = Hashtbl.find tbl obj#get_id
  method remove (obj : widget) = Hashtbl.remove tbl obj#get_id
end

let signal_id = ref 0

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class ['a] signal () = object (self)
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  method connect ~after ~callback =
    let id = next_callback_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks ~f:(fun (_,f) -> f arg)
  method disconnect key =
    List.mem_assoc key callbacks &&
    (callbacks <- List.remove_assoc key callbacks; true)
end

class virtual ml_signals =
  object (self)
    val after = false
    method after = {< after = true >}
  end

class virtual ml_disconnect =
  object (self)
    method private virtual  disconnectors : (GtkSignal.id -> bool) list
    method disconnect key =
      ignore (List.exists self#disconnectors ~f:(fun f -> f key))
  end

class virtual add_ml_disconnect =
  object (self)
    method private virtual disconnectors : (GtkSignal.id -> bool) list
    method virtual misc : widget_misc
    method disconnect key =
      if List.exists self#disconnectors ~f:(fun f -> f key) then ()
      else self#misc#disconnect key
  end

class ['a] variable_signals ~(changed : 'a signal)~(accessed : unit signal) =
  object
    inherit ml_signals
    method changed = changed#connect ~after
    method accessed = accessed#connect ~after
  end

class ['a] variable x =
  object (self)
    val changed = new signal ()
    val accessed = new signal ()
    inherit ml_disconnect
    method private disconnectors = [changed#disconnect; accessed#disconnect]
    method connect = new variable_signals ~changed ~accessed
    val mutable x : 'a = x
    method set y = x <- y; changed#call y
    method get = accessed#call (); x
  end
