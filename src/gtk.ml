(* $Id$ *)

exception Error of string
exception Warning of string
type 'a obj
type 'a optobj = 'a obj Misc.optboxed
type clampf = float

module Tags = struct
  type arrow_type = [ UP DOWN LEFT RIGHT ]
  type attach_options = [ EXPAND SHRINK FILL ]
  type direction_type = [ TAB_FORWARD TAB_BACKWARD UP DOWN LEFT RIGHT ]
  type justification = [ LEFT RIGHT CENTER FILL ]
  type match_type = [ ALL ALL_TAIL HEAD TAIL EXACT LAST ]
  type metric_type = [ PIXELS INCHES CENTIMETERS ]
  type orientation = [ HORIZONTAL VERTICAL ]
  type corner_type = [ TOP_LEFT BOTTOM_LEFT TOP_RIGHT BOTTOM_RIGHT ]
  type pack_type = [ START END ]
  type path_type = [ WIDGET WIDGET_CLASS CLASS ]
  type policy_type = [ ALWAYS AUTOMATIC ]
  type position = [ LEFT RIGHT TOP BOTTOM ]
  type preview_type = [ COLOR GRAYSCALE ]
  type relief_type = [ NORMAL HALF NONE ]
  type signal_run_type = [ FIRST LAST BOTH NO_RECURSE ACTION NO_HOOKS ]
  type scroll_type =
      [ NONE STEP_FORWARD STEP_BACKWARD PAGE_BACKWARD PAGE_FORWARD JUMP ]
  type selection_mode = [ SINGLE BROWSE MULTIPLE EXTENDED ]
  type shadow_type = [ NONE IN OUT ETCHED_IN ETCHED_OUT ]
  type state_type = [ NORMAL ACTIVE PRELIGHT SELECTED INSENSITIVE ] 
  type submenu_direction = [ LEFT RIGHT ]
  type submenu_placement = [ TOP_BOTTOM LEFT_RIGHT ]
  type toolbar_style = [ ICONS TEXT BOTH ]
  type trough_type = [ NONE START END JUMP ]
  type update_type = [ CONTINUOUS DISCONTINUOUS DELAYED ]
  type visibility = [ NONE PARTIAL FULL ]
  type window_position = [ NONE CENTER MOUSE ]
  type window_type = [ TOPLEVEL DIALOG POPUP ]
  type sort_type = [ ASCENDING DESCENDING ]
  type fundamental_type =
    [ INVALID NONE CHAR BOOL INT UINT LONG ULONG FLOAT DOUBLE
      STRING ENUM FLAGS BOXED FOREIGN CALLBACK ARGS POINTER
      SIGNAL C_CALLBACK OBJECT ]

  type accel_flag = [ VISIBLE SIGNAL_VISIBLE LOCKED ]
  type button_box_style = [ DEFAULT_STYLE SPREAD EDGE START END ]
  type expand_type = [X Y BOTH NONE]
  type packer_options = [ PACK_EXPAND FILL_X FILL_Y ]
  type side_type = [ TOP BOTTOM LEFT RIGHT ]
  type anchor_type = [ CENTER N NW NE S SW SE W E ]
  type update_policy = [ ALWAYS IF_VALID SNAP_TO_TICKS ]
  type cell_type = [ EMPTY TEXT PIXMAP PIXTEXT WIDGET ]
  type button_action = [ SELECTS DRAGS EXPANDS ]
end
open Tags

type gtk_type
type gtk_class

type accel_group

type style
type group

type statusbar_message
type statusbar_context

type color = { red: float; green: float; blue: float; opacity: float }

type data = [data]
type adjustment = [data adjustment]
type tooltips = [data tooltips]
type widget = [widget]
type container = [widget container]
type alignment = [widget container bin alignment]
type event_box = [widget container bin eventbox]
type frame = [widget container bin frame]
type aspect_frame = [widget container bin frame aspect]
type handle_box = [widget container bin handlebox]
type item = [widget container bin item]
type list_item = [widget container bin item listitem]
type menu_item = [widget container bin item menuitem]
type check_menu_item = [widget container bin item menuitem checkmenuitem]
type radio_menu_item =
    [widget container bin item menuitem checkmenuitem radiomenuitem]
type tree_item = [widget container bin item treeitem]
type viewport = [widget container bin viewport]
type window = [widget container bin window]
type color_selection_dialog = [widget container window colorseldialog]
type dialog = [widget container bin window dialog]
type input_dialog = [widget container bin window dialog inputdialog]
type file_selection = [widget container bin window filesel]
type box = [widget container box]
type button_box = [widget container box bbox]
type gamma_curve = [widget container bbox gamma]
type color_selection = [widget container box colorsel]
type combo = [widget container box combo]
type statusbar = [widget container box statusbar]
type button = [widget container button]
type toggle_button = [widget container button toggle]
type radio_button = [widget container button toggle radio]
type option_menu = [widget container button optionmenu]
type clist = [widget container clist]
type fixed = [widget container fixed]
type liste = [widget container list]
type menu_shell = [widget container menushell]
type menu = [widget container menushell menu]
type menu_bar = [widget container menushell menubar]
type notebook = [widget container notebook]
type packer = [wdiget container packer]
type paned = [widget container paned]
type scrolled_window = [widget container scrolled]
type table = [widget container table]
type toolbar = [widget container toolbar]
type tree = [widget container tree]
type drawing_area = [widget drawing]
type editable = [widget editable]
type entry = [widget editable entry]
type spin_button = [widget editable entry spinbutton]
type text = [widget editable text]
type misc = [widget misc]
type arrow = [widget misc arrow]
type image = [widget misc image]
type label = [widget misc label]
type tips_query = [widget misc label tipsquery]
type pixmap = [widget misc pixmap]
type progress = [widget progress]
type progress_bar = [widget progress progressbar]
type range = [widget range]
type scale = [widget range scale]
type scrollbar = [widget range scrollbar]
type ruler = [widget ruler]
type separator = [widget separator]
