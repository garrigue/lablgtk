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
    List.exists callbacks ~f:
      begin fun (_,f) ->
        let old = GtkSignal.push_callback () in
        try f arg; GtkSignal.pop_callback old
        with exn -> GtkSignal.pop_callback old; raise exn
      end;
    ()
  method disconnect key =
    List.mem_assoc key callbacks &&
    (callbacks <- List.remove_assoc key callbacks; true)
end

class virtual ml_signals disconnectors =
  object (self)
    val after = false
    method after = {< after = true >}
    val mutable disconnectors : (GtkSignal.id -> bool) list = disconnectors
    method disconnect key =
      ignore (List.exists disconnectors ~f:(fun f -> f key))
  end

class virtual add_ml_signals obj disconnectors =
  object (self)
    val mutable disconnectors : (GtkSignal.id -> bool) list = disconnectors
    method disconnect key =
      if List.exists disconnectors ~f:(fun f -> f key) then ()
      else GtkSignal.disconnect obj key
  end

class ['a] variable_signals ~(changed : 'a signal)~(accessed : unit signal) =
  object
    inherit ml_signals [changed#disconnect; accessed#disconnect]
    method changed = changed#connect ~after
    method accessed = accessed#connect ~after
  end

class ['a] variable x =
  object (self)
    val changed = new signal ()
    val accessed = new signal ()
    method connect = new variable_signals ~changed ~accessed
    val mutable x : 'a = x
    method set y = x <- y; changed#call y
    method get = accessed#call (); x
  end
