(* $Id$ *)

type unichar = int
type unistring = unichar array

exception GError of string
external _init : unit -> unit = "ml_glib_init"
let () =  _init () ; Callback.register_exception "gerror" (GError "")

module Main = struct
  type t
  external create : bool -> t = "ml_g_main_new"
  external iteration : bool -> bool = "ml_g_main_iteration"
  external pending : unit -> bool = "ml_g_main_pending"
  external is_running : t -> bool = "ml_g_main_is_running"
  external quit : t -> unit = "ml_g_main_quit"
  external destroy : t -> unit = "ml_g_main_destroy"
  type locale_category =
    [ `ALL | `COLLATE | `CTYPE | `MESSAGES | `MONETARY | `NUMERIC | `TIME ]
  external setlocale : locale_category -> string option -> string 
    = "ml_setlocale"
end

let int_of_priority = function
  | `HIGH -> -100
  | `DEFAULT -> 0
  | `HIGH_IDLE -> 100
  | `DEFAULT_IDLE -> 200
  | `LOW -> 300

module Timeout = struct
  type id
  external add : ?prio:int -> ms:int -> callback:(unit -> bool) -> id
    = "ml_g_timeout_add"
  let add = add ?prio:None
  external remove : id -> unit = "ml_g_source_remove"
end

module Idle = struct
  type id
  external add : ?prio:int -> (unit -> bool) -> id
    = "ml_g_idle_add"
  external remove : id -> unit = "ml_g_source_remove"
end

module Io = struct
  type channel
  type condition = [ `IN | `OUT | `PRI | `ERR | `HUP | `NVAL ]
  type id
  external channel_of_descr : Unix.file_descr -> channel
    = "ml_g_io_channel_unix_new"
  external remove : id -> unit = "ml_g_source_remove"
  external add_watch :
    cond:condition list -> callback:(condition list -> bool) -> ?prio:int -> channel -> id
    = "ml_g_io_add_watch"
  external read : channel -> buf:string -> pos:int -> len:int -> int
    = "ml_g_io_channel_read"
end

module Message = struct
  type log_level =
    [ `ERROR | `CRITICAL | `WARNING | `MESSAGE | `INFO | `DEBUG
    | `FLAG_RECURSION | `FLAG_FATAL ]
  external _log_level : log_level -> int = "ml_Log_level_val"
  let log_level = function
    | `CUSTOM i -> i lsl 8
    | #log_level as level -> _log_level level

  let int_of_log_levels levels =
    List.fold_left (fun acc lev -> acc lor (log_level lev)) 0 levels

  type log_handler
  external _set_log_handler :
    ?domain:string -> levels:int -> (level:int -> string -> unit) -> log_handler
    = "ml_g_log_set_handler"
  let set_log_handler ?domain ~levels f =
    _set_log_handler ?domain ~levels:(int_of_log_levels levels) f

  external remove_log_handler : log_handler -> unit
    = "ml_g_log_remove_handler"

  external _set_always_fatal : int -> unit = "ml_g_log_set_always_fatal"
  let set_always_fatal (levels : log_level list) = 
    _set_always_fatal (int_of_log_levels levels)

  external _set_fatal_mask : ?domain:string -> int -> unit = "ml_g_log_set_fatal_mask"
  let set_fatal_mask ?domain levels =
    _set_fatal_mask ?domain (int_of_log_levels levels)

  external _log : string -> int -> string -> unit = "ml_g_log"
  let log ?(domain="") level fmt =
    Printf.kprintf (_log domain (log_level level)) fmt
end

(*    
module Thread = struct
  external init : unit -> unit = "ml_g_thread_init"
      (* Call only once! *)
  external enter : unit -> unit = "ml_gdk_threads_enter"
  external leave : unit -> unit = "ml_gdk_threads_leave"
end
*)

module Convert = struct
  type error = 
    | NO_CONVERSION
    | ILLEGAL_SEQUENCE
    | FAILED
    | PARTIAL_INPUT
    | BAD_URI
    | NOT_ABSOLUTE_PATH
  exception Error of error * string
  let () = Callback.register_exception "g_convert_error" (Error (NO_CONVERSION, ""))
  external convert :
    string -> to_codeset:string -> from_codeset:string -> string
    = "ml_g_convert"
  external convert_with_fallback :
    ?fallback:string -> to_codeset:string -> from_codeset:string -> string -> string
    = "ml_g_convert_with_fallback"

(* [get_charset ()] returns the pair [u,s] where [u] is true if the
   current charset is UTF-8 encoded and [s] is the charset name. *)
  external get_charset : unit -> bool * string = "ml_g_get_charset"

  external utf8_validate : string -> bool = "ml_g_utf8_validate"

  let raise_bad_utf8 () = 
    raise (Error (ILLEGAL_SEQUENCE, "Invalid byte sequence for UTF-8 string"))

  let locale_from_utf8 s =
    match get_charset () with
    | (true, _) -> 
	if utf8_validate s 
	then s 
	else raise_bad_utf8 ()
    | (false, to_codeset) ->
	convert s ~to_codeset ~from_codeset:"UTF-8"

  let locale_to_utf8 s =
    match get_charset () with
    | (true, _) -> 
	if utf8_validate s 
	then s 
	else raise_bad_utf8 ()
    | (false, from_codeset) ->
	convert s ~to_codeset:"UTF-8" ~from_codeset

  external filename_from_utf8 : string -> string
    = "ml_g_filename_from_utf8"
  external filename_to_utf8 : string -> string
    = "ml_g_filename_to_utf8"
	  
  external filename_from_uri : string -> string option * string
    = "ml_g_filename_from_uri"
  external filename_to_uri : ?hostname:string -> string -> string
    = "ml_g_filename_to_uri"
end

module Unichar = struct
  external to_lower : unichar -> unichar = "ml_g_unichar_tolower"
  external to_upper : unichar -> unichar = "ml_g_unichar_toupper"
  external to_title : unichar -> unichar = "ml_g_unichar_totitle"

  external digit_value : unichar -> int = "ml_g_unichar_digit_value"
  external xdigit_value : unichar -> int = "ml_g_unichar_xdigit_value"

  external validate : unichar -> bool = "ml_g_unichar_validate" "noalloc"
  external isalnum : unichar -> bool = "ml_g_unichar_isalnum"
  external isalpha : unichar -> bool = "ml_g_unichar_isalpha"
  external iscntrl : unichar -> bool = "ml_g_unichar_iscntrl"
  external isdigit : unichar -> bool = "ml_g_unichar_isdigit"
  external isgraph : unichar -> bool = "ml_g_unichar_isgraph"
  external islower : unichar -> bool = "ml_g_unichar_islower"
  external isprint : unichar -> bool = "ml_g_unichar_isprint"
  external ispunct : unichar -> bool = "ml_g_unichar_ispunct"
  external isspace : unichar -> bool = "ml_g_unichar_isspace"
  external isupper : unichar -> bool = "ml_g_unichar_isupper"
  external isxdigit : unichar -> bool = "ml_g_unichar_isxdigit"
  external istitle : unichar -> bool = "ml_g_unichar_istitle"
  external isdefined : unichar -> bool = "ml_g_unichar_isdefined"
  external iswide : unichar -> bool = "ml_g_unichar_iswide"
end

module Utf8 = struct
  external validate : string -> bool = "ml_g_utf8_validate"
  external length : string -> int = "ml_g_utf8_strlen"

  let rec log64 n =
    if n = 0 then 0 else
    1 + log64 (n lsr 5)
  
  let utf8_storage_len n =
    if n < 0x80 then 1 else
    log64 (n lsr 1)

  (* this function is not exported, so it's OK to do a few 'unsafe' things *)
  let write_unichar s ~pos (c : unichar) =
    let len = utf8_storage_len c in
    let p = !pos in
    if len = 1 then
      String.unsafe_set s p (Char.unsafe_chr c)
    else begin
      String.unsafe_set s p (Char.unsafe_chr (((1 lsl len - 1) lsl (8-len)) lor (c lsr ((len-1)*6))));
      for i = 1 to len-1 do
	String.unsafe_set s (p+i) 
	  (Char.unsafe_chr (((c lsr ((len-1-i)*6)) land 0x3f) lor 0x80))
      done ;
    end ;
    pos := p + len

  let from_unichar (n : unichar) =
    let s = String.create 6 and pos = ref 0 in
    write_unichar s ~pos n;
    String.sub s 0 !pos

  let from_unistring (s : unistring) =
    let len = Array.length s in
    let r = String.create (len*6) in
    let pos = ref 0 in
    for i = 0 to len-1 do write_unichar r ~pos s.(i) done;
    String.sub r 0 !pos

  let rec hi_bits n =
    if n land 0x80 = 0 then 0 else
    1 + hi_bits (n lsl 1)

  let to_unichar s ~pos : unichar =
    let c = Char.code s.[!pos] in
    incr pos;
    let n = hi_bits c in
    if n = 0 then c else (* if string is valid then 2 <= n <= 6 *)
    let u = ref (c land (1 lsl (7-n) - 1)) in
    for i = 1 to n-1 do
      let c = Char.code s.[!pos] in
      u := !u lsl 6 + c land 0x3f ;
      incr pos
    done;
    !u

  let to_unichar_validated s ~pos : unichar =
    let c = Char.code s.[!pos] in
    incr pos ;
    let n = hi_bits c in
    if n = 0 then c else begin
      if n = 1 || n > 6 then Convert.raise_bad_utf8 () ;
      if !pos + n > String.length s then
	raise (Convert.Error (Convert.PARTIAL_INPUT, "partial UTF-8 character")) ;
      let u = ref (c land (1 lsl (7-n) - 1)) in
      for i = 1 to n-1 do
	let c = Char.code s.[!pos] in
	if c lsr 6 <> 0b10 then Convert.raise_bad_utf8 () ;
	u := !u lsl 6 + c land 0x3f ;
	incr pos
      done;
      let v = !u in
      (* reject overlong sequences && invalid values *)
      if utf8_storage_len v <> n || not (Unichar.validate v)
      then Convert.raise_bad_utf8 () ;
      v
    end

  let to_unistring s : unistring =
    let len = length s in
    let us = Array.create len 0 in
    let pos = ref 0 in
    for i = 0 to len - 1 do
      us.(i) <- to_unichar s ~pos
    done;
    us

  let first_char s =
    to_unichar s ~pos:(ref 0)

  external offset_to_pos : string -> pos:int -> off:int -> int = "ml_g_utf8_offset_to_pointer" "noalloc"

  external uppercase : string -> string = "ml_g_utf8_strup"
  external lowercase : string -> string = "ml_g_utf8_strdown"

  type normalize_mode = [ `DEFAULT | `DEFAULT_COMPOSE | `ALL | `ALL_COMPOSE ]
  external normalize : string -> normalize_mode -> string = "ml_g_utf8_normalize"

  external casefold : string -> string = "ml_g_utf8_casefold"
  external collate : string -> string -> int = "ml_g_utf8_collate"
  external collate_key : string -> string = "ml_g_utf8_collate_key"
end

module Markup = struct
  type error =
    | BAD_UTF8
    | EMPTY
    | PARSE
    | UNKNOWN_ELEMENT
    | UNKNOWN_ATTRIBUTE
    | INVALID_CONTENT
  exception Error of error * string
  let () = Callback.register_exception "g_markup_error" (Error (BAD_UTF8, ""))
  external escape_text : string -> string = "ml_g_markup_escape_text"
end

external get_prgname : unit -> string = "ml_g_get_prgname"
external set_prgname : string -> unit = "ml_g_set_prgname"
external get_application_name : unit -> string = "ml_g_get_application_name"
external set_application_name : string -> unit = "ml_g_set_application_name"

external get_user_name : unit -> string = "ml_g_get_user_name"
external get_real_name : unit -> string = "ml_g_get_real_name"

external get_home_dir : unit -> string option = "ml_g_get_home_dir"
external get_tmp_dir  : unit -> string = "ml_g_get_tmp_dir"
external find_program_in_path : string -> string = "ml_g_find_program_in_path"
