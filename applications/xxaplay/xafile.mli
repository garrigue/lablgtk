type primary_volume_descriptor =
  { system_id: string;
    volume_id: string;
    application_id: string;
    root_directory_record: string }

type directory_record =
  { extent: int;
    size: int;
    directory: bool;
    name: string }

val read_raw_frame : Unix.file_descr -> int -> string
val read_iso9660_sector : Unix.file_descr -> int -> string

val parse_directory_record : string -> directory_record * string

val parse_directory_record_list : string -> directory_record list

val read_primary_volume_descriptor :
  Unix.file_descr -> primary_volume_descriptor

val locate_file : Unix.file_descr -> string -> directory_record

val dir : Unix.file_descr -> directory_record -> directory_record list

type info = { tracks: (int * int) list; interleave: int }

val track_info : string -> int

val info_file : Unix.file_descr -> directory_record -> info

val guess_interleave : Unix.file_descr -> int -> int

val is_xa_file : Unix.file_descr -> int -> bool
val list_xa_files_of_disk : Unix.file_descr -> directory_record list

type track = {
    tstart : int;
    mutable tinterleave : int;
    mutable tlength : int;
  } 

val get_tracks : 
    Unix.file_descr -> (int -> int -> unit) -> directory_record -> track list

val get_tracks_from_path : 
    Unix.file_descr -> (int -> int -> unit) -> string -> track list

