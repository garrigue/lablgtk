(* $Id$ *)

(* Interface to Glib functions *)

type unichar = int
type unistring = unichar array

exception GError of string

module Main : sig
  type t
  val create : bool -> t
  val iteration : bool -> bool
  val pending : unit -> bool
  val is_running : t -> bool
  val quit : t -> unit
  val destroy : t -> unit
  type locale_category =
    [ `ALL | `COLLATE | `CTYPE | `MESSAGES | `MONETARY | `NUMERIC | `TIME ]
  val setlocale : locale_category -> string option -> string 
end

module Timeout : sig
  type id
  val add : ms:int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end

module Idle : sig
  type id
  val add : callback:(unit -> bool) -> id
  val remove : id -> unit
end

module Io : sig
  (* Io condition, called from the main loop *)
  type channel
  type condition = [ `ERR | `HUP | `IN | `NVAL | `OUT | `PRI]
  val channel_of_descr : Unix.file_descr -> channel
  val add_watch :
    cond:condition -> callback:(unit -> bool) -> ?prio:int -> channel -> unit
end

module Message : sig
  (* Redirect output *)
  type print_func = string -> unit
  val set_print_handler : (string -> unit) -> print_func

  (* Redirect log, or cause exception *)
  type log_level =
    [ `CRITICAL
    | `DEBUG
    | `ERROR
    | `FLAG_FATAL
    | `FLAG_RECURSION
    | `INFO
    | `MESSAGE
    | `WARNING]
  val log_level : log_level -> int
  type log_handler
  val set_log_handler :
    domain:string ->
    levels:log_level list -> (level:int -> string -> unit) -> unit
  val remove_log_handler : log_handler -> unit
end

module Thread : sig
  val init : unit -> unit (* Call only once! *)
  val enter : unit -> unit
  val leave : unit -> unit
end

module Convert :  sig
  val convert :
    string -> to_codeset:string -> from_codeset:string -> string
  (* All internal strings are encoded in utf8: you should use
     the following conversion functions *)
  val locale_from_utf8 : string -> string
  val locale_to_utf8 : string -> string
  val filename_from_utf8 : string -> string
  val filename_to_utf8 : string -> string
  val get_charset : unit -> bool * string
end

module Utf8 : sig
  (* Utf8 handling, and conversion to ucs4 *)
  (* If you read an utf8 string from somewhere, you should validate it,
     or risk random segmentation faults *)
  val validate : string -> bool
  val length : string -> int
  val to_lower : unichar -> unichar
  val to_upper : unichar -> unichar
  (* [from_unichar 0xiii] converts an index [iii] (usually in hexadecimal form)
     into a string containing the UTF-8 encoded character [0xiii]. See 
     http://www.unicode.org for charmaps.
     Does not check that the given index is a valid unicode index. *)
  val from_unichar : unichar -> string
  val from_unistring : unistring -> string
  val to_unichar : string -> pos:int ref -> unichar
  val to_unistring : string -> unistring
  val first_char : string -> unichar
end
