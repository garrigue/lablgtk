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

class dspplay dev = 
  let dsp_fd = open_device dev [O_WRONLY] 0 in
  object
  val dsp = dsp_fd
  val block_size = get_block_size dsp_fd
  val mutable buf = ""
  val mutable length = 0

  method get_block_size = block_size
  method set_sample_size = set_sample_size dsp
  method set_stereo = set_stereo dsp
  method set_speed = set_speed dsp
  method sync = sync dsp
  method close = close dsp
  method write s =
    let slength = String.length s in
    let newbuf = if buf = "" then s else buf ^ s in
    let all = length + slength in
    let remain = ref all in
    let at = ref 0 in
    while !remain >= block_size do
      write dsp newbuf !at block_size;
      remain := !remain - block_size;
      at := !at + block_size
    done;
    buf <- String.sub newbuf (all - !remain) !remain;
    length <- !remain
  method flush =
    write dsp buf 0 length;
    buf <- "";
    length <- 0
end

