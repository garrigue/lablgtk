(* $Id$ *)

class virtual ['a] threaded () = object (self)
  val mutex = Mutex.create ()
  method private virtual dispatch : 'a -> unit
  method send msg =
    Thread.create
      (fun msg ->
	try
	  Mutex.lock mutex;
	  self#dispatch msg;
	  Mutex.unlock mutex
	with exn ->
	  Mutex.unlock mutex; raise exn)
      msg;
    ()
end

let threader dispatcher =
  let mutex = Mutex.create () in
  let dispatch msg =
    Mutex.lock mutex;
    dispatcher msg;
    Mutex.unlock mutex
  in
  fun msg -> Thread.create dispatch msg; ()

(*
class thsafe_obj () = object (self)
  inherit ['a] threaded ()
  val super = new unsafe_obj ()
  method private dispatch = 
    function
	`a -> super#a
      | ...
  method a = call `a
      ....
end
*)

class virtual ['a] server () = object (self)
  inherit ['a] threaded ()
  method bind =
    Thread.create
      (fun ic ->
	let msg = input_value ic in
	self#send msg)
end

