
class virtual druid_page obj = object
  inherit [[> GnomeDruid.druidpage]] GContainer.container_impl obj
  method as_druidpage = (obj :> GnomeDruid.druidpage Gtk.obj)
end


class druid_signals obj = object (self)
  inherit GContainer.container_signals_impl obj
  method cancel = self#connect GnomeDruid.Druid.Signals.cancel 
  method help   = self#connect GnomeDruid.Druid.Signals.help 
end

class druid obj = object (self)
  inherit GContainer.container (obj :> GnomeDruid.druid Gtk.obj)
  (* inherit [[> GnomeDruid.druid]] GContainer.container_impl obj *)
  method connect = new druid_signals (obj :> GnomeDruid.druid Gtk.obj)

  method show_finish = Gobject.get GnomeDruid.Druid.Prop.show_finish obj
  method show_help   = Gobject.get GnomeDruid.Druid.Prop.show_help obj
  method set_show_finish = Gobject.set GnomeDruid.Druid.Prop.show_finish obj
  method set_show_help   = Gobject.set GnomeDruid.Druid.Prop.show_help obj

  method set_buttons_sensitive = GnomeDruid.Druid.set_buttons_sensitive obj
  method prepend_page : 'p. (#druid_page as 'p) -> unit =
    fun p -> GnomeDruid.Druid.prepend_page obj p#as_druidpage
  method insert_page : 'p1 'p2. (#druid_page as 'p1) -> (#druid_page as 'p2) -> unit =
    fun p1 p2 -> GnomeDruid.Druid.insert_page obj p1#as_druidpage p2#as_druidpage
  method append_page : 'p. (#druid_page as 'p) -> unit =
    fun p -> GnomeDruid.Druid.append_page obj p#as_druidpage
  method set_page : 'p. (#druid_page as 'p) -> unit = 
    fun p -> GnomeDruid.Druid.set_page obj p#as_druidpage
end

let druid ?show_finish ?show_help =
  GContainer.pack_container (
    Gobject.Property.may_cons GnomeDruid.Druid.Prop.show_finish show_finish (
    Gobject.Property.may_cons GnomeDruid.Druid.Prop.show_help show_help []))
    ~create:(fun pl ->
      let w = GnomeDruid.Druid.new_druid () in
      Gobject.set_params w pl ;
      new druid w)

class druid_page_signals obj = object (self)
  inherit GContainer.container_signals_impl obj
  method back ~callback = self#connect GnomeDruid.Druid_page.Signals.back 
      (fun w -> callback (new druid w))
  method cancel ~callback = self#connect GnomeDruid.Druid_page.Signals.cancel 
      (fun w -> callback (new druid w))
  method finish ~callback = self#connect GnomeDruid.Druid_page.Signals.finish 
      (fun w -> callback (new druid w))
  method next ~callback = self#connect GnomeDruid.Druid_page.Signals.next 
      (fun w -> callback (new druid w))
  method prepare ~callback = self#connect GnomeDruid.Druid_page.Signals.prepare 
      (fun w -> callback (new druid w))
end

  
class druid_page_edge obj = object (self)
  inherit druid_page obj
  method connect = new druid_page_signals (obj :> GnomeDruid.druidpage Gtk.obj)
  method set_bg_color = GnomeDruid.Page_Edge.set_bg_color obj
  method set_textbox_color = GnomeDruid.Page_Edge.set_textbox_color obj
  method set_logo_bg_color = GnomeDruid.Page_Edge.set_logo_bg_color obj
  method set_title_color = GnomeDruid.Page_Edge.set_title_color obj
  method set_text_color = GnomeDruid.Page_Edge.set_text_color obj
  method set_text = GnomeDruid.Page_Edge.set_text obj
  method set_title = GnomeDruid.Page_Edge.set_title obj
  method set_logo = GnomeDruid.Page_Edge.set_logo obj
  method set_watermark = GnomeDruid.Page_Edge.set_watermark obj
  method set_top_watermark = GnomeDruid.Page_Edge.set_top_watermark obj
end

let druid_page_edge ~position ~aa ?title ?text ?logo ?watermark ?top_watermark =
  GContainer.pack_container [] ~create:(fun pl ->
    let w = GnomeDruid.Page_Edge.new_with_vals position ~aa ?title ?text ?logo ?watermark ?top_watermark in
    Gobject.set_params w pl ;
    new druid_page_edge w)

class druid_page_standard obj = object (self)
  inherit druid_page obj
  method vbox = new GPack.box (GnomeDruid.Page_Standard.vbox obj)
  method connect = new druid_page_signals (obj :> GnomeDruid.druidpage Gtk.obj)
  method append_item ?question ?additional_info w =
    GnomeDruid.Page_Standard.append_item obj ?question (GObj.as_widget w) ?additional_info
  method set_background = Gobject.set GnomeDruid.Page_Standard.Prop.background obj
  method set_logo = Gobject.set GnomeDruid.Page_Standard.Prop.logo obj
  method set_logo_background = Gobject.set GnomeDruid.Page_Standard.Prop.logo_background obj
  method set_title = Gobject.set GnomeDruid.Page_Standard.Prop.title obj
  method set_title_foreground = Gobject.set GnomeDruid.Page_Standard.Prop.title_foreground obj
end

let druid_page_standard ?background ?logo ?logo_background ?title ?title_foreground =
  GContainer.pack_container (
  Gobject.Property.may_cons GnomeDruid.Page_Standard.Prop.background background (
  Gobject.Property.may_cons GnomeDruid.Page_Standard.Prop.logo logo (
  Gobject.Property.may_cons GnomeDruid.Page_Standard.Prop.logo_background logo_background (
  Gobject.Property.may_cons GnomeDruid.Page_Standard.Prop.title title (
  Gobject.Property.may_cons GnomeDruid.Page_Standard.Prop.title_foreground title_foreground [])))))
    ~create:(fun pl ->
      let w = GnomeDruid.Page_Standard.new_page_standard () in
      Gobject.set_params w pl ;
      new druid_page_standard w)
    
