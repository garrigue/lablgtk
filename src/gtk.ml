(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gobject

exception Error of string

type 'a optobj = 'a obj Gpointer.optboxed
type clampf = float

module Tags = struct
  type expand_type = [ `X|`Y|`BOTH|`NONE ]
  include (GtkEnums : module type of GtkEnums
                      with module Conv := GtkEnums.Conv)
  type position = position_type
end
open Tags

type gtk_class

type accel_group
type clipboard

type style = [`style] obj
type css_provider = [`css_provider] obj
type style_context = [`style_context] obj
type 'a group = 'a obj option

type statusbar_message
type statusbar_context
type selection_data

type rectangle  = { x: int; y: int; width: int; height: int }
type target_entry = { target: string; flags: target_flags list; info: int }
type box_packing =
    { expand: bool; fill: bool; padding: int; pack_type: pack_type }

type orientable = [`giu|`orientable]
type adjustment = [`giu|`adjustment]
type tooltips = [`giu|`tooltips]
type widget = [`giu|`widget]
type container = [widget|`container]
type container' = container obj
type bin = [container|`bin]
type alignment = [bin|`alignment]
type button = [bin|`button]
type toggle_button = [button|`togglebutton]
type radio_button = [button|`togglebutton|`radiobutton]
type color_button = [button|`colorbutton]
type font_button = [button|`fontbutton]
type link_button = [button|`linkbutton]
type scale_button = [button|`scalebutton]
type option_menu = [button|`optionmenu]
type event_box = [bin|`eventbox]
type frame = [bin|`frame]
type aspect_frame = [bin|`frame|`aspectframe]
type handle_box = [bin|`handlebox]
type invisible = [bin|`invisible]
type item = [bin|`item]
type list_item = [item|`listitem]
type menu_item = [item|`menuitem]
type image_menu_item = [menu_item| `imagemenuitem]
type check_menu_item = [item|`menuitem|`checkmenuitem]
type radio_menu_item = [item|`menuitem|`checkmenuitem|`radiomenuitem]
type tree_item = [item|`treeitem]
type builder = [`giu|`builder]
type scrolled_window = [bin|`scrolledwindow]
type viewport = [bin|`viewport]
type window = [bin|`window]
type assistant = [window|`assistant]
type dialog = [window|`dialog]
type message_dialog = [dialog|`messagedialog]
type color_selection_dialog = [dialog|`colorselectiondialog]
type input_dialog = [dialog|`inputdialog]
type file_selection = [dialog|`fileselection]
type font_selection_dialog = [dialog|`fontselectiondialog]
type plug = [window|`plug]
type box = [container|`box]
type button_box = [container|`box|`buttonbox]
type color_selection = [container|`box|`colorselection]
type font_selection = [container|`box|`fontselection]
type combo = [container|`box|`combo]
type statusbar = [container|`box|`statusbar]
type status_icon = [`gtkstatusicon]
type gtk_status_icon = status_icon obj
type fixed = [container|`fixed]
type layout = [container|`layout]
type menu_shell = [container|`menushell]
type menu = [container|`menushell|`menu]
type menu_bar = [container|`menushell|`menubar]
type notebook = [container|`notebook]
type packer = [container|`packer]
type paned = [container|`paned]
type socket = [container|`socket]
type table = [container|`table]
type grid = [container|`grid]
type toolbar = [container|`toolbar|`orientable]
type tool_item = [bin|`toolitem]
type separator_tool_item = [tool_item|`separatortoolitem]
type tool_button = [tool_item|`toolbutton]
type toggle_tool_button = [tool_button|`toggletoolbutton]
type radio_tool_button = [toggle_tool_button|`radiotoolbutton]
type menu_tool_button = [tool_button|`menutoolbutton]
type tree = [container|`tree]
type calendar = [widget|`calendar]
type drawing_area = [widget|`drawingarea]
type curve = [drawing_area|`curve]
type editable = [widget|`editable]
type entry = [editable|`entry]
type spin_button = [editable|`entry|`spinbutton]
type old_editable = [editable|`oldeditable]
type text = [old_editable|`text]
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

type text_view = [container|`textview]
type text_buffer = [`textbuffer] obj
type text_tag_table = [`texttagtable] obj
type text_tag = [`texttag] obj
type text_mark = [`textmark] obj
type text_child_anchor = [`textchildanchor] obj
type text_iter

type tree_view = [container|`treeview]
type tree_view_column = [`giu|`celllayout|`treeviewcolumn]
type tree_selection = [`treeselection] obj
type tree_model = [`treemodel] obj
type tree_model_custom = [`custommodel|`treemodel] obj
type tree_sortable = [`treemodel|`treesortable] obj
type tree_model_sort = [`treemodelsort|`treesortable|`treemodel] obj
type tree_model_filter = [`treemodelfilter|`treemodel] obj
type tree_store = [`treestore|`treesortable|`treemodel] obj
type list_store = [`liststore|`treesortable|`treemodel] obj
type tree_iter
type tree_path
type row_reference
type cell_renderer = [`giu|`cellrenderer]
type cell_renderer_pixbuf = [cell_renderer|`cellrendererpixbuf]
type cell_renderer_text = [cell_renderer|`cellrenderertext]
type cell_renderer_toggle = [cell_renderer|`cellrenderertoggle]
type cell_renderer_progress = [cell_renderer|`cellrendererprogress]
type cell_renderer_combo = [cell_renderer_text|`cellrenderercombo]
type cell_renderer_accel = [cell_renderer_text|`cellrendereraccel]

type icon_source
type icon_set
type icon_factory = [`iconfactory] obj

type size_group = [`sizegroup] obj

(* New widgets in 2.4 *)
type cell_layout = [`celllayout]
type combo_box = [bin|`combobox|cell_layout]
type combo_box_text = [combo_box|`comboboxtext]
type expander = [bin|`expander]
type file_filter = [`giu|`filefilter]
type file_chooser = [widget|`filechooser]
type entry_completion = [`entrycompletion|cell_layout] obj

type action = [`action]
type toggle_action = [action|`toggleaction]
type radio_action = [toggle_action|`radioaction]
type action_group = [`actiongroup]
type ui_manager = [`uimanager]

(* New widgets in 2.6 *)
type icon_view = [container|`iconview]
type about_dialog = [dialog|`aboutdialog]
type file_chooser_button = [box|`filechooserbutton|`filechooser]

(* New widgets in 2.12 *)
type tooltip = [`tooltip] obj

(* Widgets from GTK3 *)
type stack = [container|`stack]
type stack_switcher = [box|`stackswitcher]

(* re-export Gobject.obj *)
type 'a obj = 'a Gobject.obj
  (* constraint 'a = [> `giu] *)
  (* *Props modules break this *)

