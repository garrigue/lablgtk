let create_tags (buffer:GText.buffer) =
  buffer#create_tag ~name:"heading" 
    ~properties:[`WEIGHT `BOLD;
		 `SIZE (15*Pango.scale)] 
    ();
  buffer#create_tag ~name:"italic" ~properties:[`STYLE `ITALIC] ();
  buffer#create_tag ~name:"bold" ~properties:[`WEIGHT `BOLD] ();  
  buffer#create_tag ~name:"big" ~properties:[`SIZE 20] ();
  buffer#create_tag ~name:"xx-small" ~properties:[`SCALE `XX_SMALL] ();
  buffer#create_tag ~name:"x-large" ~properties:[`SCALE `X_LARGE] ();
  buffer#create_tag ~name:"monospace" ~properties:[`FAMILY "monospace"] ();
  buffer#create_tag ~name:"blue_foreground" ~properties:[`FOREGROUND "blue"] ();
  buffer#create_tag ~name:"red_background" ~properties:[`BACKGROUND "red"] ();

  let stipple = Gdk.Bitmap.create_from_data 2 2 "\002\001" in
  buffer#create_tag ~name:"background_stipple" 
    ~properties:[`BACKGROUND_STIPPLE stipple] ();
  buffer#create_tag ~name:"foreground_stipple" 
    ~properties:[`FOREGROUND_STIPPLE stipple] ();
  buffer#create_tag ~name:"big_gap_before_line" 
    ~properties:[`PIXELS_ABOVE_LINES 30] ();
  buffer#create_tag ~name:"big_gap_after_line" 
    ~properties:[`PIXELS_BELOW_LINES 30] ();
  buffer#create_tag ~name:"double_spaced_line" 
    ~properties:[`PIXELS_INSIDE_WRAP 10] ();
  buffer#create_tag ~name:"not_editable" 
    ~properties:[`EDITABLE false] ();
  buffer#create_tag ~name:"word_wrap" 
    ~properties:[`WRAP_MODE `WORD] ();
  buffer#create_tag ~name:"char_wrap" 
    ~properties:[`WRAP_MODE `CHAR] ();
  buffer#create_tag ~name:"no_wrap" 
    ~properties:[`WRAP_MODE `NONE] ();
  buffer#create_tag ~name:"center" ~properties:[`JUSTIFICATION `CENTER] ();
  buffer#create_tag ~name:"right_justify" ~properties:[`JUSTIFICATION `RIGHT]
    ();
  buffer#create_tag ~name:"wide_margins" ~properties:[`LEFT_MARGIN  50;
						      `RIGHT_MARGIN 50] ();
  buffer#create_tag ~name:"strikethrough" ~properties:[`STRIKETHROUGH true] 
    ();
  buffer#create_tag ~name:"underline" ~properties:[`UNDERLINE `SINGLE] ();
  buffer#create_tag ~name:"double_underline" ~properties:[`UNDERLINE `DOUBLE]
    ();
  buffer#create_tag ~name:"superscript" 
    ~properties:[`RISE (10*Pango.scale) ;
		 `SIZE (8*Pango.scale)] ();
  
  buffer#create_tag ~name:"subscript" 
    ~properties:[`RISE (-10*Pango.scale); `SIZE (8*Pango.scale)] ();
  buffer#create_tag ~name:"rtl_quote" 
    ~properties:[`WRAP_MODE `WORD;
		 `DIRECTION `RTL;
		 `INDENT 30;
		 `LEFT_MARGIN 20;
		 `RIGHT_MARGIN 20] 
    ();
  ()

let insert_text (buffer:GText.buffer) =  
  let pixbuf = GdkPixbuf.from_file "gtk-logo-rgb.gif" in
  let scaled = GdkPixbuf.create ~has_alpha:true ~width:32 ~height:32 () in
  GdkPixbuf.scale ~dest:scaled ~width:32 ~height:32 ~interp:`BILINEAR pixbuf;
  let pixbuf = scaled in
  let iter = buffer#get_iter_at ~char_offset:0 () in
  buffer#insert ~iter ~text:"The text widget can display text with all kinds of nifty attributes. It also supports multiple views of the same buffer; this demo is showing the same buffer in two places.\n\n"
    ();
  buffer#insert ~iter ~tags_names:["heading"] ~text:"Font styles. " ();
  buffer#insert ~iter ~text:"For example, you can have " ();
  buffer#insert ~iter ~tags_names:["italic"] ~text:"italic" ();
  buffer#insert ~iter ~text:", " ();
  buffer#insert ~iter ~tags_names:["bold"] ~text:"bold" ();
  buffer#insert ~iter ~text:", or " ();
  buffer#insert ~iter ~tags_names:["monospace"] 
    ~text:"monospace(typewriter)" ();
  buffer#insert ~iter ~text:", or " ();
  buffer#insert ~iter ~tags_names:["big"] ~text:"big" ();
  buffer#insert ~iter ~text:" text. " ();
  buffer#insert ~iter ~text:"It's best not to hardcode specific text sizes; you can use relative sizes as with CSS, such as " ();
  buffer#insert ~iter ~tags_names:["xx-small"] ~text:"xx-small" ();
  buffer#insert ~iter ~text:", or " ();
  buffer#insert ~iter ~tags_names:["x-large"] ~text:"x-large" ();
  buffer#insert ~iter ~text:" to ensure that your program properly adapts if the user changes the default font size.\n\n" ();
  buffer#insert ~iter ~tags_names:["heading"] ~text:"Colors. " ();
  buffer#insert ~iter ~text:"Colors such as " ();
  buffer#insert ~iter ~tags_names:["blue_foreground"] ~text:"a blue foreground"
    ();
  buffer#insert ~iter ~text:", or " ();
  buffer#insert ~iter ~tags_names:["red_background"] ~text:"a red background"
    ();
  buffer#insert ~iter ~text:", or even " ();
  buffer#insert ~iter ~tags_names:["red_background";"background_stipple"] 
    ~text:"a stippled red background"
    ();
  buffer#insert ~iter ~text:" or " ();
  buffer#insert ~iter ~tags_names:["blue_foreground";
				   "red_background";
				   "foreground_stipple"] 
    ~text:"a stippled blue foreground on solid red background"
    ();
  buffer#insert ~iter ~text:" (select that to read it) can be used.\n\n" ();
  buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Underline, strikethrough, and rise. " ();
  buffer#insert ~iter  ~tags_names:["strikethrough"] 
    ~text:"Strikethrough" ();
  buffer#insert ~iter ~text:", " ();
  buffer#insert ~iter  ~tags_names:["underline"] 
    ~text:"underline" ();
  buffer#insert ~iter ~text:", " ();
  buffer#insert ~iter  ~tags_names:["double_underline"] 
    ~text:"double underline" ();
  buffer#insert ~iter ~text:", " ();
  buffer#insert ~iter  ~tags_names:["superscript"] 
    ~text:"superscript" ();
  buffer#insert ~iter ~text:", " ();
  buffer#insert ~iter  ~tags_names:["subscript"] 
    ~text:"subscript" ();
  buffer#insert ~iter ~text:" are all supported.\n\n" ();
  buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Images" ();
  buffer#insert ~iter ~text:"The buffer can have images in it: " ();
  buffer#insert_pixbuf ~iter ~pixbuf;
  buffer#insert_pixbuf ~iter ~pixbuf;
  buffer#insert_pixbuf ~iter ~pixbuf;
  buffer#insert ~iter ~text:" for example.\n\n" ();
  buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Spacing" ();
  buffer#insert ~iter
    ~text:"You can adjust the amount of space before each line.\n" ();
  buffer#insert ~iter  ~tags_names:["big_gap_before_line";"wide_margins"] 
    ~text: "This line has a whole lot of space before it.\n" ();
  buffer#insert ~iter  ~tags_names:["big_gap_after_line";"wide_margins"] 
    ~text:"You can also adjust the amount of space after each line; this line has a whole lot of space after it.\n" ();
  buffer#insert ~iter  ~tags_names:["double_spaced_line";"wide_margins"] 
    ~text:"You can also adjust the amount of space between wrapped lines; this line has extra space between each wrapped line in the same paragraph. To show off wrapping, some filler text: the quick brown fox jumped over the lazy dog. Blah blah blah blah blah blah blah blah blah.\n" ();
  buffer#insert ~iter
    ~text:"Also note that those lines have extra-wide margins.\n\n" ();
  buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Editability" ();
  buffer#insert ~iter ~tags_names:["not_editable"] 
    ~text:"This line is 'locked down' and can't be edited by the user - just try it! You can't delete this line.\n\n" ();
   buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Wrapping" ();
  buffer#insert ~iter ~tags_names:["char_wrap"] 
    ~text: "This line has character-based wrapping, and can wrap between any two character glyphs. Let's make this a long paragraph to demonstrate: blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah\n\n" ();
  buffer#insert ~iter ~tags_names:["no_wrap"] 
    ~text:"This line has all wrapping turned off, so it makes the horizontal scrollbar appear.\n\n\n" ();
   buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Justification" ();
  buffer#insert ~iter ~tags_names:["center"] 
    ~text:"\nThis line has center justification.\n" ();
  buffer#insert ~iter ~tags_names:["right_justify"] 
    ~text:"\nThis line has right justification.\n" ();
  buffer#insert ~iter ~tags_names:["wide_margins"] 
    ~text:"\nThis line has big wide margins. Text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text.\n" ();
   buffer#insert ~iter  ~tags_names:["heading"] 
    ~text:"Internationalization" ();
   buffer#insert ~iter
    ~text:"You can put all sorts of Unicode text in the buffer.\n\nGerman (Deutsch Süd) Grüß Gott\nGreek (Ελληνικά) Γειά σας\nHebrew	שלום\nJapanese (日本語)\n\nThe widget properly handles bidirectional text, word wrapping, DOS/UNIX/Unicode paragraph separators, grapheme boundaries, and so on using the Pango internationalization framework.\n" ();  
   buffer#insert ~iter
    ~text:"Here's a word-wrapped quote in a right-to-left language:\n" ();
   buffer#insert ~iter ~tags_names:["rtl_quote"]
    ~text:"وقد بدأ ثلاث من أكثر المؤسسات تقدما في شبكة اكسيون برامجها كمنظمات لا تسعى للربح، ثم تحولت في السنوات الخمس الماضية إلى مؤسسات مالية منظمة، وباتت جزءا من النظام المالي في بلدانها، ولكنها تتخصص في خدمة قطاع المشروعات الصغيرة. وأحد أكثر هذه المؤسسات نجاحا هو »بانكوسول« في بوليفيا.\n\n" ();
   buffer#insert ~iter
       ~text:"You can put widgets in the buffer: Here's a button: " ();
   buffer#create_child_anchor iter;
   buffer#insert ~iter
       ~text:" and a menu : " ();
   buffer#create_child_anchor iter;
   buffer#insert ~iter
       ~text:" and a scale : " ();
   buffer#create_child_anchor iter;
   buffer#insert ~iter
       ~text:" and an animation : " ();
   buffer#create_child_anchor iter;
   buffer#insert ~iter
       ~text:" finally a text entry : " ();
   buffer#create_child_anchor iter;
   buffer#insert ~iter
       ~text:".\n" ();
   buffer#insert ~iter
       ~text:"\n\nThis demo doesn't demonstrate all the GtkTextBuffer features; it leaves out, for example: invisible/hidden text (doesn't work in GTK 2, but planned), tab stops, application-drawn areas on the sides of the widget for displaying breakpoints and such..." ();
   let start,stop = buffer#get_bounds in
   buffer#apply_tag_by_name "word_wrap" ~start ~stop ; 
   ()


let find_anchor (iter:GText.iter) =
  try
    while iter#forward_char ()
    do 
      if iter#get_child_anchor<>None then raise Exit
    done;
    false
  with Exit -> true

let attach_widgets (text_view:GText.view) =
  let buffer = text_view#get_buffer in
  let iter = buffer#get_start_iter in
  let i = ref 0 in
  while find_anchor iter do
    let anchor = match iter#get_child_anchor with 
      | Some c -> c 
      | None -> assert false
    in
    let widget = match !i with 
      | 0 -> (GButton.button ~label:"Click me!" ())#coerce
      | 1 -> let menu = GMenu.menu () in
	let widget = GMenu.option_menu () in
	let menu_item = GMenu.menu_item  ~label:"Option 1" () in
	menu#append menu_item;
	let menu_item = GMenu.menu_item  ~label:"Option 2" () in
	menu#append menu_item;
	let menu_item = GMenu.menu_item  ~label:"Option 3" () in
	menu#append menu_item;
	widget#set_menu menu;
	widget#coerce
      | 2 -> let widget = GRange.scale `HORIZONTAL () in
	widget#adjustment#set_bounds ~lower:0. ~upper:100. ();
	(* HOWTO to do :  gtk_widget_set_size_request (widget, 70, -1); *)
	widget#coerce
      | 3 -> let image = GMisc.image () in
	image#set_file "floppybuddy.gif";
	image#coerce
      | 4 -> (GEdit.entry ())#coerce
      | _ -> assert false
    in
    text_view#add_child_at_anchor widget anchor;
    incr i
  done

let main () =
  let window = GWindow.window () in
  window#set_default_size ~width:450 ~height:450;
  window#connect#destroy ~callback:(fun _ -> exit 0);
  window#set_title "TextView";  window#set_border_width 0;
  let vpaned = GPack.paned `VERTICAL () in
  vpaned#set_border_width 5;
  window#add (vpaned:>GObj.widget);
  let view1 = GText.view () in
  let buffer = view1#get_buffer in
  let view2 = GText.view ~buffer () in
  let sw = GBin.scrolled_window () in
  sw#set_hpolicy `AUTOMATIC;
  sw#set_vpolicy `AUTOMATIC;
  vpaned#add1 (sw:>GObj.widget);
  sw#add (view1:>GObj.widget);
  let sw = GBin.scrolled_window () in
  sw#set_hpolicy `AUTOMATIC;
  sw#set_vpolicy `AUTOMATIC;
  vpaned#add2 (sw:>GObj.widget);
  sw#add (view2:>GObj.widget);
  create_tags buffer;
  insert_text buffer;  
  attach_widgets view1;
  attach_widgets view2;
  window#show ();
  ()

let _ = GtkMain.Main.init ();
  main () ;
  
  GMain.Main.main ();; 
