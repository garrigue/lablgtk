(* $Id$ *)

(** Interface to Glib functions 
    @gtkdoc glib index *)

type unichar = int
type unistring = unichar array

exception GError of string
exception Critical of string * string

(** {3 Main Event Loop} *)

(** The Main Event Loop 
    @gtkdoc glib glib-The-Main-Event-Loop *)
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

(** @gtkdoc glib glib-The-Main-Event-Loop *)
module Timeout : sig
  type id
  val add : ms:int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end

(** @gtkdoc glib glib-The-Main-Event-Loop *)
module Idle : sig
  type id
  val add : callback:(unit -> bool) -> id
  val remove : id -> unit
end

(** IO Channels
   @gtkdoc glib glib-IO-Channels *)
module Io : sig
  (** Io condition, called from the main loop *)

  type channel
  type condition = [ `ERR | `HUP | `IN | `NVAL | `OUT | `PRI]
  type id
  val channel_of_descr : Unix.file_descr -> channel
  val add_watch :
    cond:condition -> callback:(unit -> bool) -> ?prio:int -> channel -> id
  val remove : id -> unit
  val read : channel -> buf:string -> pos:int -> len:int -> int
end

(** {3 Message Logging} *)

(** @gtkdoc glib glib-Message-Logging *)
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
    levels:log_level list -> (level:int -> string -> unit) -> log_handler
  val remove_log_handler : log_handler -> unit
  val handle_criticals : domain:string -> unit
end

(*
module Thread : sig
  val init : unit -> unit (* Call only once! *)
  val enter : unit -> unit
  val leave : unit -> unit
end
*)

(** {3 Character Sets} *)

(** Character Set Conversion 
   @gtkdoc glib glib-Character-Set-Conversion *)
module Convert :  sig
  type error = 
    | NO_CONVERSION (** Conversion between the requested character sets is not supported *)
    | ILLEGAL_SEQUENCE (** Invalid byte sequence in conversion input *)
    | FAILED (** Conversion failed for some reason *)
    | PARTIAL_INPUT (** Partial character sequence at end of input *)
    | BAD_URI (** URI is invalid *)
    | NOT_ABSOLUTE_PATH (** Pathname is not an absolute path *)
  exception Error of error * string

  val convert :
    string -> to_codeset:string -> from_codeset:string -> string (** @raise Error . *)
  val convert_with_fallback :
    ?fallback:string -> to_codeset:string -> from_codeset:string -> string -> string (** @raise Error . *)

  (** All internal strings are encoded in utf8: you should use
     the following conversion functions *)

  val locale_from_utf8 : string -> string (** @raise Error . *)
  val locale_to_utf8 : string -> string (** @raise Error . *)
  val filename_from_utf8 : string -> string (** @raise Error . *)
  val filename_to_utf8 : string -> string (** @raise Error . *)
  val get_charset : unit -> bool * string (** @raise Error . *)
end

(** Unicode Manipulation
   @gtkdoc glib glib-Unicode-Manipulation *)
module Unichar : sig 
  val to_lower : unichar -> unichar
  val to_upper : unichar -> unichar
  val to_title : unichar -> unichar

  val digit_value : unichar -> int
  val xdigit_value : unichar -> int
  val validate : unichar -> bool
  val isalnum : unichar -> bool
  val isalpha : unichar -> bool
  val iscntrl : unichar -> bool
  val isdigit : unichar -> bool
  val isgraph : unichar -> bool
  val islower : unichar -> bool
  val isprint : unichar -> bool
  val ispunct : unichar -> bool
  val isspace : unichar -> bool
  val isupper : unichar -> bool
  val isxdigit : unichar -> bool
  val istitle : unichar -> bool
  val isdefined : unichar -> bool
  val iswide : unichar -> bool
end

(** Unicode Manipulation
   @gtkdoc glib glib-Unicode-Manipulation *)
module Utf8 : sig
  (** Utf8 handling, and conversion to ucs4 *)

  (** If you read an utf8 string from somewhere, you should validate it,
     or risk random segmentation faults *)
  val validate : string -> bool
  val length : string -> int

  (** [from_unichar 0xiii] converts an index [iii] (usually in hexadecimal form)
     into a string containing the UTF-8 encoded character [0xiii]. See 
     {{:http://www.unicode.org/}unicode.org} for charmaps.
     Does not check that the given index is a valid unicode index. *)
  val from_unichar : unichar -> string
  val from_unistring : unistring -> string
  val to_unichar : string -> pos:int ref -> unichar
  val to_unistring : string -> unistring
  val first_char : string -> unichar
end

(** @gtkdoc glib glib-Simple-XML-Subset-Parser *)
module Markup : sig
  type error =
    | BAD_UTF8
    | EMPTY
    | PARSE
    | UNKNOWN_ELEMENT
    | UNKNOWN_ATTRIBUTE
    | INVALID_CONTENT
  exception Error of error * string

  val escape_text : string -> string
end

(** {3 Miscellaneous Utility Functions} *)

external get_prgname : unit -> string = "ml_g_get_prgname"
external set_prgname : string -> unit = "ml_g_set_prgname"
external get_application_name : unit -> string = "ml_g_get_application_name" (** @since GTK 2.2 *)
external set_application_name : string -> unit = "ml_g_set_application_name"

external get_user_name : unit -> string = "ml_g_get_user_name"
external get_real_name : unit -> string = "ml_g_get_real_name"

external get_home_dir : unit -> string option = "ml_g_get_home_dir"
external get_tmp_dir  : unit -> string = "ml_g_get_tmp_dir"

external find_program_in_path : string -> string = "ml_g_find_program_in_path" (** @raise Not_found if the program is not found in the path or is not executable *)
