open Unix
(* open ThreadUnix *)

type dsp = Unix.file_descr
exception Error of string

external init : unit -> unit 
    = "dsp_init"

let open_device = Unix.openfile

external get_block_size : dsp -> int
    = "dsp_get_block_size"

external set_sample_size : dsp -> int -> unit
    = "dsp_set_sample_size"

external set_stereo : dsp -> bool -> unit
    = "dsp_set_stereo"

external set_speed : dsp -> int -> unit
    = "dsp_set_speed"

external sync : dsp -> unit
    = "dsp_sync"

let close = Unix.close

let _ =
  Callback.register_exception "dsp_error" (Error "");
  init ()

let dspmay f dsp =
  match dsp with
    Some dsp -> f dsp
  | None -> raise (Error "dsp device is not opened")

class dspplay dev = 
  object (self)
  val mutable dsp = None 
  val mutable block_size = 0
  val mutable buf = ""
  val mutable length = 0

  method open_dsp = 
    match dsp with
      Some dsp -> ()
    | None ->
	let d = open_device dev [O_WRONLY] 0 in
	block_size <- get_block_size d;
	dsp <- Some d

  method get_block_size = dspmay (fun _ -> block_size) dsp

  method set_sample_size = dspmay set_sample_size dsp
  method set_stereo = dspmay set_stereo dsp
  method set_speed = dspmay set_speed dsp
  method sync = dspmay sync dsp
  method close = Misc.may (fun d -> close d; dsp <- None) dsp

  method write s =
    let slength = String.length s in
    let newbuf = if buf = "" then s else buf ^ s in
    let all = length + slength in
    let remain = ref all in
    let at = ref 0 in
    self#open_dsp;
    while !remain >= block_size do
      dspmay write dsp newbuf !at block_size;
      remain := !remain - block_size;
      at := !at + block_size
    done;
    buf <- String.sub newbuf (all - !remain) !remain;
    length <- !remain
  method flush =
    Misc.may (fun dsp -> 
      write dsp buf 0 length;
      buf <- "";
      length <- 0) dsp
end

