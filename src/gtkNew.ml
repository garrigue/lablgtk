(* $Id$ *)

open Gtk

type t

(* if you modify this type modify widget_info_array 
   in ml_gtk.c in accordance *)
type object_type =
  | OBJECT  | WIDGET  | MISC  | LABEL  | ACCELLABEL  | TIPSQUERY  | ARROW
  | IMAGE   | PIXMAP  | CONTAINER  | BIN  | ALIGNMENT  | FRAME  | ASPECTFRAME
  | BUTTON  | TOGGLEBUTTON  | CHECKBUTTON  | RADIOBUTTON  | OPTIONMENU
  | ITEM  | MENUITEM  | CHECKMENUITEM  | RADIOMENUITEM  | TEAROFFMENUITEM
  | LISTITEM  | TREEITEM  | WINDOW  | COLORSELECTIONDIALOG  | DIALOG
  | INPUTDIALOG  | FILESELECTION  | FONTSELECTIONDIALOG  | PLUG
  | EVENTBOX  | HANDLEBOX  | SCROLLEDWINDOW  | VIEWPORT  | BOX
  | BUTTONBOX  | HBUTTONBOX  | VBUTTONBOX  | VBOX  | COLORSELECTION
  | GAMMACURVE  | HBOX  | COMBO  | STATUSBAR  | CLIST  | CTREE  | FIXED
  | NOTEBOOK  | FONTSELECTION  | PANED  | HPANED  | VPANED  | LAYOUT
  | LIST  | MENUSHELL  | MENUBAR  | MENU  | PACKER  | SOCKET  | TABLE
  | TOOLBAR  | TREE  | CALENDAR  | DRAWINGAREA  | CURVE  | EDITABLE
  | ENTRY  | SPINBUTTON  | TEXT  | RULER  | HRULER  | VRULER  | RANGE
  | SCALE  | HSCALE  | VSCALE  | SCROLLBAR  | HSCROLLBAR  | VSCROLLBAR
  | SEPARATOR  | HSEPARATOR  | VSEPARATOR  | PREVIEW  | PROGRESS
  | PROGRESSBAR  | DATA  | ADJUSTMENT  | TOOLTIPS  | ITEMFACTORY

external set_ml_class_init  : (t -> unit) -> unit = "set_ml_class_init"
external signal_new : string -> int -> t -> object_type -> int  -> int
    = "ml_gtk_signal_new"
external object_class_add_signals : t -> int array -> int -> unit
    = "ml_gtk_object_class_add_signals"
external type_unique : string -> parent:object_type -> nsignals:int -> int
    = "ml_gtk_type_unique"
external type_new : int -> unit obj
    = "ml_gtk_type_new"

open GtkSignal

let make_new_widget name ~parent ~signal_array =
  let nsignals = Array.length signal_array in
  let get_type () =
    let new_type = lazy (type_unique name ~parent ~nsignals) in
    Lazy.force new_type in
  let signal_num_array = Array.create nsignals 0 in
  let class_init_func classe =
    for i = 0 to nsignals-1 do
      signal_num_array.(i) <- signal_new signal_array.(i).name 1 classe parent i
    done;
    object_class_add_signals classe signal_num_array nsignals in
  get_type,
  (fun () ->
    set_ml_class_init class_init_func;
    type_new (get_type ())),
  signal_num_array
