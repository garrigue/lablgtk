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
    try
      Mutex.lock mutex;
      dispatcher msg;
      Mutex.unlock mutex
    with exn ->
      Mutex.unlock mutex; raise exn
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
	let run = ref true in
	while !run do try
	  let msg = input_value ic in
	  self#send msg;
	with End_of_file -> run := false | _ -> () done)
end

class ['a] client oc = object
  inherit ['a] threaded ()
  val oc = oc
  method private dispatch = output_value oc
end
