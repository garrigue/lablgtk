(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkButton
open GObj
open GContainer

class button_skel obj = object (self)
  inherit container obj
  method clicked () = Button.clicked obj
  method grab_default () =
    Widget.set_can_default obj true;
    Widget.grab_default obj
end

class button_signals obj ?:after = object
  inherit container_signals obj ?:after
  method clicked = GtkSignal.connect sig:Button.Signals.clicked obj ?:after
  method pressed = GtkSignal.connect sig:Button.Signals.pressed obj ?:after
  method released = GtkSignal.connect sig:Button.Signals.released obj ?:after
  method enter = GtkSignal.connect sig:Button.Signals.enter obj ?:after
  method leave = GtkSignal.connect sig:Button.Signals.leave obj ?:after
end

class button_wrapper obj = object
  inherit button_skel (Button.coerce obj)
  method connect = new button_signals ?obj
  method add_events = Widget.add_events obj
end

class button ?:label ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Button.create ?:label ?None in
  let () =
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit button_wrapper w
    initializer pack_return :packing ?:show (self :> button_wrapper)
  end

class toggle_button_signals obj ?:after = object
  inherit button_signals obj ?:after
  method toggled =
    GtkSignal.connect sig:ToggleButton.Signals.toggled obj ?:after
end

class pre_toggle_button_wrapper obj = object
  inherit button_skel obj
  method connect = new toggle_button_signals ?obj
  method active = ToggleButton.get_active obj
  method set_active = ToggleButton.set_active obj
  method draw_indicator = ToggleButton.set_mode obj
end

class toggle_button_wrapper obj =
  pre_toggle_button_wrapper (ToggleButton.coerce obj)

class toggle_button ?:label ?:active ?:draw_indicator
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ToggleButton.create_toggle ?:label ?None in
  let () =
    ToggleButton.setter w cont:null_cont ?:active ?:draw_indicator;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit toggle_button_wrapper w
    initializer pack_return :packing ?:show (self :> toggle_button_wrapper)
  end

class check_button ?:label ?:active ?:draw_indicator
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ToggleButton.create_check ?:label ?None in
  let () =
    ToggleButton.setter w cont:null_cont ?:active ?:draw_indicator;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit toggle_button_wrapper w
    initializer pack_return :packing ?:show (self :> toggle_button_wrapper)
  end

class radio_button_wrapper obj = object
  inherit pre_toggle_button_wrapper (obj : radio_button obj)
  method set_group = RadioButton.set_group obj
  method group = RadioButton.group obj
end

class radio_button ?:group ?:label ?:active ?:draw_indicator
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = RadioButton.create ?:group ?:label ?None in
  let () =
    ToggleButton.setter w cont:null_cont ?:active ?:draw_indicator;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit radio_button_wrapper w
    initializer pack_return :packing ?:show (self :> radio_button_wrapper)
  end

let may_as_widget = function
    None -> None
  | Some (w : #is_widget) -> Some w#as_widget

class toolbar_wrapper obj = object
  inherit container_wrapper (obj : toolbar obj)
  method insert_widget : 'a . (#is_widget as 'a) -> _ =
    fun w -> Toolbar.insert_widget ?obj ?(w#as_widget)

  method insert_button : 'a . ?icon:(#is_widget as 'a) -> _ =
    fun ?:icon ?:text ?:tooltip ?:tooltip_private ?:pos ?:callback ->
      let icon = may_as_widget icon in
      new button_wrapper
	(Toolbar.insert_button obj type:`BUTTON ?:icon ?:text
	   ?:tooltip ?:tooltip_private ?:pos ?:callback)

  method insert_toggle_button : 'a . ?icon:(#is_widget as 'a) -> _ =
    fun ?:icon ?:text ?:tooltip ?:tooltip_private ?:pos ?:callback ->
      let icon = may_as_widget icon in
      new toggle_button_wrapper (ToggleButton.cast
	(Toolbar.insert_button obj type:`BUTTON ?:icon ?:text
	   ?:tooltip ?:tooltip_private ?:pos ?:callback))

  method insert_radio_button : 'a . ?icon:(#is_widget as 'a) -> _ =
    fun ?:icon ?:text ?:tooltip ?:tooltip_private ?:pos ?:callback ->
      let icon = may_as_widget icon in
      new radio_button_wrapper (RadioButton.cast
	(Toolbar.insert_button obj type:`BUTTON ?:icon ?:text
	   ?:tooltip ?:tooltip_private ?:pos ?:callback))

  method insert_space = Toolbar.insert_space ?obj

  method set_orientation = Toolbar.set_orientation obj
  method set_style = Toolbar.set_style obj
  method set_space_size = Toolbar.set_space_size obj
  method set_space_style = Toolbar.set_space_style obj
  method set_tooltips = Toolbar.set_tooltips obj
  method set_button_relief = Toolbar.set_button_relief obj
  method get_button_relief = Toolbar.get_button_relief obj
end

class toolbar ?:orientation [< `HORIZONTAL >] ?:style
    ?:space_size ?:space_style ?:tooltips ?:button_relief
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Toolbar.create orientation ?:style in
  let () =
    Toolbar.setter w cont:null_cont ?:space_size ?:space_style
      ?:tooltips ?:button_relief;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height
  in
  object (self)
    inherit toolbar_wrapper w
    initializer pack_return :packing ?:show (self :> toolbar_wrapper)
  end
