(* $Id$ *)

open Misc

exception Error of string
exception Warning of string

type 'a obj
type clampf = float

type state = [ NORMAL ACTIVE PRELIGHT SELECTED INSENSITIVE ] 
type window_type = [ TOPLEVEL DIALOG POPUP ]
type direction = [ TAB_FORWARD TAB_BACKWARD UP DOWN LEFT RIGHT ]
type shadow_type = [ NONE IN OUT ETCHED_IN ETCHED_OUT ]
type arrow_type = [ UP DOWN LEFT RIGHT ]
type pack_type = [ START END ]
type policy = [ ALWAYS AUTOMATIC ]
type update_type = [ CONTINUOUS DISCONTINUOUS DELAYED ]
type attach_options = [ EXPAND SHRINK FILL ]
type signal_run = [ FIRST LAST BOTH MASK NO_RECURSE ]
type window_position = [ NONE CENTER MOUSE ]
type submenu_direction = [ LEFT RIGHT ]
type submenu_placement = [ TOP_BOTTOM LEFT_RIGHT ]
type menu_factory_type = [ MENU MENU_BAR OPTION_MENU ]
type metric = [ PIXELS INCHES CENTIMETERS ]
type scroll_type =
    [ NONE STEP_FORWARD STEP_BACKWARD PAGE_BACKWARD PAGE_FORWARD JUMP ]
type through_type = [ NONE START END JUMP ]
type position = [ LEFT RIGHT TOP BOTTOM ]
type preview_type = [ COLOR GRAYSCALE ]
type justification = [ LEFT RIGHT CENTER FILL ]
type selection_mode = [ SINGLE BROWSE MULTIPLE EXTENDED ]
type orientation = [ HORIZONTAL VERTICAL ]
type toolbar_style = [ ICONS TEXT BOTH ]
type visibility = [ NONE PARTIAL FULL ]
type fundamental_type =
    [ INVALID NONE CHAR BOOL INT UINT LONG ULONG FLOAT DOUBLE
      STRING ENUM FLAGS BOXED FOREIGN CALLBACK ARGS POINTER
      SIGNAL C_CALLBACK OBJECT ]

type gtktype
type gtkclass

type accelerator_table
type style

type caller = [caller]
type data = [data]
type adjustment = [data adjustment]
type tooltips = [data tooltips]
type widget = [widget]
type container = [widget container]
type alignment = [widget container bin alignment]
type eventbox = [widget container bin eventbox]
type frame = [widget container bin frame]
type aspect_frame = [widget container bin frame aspect]
type handle_box = [widget container bin handlebox]
type item = [widget container bin item]
type list_item = [widget container bin item list]
type menu_item = [widget container bin item menuitem]
type check_menu_item = [widget container bin item menuitem checkmenuitem]
type radio_menu_item =
    [widget container bin item menuitem checkmenuitem radiomenuitem]
type tree_item = [widget container bin item treeitem]
type viewport = [widget container bin viewport]
type window = [widget container bin window]
type file_selection = [widget container bin window filesel]
type box = [widget container box]
type color_selection = [widget container box colorsel]
type color_selection_dialog = [widget container window colorseldialog]
type dialog = [widget container bin window dialog]
type input_dialog = [widget container bin window dialog inputdialog]
type button_box = [widget container box bbox]
type button = [widget container button]
type toggle_button = [widget container button toggle]
type check_button = toggle_button
type radio_button = [widget container button toggle radio]
type clist = [widget container clist]
type fixed = [widget container fixed]
type gtklist = [widget container list]
type menu_shell = [widget container menushell]
type menu = [widget container menushell menu]
type option_menu = [widget container button optionmenu]
type menu_bar = [widget container menushell menubar]
type notebook = [widget container notebook]
type paned = [widget container paned]
type scrolled_window = [widget container scrolled]
type table = [widget container table]
type toolbar = [widget container toolbar]
type tree = [widget container tree]
type drawing_area = [widget drawing] obj
type editable = [widget editable]
type entry = [widget editable entry]
type spin_button = [widget editable entry spinbutton]
type text = [widget editable text]
type combo = [widget container bbox combo]
type statusbar = [widget container bbox statusbar]
type gamma_curve = [widget container bbox gamma]
type misc = [widget misc]
type arrow = [widget misc arrow]
type image = [widget misc image]
type label = [widget misc label]
type tips_query = [widget misc label tipsquery]
type pixmap = [widget misc pixmap]
type progress_bar = [widget progressbar]
type range = [widget range]
type scale = [widget range scale]
type scrollbar = [widget range scrollbar]
type ruler = [widget ruler]
type separator = [widget separator]
