(* $Id$ *)

open Gobject

exception Error of string

type 'a optobj = 'a obj Gpointer.optboxed
type clampf = float

module Tags = struct
  type anchor_type = [ `CENTER|`NORTH|`NW|`NE|`SOUTH|`SW|`SE|`WEST|`EAST ]
  type arrow_type = [ `UP|`DOWN|`LEFT|`RIGHT ]
  type attach_options = [ `EXPAND|`SHRINK|`FILL ]
  type button_box_style = [ `DEFAULT_STYLE|`SPREAD|`EDGE|`START|`END ]
  type curve_type = [ `LINEAR|`SPLINE|`FREE ]
  type delete_type =
    [ `CHARS|`WORD_ENDS|`WORDS|`DISPLAY_LINES|`DISPLAY_LINE_ENDS
    | `PARAGRAPH_ENDS|`PARAGRAPHS|`WHITESPACE ]
  type direction_type = [ `TAB_FORWARD|`TAB_BACKWARD|`UP|`DOWN|`LEFT|`RIGHT ]
  type expander_style =
    [ `COLLAPSED|`SEMI_COLLAPSED|`SEMI_EXPANDED|`EXPANDED ]
  type icon_size =
    [ `INVALID|`MENU|`SMALL_TOOLBAR|`LARGE_TOOLBAR|`BUTTON|`DND|`DIALOG ]
  type side_type = [ `TOP|`BOTTOM|`LEFT|`RIGHT ]
  type text_direction = [ `NONE|`LTR|`RTL ]
  type justification = [ `LEFT|`RIGHT|`CENTER|`FILL ]
  type match_type = [ `ALL|`ALL_TAIL|`HEAD|`TAIL|`EXACT|`LAST ]
  type menu_direction = [ `PARENT|`CHILD|`NEXT|`PREV ]
  type metric_type = [ `PIXELS|`INCHES|`CENTIMETERS ]
  type movement_step =
    [ `LOGICAL_POSITIONS|`VISUAL_POSITIONS|`WORDS|`DISPLAY_LINES
    | `DISPLAY_LINE_ENDS|`PARAGRAPH_ENDS|`PARAGRAPHS|`PAGES|`BUFFER_ENDS ]
  type orientation = [ `HORIZONTAL|`VERTICAL ]
  type corner_type = [ `TOP_LEFT|`BOTTOM_LEFT|`TOP_RIGHT|`BOTTOM_RIGHT ]
  type pack_type = [ `START|`END ]
  type path_priority = [ `LOWEST|`GTK|`APPLICATION|`THEME|`RC|`HIGHEST ]
  type path_type = [ `WIDGET|`WIDGET_CLASS|`CLASS ]
  type policy_type = [ `ALWAYS|`AUTOMATIC|`NEVER ]
  type position = [ `LEFT|`RIGHT|`TOP|`BOTTOM ]
  type preview_type = [ `COLOR|`GRAYSCALE ]
  type relief_style = [ `NORMAL|`HALF|`NONE ]
  type resize_mode = [ `PARENT|`QUEUE|`IMMEDIATE ]
  type signal_run_type = [ `FIRST|`LAST|`BOTH|`NO_RECURSE|`ACTION|`NO_HOOKS ]
  type scroll_type =
    [ `NONE|`JUMP|`STEP_FORWARD|`STEP_BACKWARD|`PAGE_BACKWARD|`PAGE_FORWARD
    | `STEP_UP|`STEP_DOWN|`PAGE_UP|`PAGE_DOWN|`STEP_LEFT|`STEP_RIGHT
    | `PAGE_LEFT|`PAGE_RIGHT|`START|`END ]
  type selection_mode = [ `NONE|`SINGLE|`BROWSE|`MULTIPLE ]
  type shadow_type = [ `NONE|`IN|`OUT|`ETCHED_IN|`ETCHED_OUT ]
  type state_type = [ `NORMAL|`ACTIVE|`PRELIGHT|`SELECTED|`INSENSITIVE ] 
  type submenu_direction = [ `LEFT|`RIGHT ]
  type submenu_placement = [ `TOP_BOTTOM|`LEFT_RIGHT ]
  type toolbar_style = [ `ICONS|`TEXT|`BOTH|`BOTH_HORIZ ]
  type update_type = [ `CONTINUOUS|`DISCONTINUOUS|`DELAYED ]
  type visibility = [ `NONE|`PARTIAL|`FULL ]
  type window_position =
    [ `NONE|`CENTER|`MOUSE|`CENTER_ALWAYS|`CENTER_ON_PARENT ]
  type window_type = [ `TOPLEVEL|`POPUP ]
  type wrap_mode = [ `NONE|`CHAR|`WORD ]
  type sort_type = [ `ASCENDING|`DESCENDING ]

  type accel_flag = [ `VISIBLE|`LOCKED ]
  type expand_type = [ `X|`Y|`BOTH|`NONE ]
  type update_policy = [ `ALWAYS|`IF_VALID|`SNAP_TO_TICKS ]
  type cell_type = [ `EMPTY|`TEXT|`PIXMAP|`PIXTEXT|`WIDGET ]
  type button_action = [ `SELECTS|`DRAGS|`EXPANDS ]
  type calendar_display_options =
    [ `SHOW_HEADING|`SHOW_DAY_NAMES|`NO_MONTH_CHANGE|`SHOW_WEEK_NUMBERS
     |`WEEK_START_MONDAY ]
  type spin_button_update_policy = [ `ALWAYS|`IF_VALID ]
  type spin_type =
    [ `STEP_FORWARD|`STEP_BACKWARD|`PAGE_FORWARD|`PAGE_BACKWARD
     |`HOME|`END|`USER_DEFINED of float ]
  type progress_bar_style = [ `CONTINUOUS|`DISCRETE ]
  type progress_bar_orientation =
    [ `LEFT_TO_RIGHT|`RIGHT_TO_LEFT|`BOTTOM_TO_TOP|`TOP_TO_BOTTOM ]
  type dest_defaults = [ `MOTION|`HIGHLIGHT|`DROP|`ALL ]
  type target_flags = [ `SAME_APP|`SAME_WIDGET ]
  type text_window_type = [ `PRIVATE | `WIDGET | `TEXT | `LEFT
			  | `RIGHT | `TOP | `BOTTOM]
end
open Tags

type gtk_class

type accel_group
type clipboard

type style
type 'a group = 'a obj option

type statusbar_message
type statusbar_context
type selection_data

type color = { red: float; green: float; blue: float; opacity: float }
type rectangle  = { x: int; y: int; width: int; height: int }
type target_entry = { target: string; flags: target_flags list; info: int }

type adjustment = [`gtk|`adjustment]
type tooltips = [`gtk|`tooltips]
type widget = [`gtk|`widget]
type container = [widget|`container]
type bin = [container|`bin]
type alignment = [bin|`alignment]
type event_box = [bin|`eventbox]
type frame = [bin|`frame]
type aspect_frame = [bin|`frame|`aspect]
type handle_box = [bin|`handlebox]
type invisible = [bin|`invisible]
type item = [bin|`item]
type list_item = [item|`listitem]
type menu_item = [item|`menuitem]
type check_menu_item = [item|`menuitem|`checkmenuitem]
type radio_menu_item = [item|`menuitem|`checkmenuitem|`radiomenuitem]
type tree_item = [item|`treeitem]
type viewport = [bin|`viewport]
type window = [bin|`window]
type color_selection_dialog = [window|`colorseldialog]
type dialog = [window|`dialog]
type input_dialog = [window|`dialog|`inputdialog]
type file_selection = [window|`filesel]
type font_selection_dialog = [window|`fontseldialog]
type plug = [window|`plug]
type box = [container|`box]
type button_box = [container|`box|`bbox]
type gamma_curve = [container|`bbox|`gamma]
type color_selection = [container|`box|`colorsel]
type combo = [container|`box|`combo]
type statusbar = [container|`box|`statusbar]
type button = [container|`button]
type toggle_button = [button|`toggle]
type radio_button = [button|`toggle|`radio]
type option_menu = [button|`optionmenu]
type clist = [container|`clist]
type fixed = [container|`fixed]
type layout = [container|`layout]
type liste = [container|`list]
type menu_shell = [container|`menushell]
type menu = [container|`menushell|`menu]
type menu_bar = [container|`menushell|`menubar]
type notebook = [container|`notebook]
type font_selection = [container|`notebook|`fontsel]
type packer = [container|`packer]
type paned = [container|`paned]
type scrolled_window = [container|`scrolled]
type socket = [container|`socket]
type table = [container|`table]
type toolbar = [container|`toolbar]
type tree = [container|`tree]
type calendar = [widget|`calendar]
type drawing_area = [widget|`drawing]
type editable = [widget|`editable]
type entry = [editable|`entry]
type spin_button = [editable|`entry|`spinbutton]
type text = [editable|`text]
type misc = [widget|`misc]
type arrow = [misc|`arrow]
type image = [misc|`image]
type label = [misc|`label]
type tips_query = [misc|`label|`tipsquery]
type pixmap = [misc|`pixmap]
type progress = [widget|`progress]
type progress_bar = [widget|`progress|`progressbar]
type range = [widget|`range]
type scale = [widget|`range|`scale]
type scrollbar = [widget|`range|`scrollbar]
type ruler = [widget|`ruler]
type separator = [widget|`separator]
type preview = [widget|`preview]

type textview = [container|`textview]
type textbuffer = [`textbuffer]
type texttagtable = [`texttagtable]
type texttag = [`texttag]
type textmark = [`textmark ]
type textchildanchor = [`textchildanchor ]
type textiter

(* re-export Gobject.obj *)
type 'a obj = 'a Gobject.obj
