(* $Id$ *)

class ['a] threaded dispatcher = object (self)
  val dispatcher : 'a -> unit = dispatcher
  val mutex = Mutex.create ()
  method private dispatch msg =
    Mutex.lock mutex;
    dispatcher msg;
    Mutex.unlock mutex
  method send msg =
    Thread.create (self#dispatch) msg;
    ()
end

(*
let proxy obj =
  let dispatcher (msg : [a(int) b c(int * bool)]) =
    match msg with
      `a n -> obj#a n
    | `b -> obj#b ()
    | `c(n,b) -> obj#c n b
  in
  new threaded dispatcher
*)
