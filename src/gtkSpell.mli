(** GtkSpell interface *)

type error = BACKEND
exception Error of error * string

val attach       : ?lang:string -> #GText.view -> unit
  (** Starts spell checking on the GtkTextView.
      @raise Error . *)
val is_attached  : #GText.view -> bool
val detach       : #GText.view -> unit
val recheck_all  : #GText.view -> unit
val set_language : #GText.view -> string option -> unit
  (** @raise Error . *)
