type gtk_stock_id = [ `DIALOG_INFO | `DIALOG_WARNING
  | `DIALOG_ERROR | `DIALOG_QUESTION | `DND | `DND_MULTIPLE
  | `ADD | `APPLY | `BOLD | `CANCEL | `CDROM | `CLEAR 
  | `CLOSE | `COLOR_PICKER | `CONVERT | `COPY | `CUT 
  | `DELETE | `EXECUTE | `FIND | `FIND_AND_REPLACE 
  | `FLOPPY | `GOTO_BOTTOM | `GOTO_FIRST | `GOTO_LAST 
  | `GOTO_TOP | `GO_BACK | `GO_DOWN | `GO_FORWARD
  | `GO_UP | `HELP | `HOME | `INDEX | `ITALIC
  | `JUMP_TO | `JUSTIFY_CENTER | `JUSTIFY_FILL
  | `JUSTIFY_LEFT | `JUSTIFY_RIGHT | `MISSING_IMAGE
  | `NEW | `NO | `OK | `OPEN | `PASTE | `PREFERENCES
  | `PRINT | `PRINT_PREVIEW | `PROPERTIES | `QUIT
  | `REDO | `REFRESH | `REMOVE | `REVERT_TO_SAVED
  | `SAVE | `SAVE_AS | `SELECT_COLOR | `SELECT_FONT
  | `SORT_ASCENDING | `SORT_DESCENDING | `SPELL_CHECK
  | `STOP | `STRIKETHROUGH | `UNDELETE | `UNDERLINE | `UNDO
  | `YES | `ZOOM_100 | `ZOOM_FIT | `ZOOM_IN  | `ZOOM_OUT]

type id = [gtk_stock_id | `STOCK of string]

(* awk '/^#define GTK_STOCK_/ { sub(/GTK_STOCK_/, "", $2) ; print "| `" $2, "->", $3 }' ~/garnome/include/gtk-2.0/gtk/gtkstock.h *)
let convert_id : id -> string = function
  | `STOCK s -> s
  | `DIALOG_INFO -> "gtk-dialog-info"
  | `DIALOG_WARNING -> "gtk-dialog-warning"
  | `DIALOG_ERROR -> "gtk-dialog-error"
  | `DIALOG_QUESTION -> "gtk-dialog-question"
  | `DND -> "gtk-dnd"
  | `DND_MULTIPLE -> "gtk-dnd-multiple"
  | `ADD -> "gtk-add"
  | `APPLY -> "gtk-apply"
  | `BOLD -> "gtk-bold"
  | `CANCEL -> "gtk-cancel"
  | `CDROM -> "gtk-cdrom"
  | `CLEAR -> "gtk-clear"
  | `CLOSE -> "gtk-close"
  | `COLOR_PICKER -> "gtk-color-picker"
  | `CONVERT -> "gtk-convert"
  | `COPY -> "gtk-copy"
  | `CUT -> "gtk-cut"
  | `DELETE -> "gtk-delete"
  | `EXECUTE -> "gtk-execute"
  | `FIND -> "gtk-find"
  | `FIND_AND_REPLACE -> "gtk-find-and-replace"
  | `FLOPPY -> "gtk-floppy"
  | `GOTO_BOTTOM -> "gtk-goto-bottom"
  | `GOTO_FIRST -> "gtk-goto-first"
  | `GOTO_LAST -> "gtk-goto-last"
  | `GOTO_TOP -> "gtk-goto-top"
  | `GO_BACK -> "gtk-go-back"
  | `GO_DOWN -> "gtk-go-down"
  | `GO_FORWARD -> "gtk-go-forward"
  | `GO_UP -> "gtk-go-up"
  | `HELP -> "gtk-help"
  | `HOME -> "gtk-home"
  | `INDEX -> "gtk-index"
  | `ITALIC -> "gtk-italic"
  | `JUMP_TO -> "gtk-jump-to"
  | `JUSTIFY_CENTER -> "gtk-justify-center"
  | `JUSTIFY_FILL -> "gtk-justify-fill"
  | `JUSTIFY_LEFT -> "gtk-justify-left"
  | `JUSTIFY_RIGHT -> "gtk-justify-right"
  | `MISSING_IMAGE -> "gtk-missing-image"
  | `NEW -> "gtk-new"
  | `NO -> "gtk-no"
  | `OK -> "gtk-ok"
  | `OPEN -> "gtk-open"
  | `PASTE -> "gtk-paste"
  | `PREFERENCES -> "gtk-preferences"
  | `PRINT -> "gtk-print"
  | `PRINT_PREVIEW -> "gtk-print-preview"
  | `PROPERTIES -> "gtk-properties"
  | `QUIT -> "gtk-quit"
  | `REDO -> "gtk-redo"
  | `REFRESH -> "gtk-refresh"
  | `REMOVE -> "gtk-remove"
  | `REVERT_TO_SAVED -> "gtk-revert-to-saved"
  | `SAVE -> "gtk-save"
  | `SAVE_AS -> "gtk-save-as"
  | `SELECT_COLOR -> "gtk-select-color"
  | `SELECT_FONT -> "gtk-select-font"
  | `SORT_ASCENDING -> "gtk-sort-ascending"
  | `SORT_DESCENDING -> "gtk-sort-descending"
  | `SPELL_CHECK -> "gtk-spell-check"
  | `STOP -> "gtk-stop"
  | `STRIKETHROUGH -> "gtk-strikethrough"
  | `UNDELETE -> "gtk-undelete"
  | `UNDERLINE -> "gtk-underline"
  | `UNDO -> "gtk-undo"
  | `YES -> "gtk-yes"
  | `ZOOM_100 -> "gtk-zoom-100"
  | `ZOOM_FIT -> "gtk-zoom-fit"
  | `ZOOM_IN -> "gtk-zoom-in"
  | `ZOOM_OUT -> "gtk-zoom-out"


type icon_source
module Icon_source = struct
external new_icon_source : unit -> icon_source = "ml_gtk_icon_source_new"
external set_filename : icon_source -> string -> unit = "ml_gtk_icon_source_set_filename"
external set_pixbuf : icon_source -> GdkPixbuf.pixbuf -> unit = "ml_gtk_icon_source_set_pixbuf"
external set_direction_wildcarded : icon_source -> bool -> unit = "ml_gtk_icon_source_set_direction_wildcarded"
external set_state_wildcarded : icon_source -> bool -> unit = "ml_gtk_icon_source_set_state_wildcarded"
external set_size_wildcarded : icon_source -> bool -> unit = "ml_gtk_icon_source_set_size_wildcarded"
external set_direction : icon_source -> Gtk.Tags.text_direction -> unit = "ml_gtk_icon_source_set_direction"
external set_state : icon_source -> Gtk.Tags.state_type -> unit = "ml_gtk_icon_source_set_state"
external set_size : icon_source -> Gtk.Tags.icon_size -> unit = "ml_gtk_icon_source_set_size"
end

type icon_set
module Icon_set = struct
external new_icon_set : unit -> icon_set = "ml_gtk_icon_set_new"
external new_from_pixbuf : GdkPixbuf.pixbuf -> icon_set = "ml_gtk_icon_set_new_from_pixbuf"
external add_source : icon_set -> icon_source -> unit = "ml_gtk_icon_set_add_source"
external get_sizes : icon_set -> Gtk.Tags.icon_size list = "ml_gtk_icon_set_get_sizes"
end

type icon_factory = [`iconfactory] Gobject.obj
module Icon_factory = struct
external new_factory : unit -> icon_factory = "ml_gtk_icon_factory_new"
external add : icon_factory -> string -> icon_set -> unit = "ml_gtk_icon_factory_add"
external lookup : icon_factory -> string -> icon_set = "ml_gtk_icon_factory_lookup"
external add_default : icon_factory -> unit = "ml_gtk_icon_factory_add_default"
external remove_default : icon_factory -> unit = "ml_gtk_icon_factory_remove_default"
external lookup_default : string -> icon_set = "ml_gtk_icon_factory_lookup_default"
end

let make_icon_source ?filename ?pixbuf ?direction ?state ?size () =
  let s = Icon_source.new_icon_source () in
  Gaux.may (Icon_source.set_filename s) filename ;
  Gaux.may (Icon_source.set_pixbuf s) pixbuf ;
  Gaux.may (fun p -> Icon_source.set_direction_wildcarded s false ; 
    Icon_source.set_direction s p) direction ;
  Gaux.may (fun p -> Icon_source.set_state_wildcarded s false ; 
    Icon_source.set_state s p) state ;
  Gaux.may (fun p -> Icon_source.set_size_wildcarded s false ; 
    Icon_source.set_size s p) size ;
  s

let make_icon_set sources = 
  let s = Icon_set.new_icon_set () in
  List.iter (Icon_set.add_source s) sources ;
  s

let make_icon_factory ?(default = true) ?icons () =
  let f = Icon_factory.new_factory () in
  Gaux.may icons 
    ~f:(List.iter (fun (n, i) -> Icon_factory.add f (convert_id n) i)) ;
  if default then Icon_factory.add_default f ;
  f

type item = {
    stock_id : string ;
    label    : string ;
    modifier : Gdk.Tags.modifier list ;
    keyval   : Gdk.keysym ;
  }
module Item = struct
external add : item -> unit = "ml_gtk_stock_add"
external list_ids : unit -> string list = "ml_gtk_stock_list_ids"
external lookup : string -> item = "ml_gtk_stock_lookup"
let lookup id = lookup (convert_id id)
end
