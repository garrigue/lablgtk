(* $Id$ *)

(** Useful functions for LablGTK. *)

(** {2 Menus} *)

(** Tree description of a menu *)
type menu_entry =
  [ `I of string * (unit -> unit)
  | `C of string * bool * (bool -> unit)
  | `R of (string * bool * (bool -> unit)) list
  | `M of string * menu_entry list
  | `S ]

(** Build a menu from a tree description *)
val build_menu : GMenu.menu -> entries: menu_entry list -> unit

(** Popup a menu created from the given list of 
   labels and functions. *)
val popup_menu : entries: menu_entry list -> x: int -> y: int -> unit

(** {2 Parametrized dialog windows} *)

(**This function is used to display a question in a dialog box,
   with a parametrized list of buttons. The function returns the number
   of the clicked button (starting at 1), or 0 if the window is 
   savagedly destroyed.
   @param icon a widget (usually a pixmap) which can be displayed on the left
     of the window.
   @param buttons the list of button labels.
*)
val question_box :
    title:string ->
    buttons:string list ->
    ?default:int -> ?icon:#GObj.widget -> string -> int

(**This function is used to display a message in a dialog box with just an Ok button.
   We use [question_box] with just an ok button.
   @param icon a widget (usually a pixmap) which can be displayed on the left
     of the window.
   @param cancel the text for the cancel button (default is "Cancel")
*)
val message_box :
    title:string -> ?icon:#GObj.widget -> ?ok:string -> string -> unit

(** Make the user type in a string. 
   @return [None] if the user clicked on cancel, or [Some s] if the user
   clicked on the ok button.
   @param ok the text for the confirmation button (default is "Ok")
   @param cancel the text for the cancel button (default is "Cancel")
   @param text the default text displayed in the entry widget
*)
val input_string :
    title:string ->
    ?ok:string -> ?cancel:string -> ?text:string -> string -> string option

(** Make the user type in a text.
   @return [None] if the user clicked on cancel, or [Some s] if the user
   clicked on the ok button.
   @param ok the text for the confirmation button (default is "Ok")
   @param cancel the text for the cancel button (default is "Cancel")
   @param text the default text displayed in the entry widget
*)
 val input_text :
    title:string ->
    ?ok:string -> ?cancel:string -> ?text:string -> string -> string option

(**This function allows the user to select a file and returns the
   selected file name.
   A VOIR : multi-selection ?
*)
val select_file :
    title:string -> ?dir:string ref -> ?filename:string -> unit -> string

(** A tree. *)
type 'a tree = {
    t_data : 'a ;
    t_children : 'a tree list
  } 

(** A function to make the user select a node in a tree.
   @param ok the text for the confirmation button (default is "Ok")
   @param cancel the text for the cancel button (default is "Cancel")
   @param tree is the tree to display.
   @param label gives a label from the data of a node.
   @param info gives a string from the data of a node,
          to give more information to the user when he selects
          a node.
   @param title is the title of the window.
   @return The data associated to the selected node, or None
   if the user canceled the selection.
*)
val tree_selection :
    title:string ->
    label:('a -> string) ->
    info:('a -> string) ->
    ?ok:string -> ?cancel:string -> 'a tree -> 'a option

(** {2 Miscellaneous functions} *)

(** Resize the columns of a clist according to the length of the 
   content and the title of each column.*)
val autosize_clist : 'a GList.clist -> unit
