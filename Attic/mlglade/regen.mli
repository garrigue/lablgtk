
(*s Generation of generated/edited files. *)

(*s The function provided by the user has type
    [regeneration_function].  It takes the list of already edited
    parts of the file and the filename and generates the new
    file. Edited parts of the file are supposed to be enclosed between
    \verb!BEGIN! and \verb!END! comments. The function [output_block]
    can be used to re-output an edited block in the suitable
    format (the first argument is the block name and the second its 
    contents). *)

type regeneration_function = (string * string) list -> out_channel -> unit

val output_block : string -> string -> out_channel -> unit

(*s Given a regeneration function, the function [generate] returns a
    generation function. This function takes a filename as argument and
    fills it. The file is created if it does not exist. If it exists,
    a backup is made with suffix \verb!.bak! and its edited parts are 
    scanned to be given to the regeneration function. *)

type generation_function = string -> unit

val generate : regeneration_function -> generation_function
