LablGTK changes log

## In Lablgtk-3.0.beta5:

2019.02.12 [Emilio]
  * Update OPAM files so they work better with dune-release

## In Lablgtk-3.0.beta4:

2019.02.11 [Jacques]
  * More dune related PRs (#39, #43, #45, #46) [Emilio]
  * Add initialization to all examples

2019.02.10 [Jacques]
  * Add dune support (cf GPR#38,#41,#42,#44) [Emilio]
  * Move initialization functions to Props files, to avoid problem with
    -no-alias-deps (cf GPR#39)

## In Lablgtk-3.0.beta3:

2019.01.11 [Jacques]
  * Update propcc.ml4 as suggested by Virgile Prevosto
  * Merge Lablgtk3 source mark attributes #35 by Virgile Prevosto

2019.01.11 [Claudio Sacerdoti Coen]
  * added hard dependency on cairo2 (aka ocaml-cairo)
  * Gdk.cairo is now equal to Cairo.context
  * code of cairo-pango (part of ocaml-cairo) by Christophe Troestler
    moved into lablgtk3
  * added new examples {cairo,pango1,pango2}.ml
  * GPango.context#get_font_description added
  * GPango.context_rw merged into GPango.context

2019.01.04 [Jacques]
  * merge draw signal PR by Claudio
  * remove incorrect statusbar properties

2018.12.22 [Claudio Sacerdoti Coen]
  * update examples/glade and README

2018.12.21 [Jacques]
  * adjust some function names
  * merge GtkBuilder support and new lablgladecc by Claudio Sacerdoti Coen
    and Andrea Condoluci

2018.12.19 [Jacques]
  * Resurect GMenu.separator_item
  * fix examples eventbox.ml, events.ml, editor2.ml

## In Lablgtk-3.0.beta2:

2018.12.14 [Jacques]
  * Remove unsupported extensions from configure

2018.12.9 [Guillaume Melquiond]
  * Support property "expand" of GtkTreeViewColumn
  * Support property "placeholder-text" of GtkEntry
  * Restore GPack.button_box ?spacing argument
  * Restore GtkMenu.MenuItem.separator_create
  * Remove properties allow-grow and allow-shrink from GtkWindow

2018.12.6 [Jacques]
  * allow compiling with Gtk 3.18 (for ubuntu 16.04)

2018.11.30 [Jacques]
  * ensure we compile on ocaml 4.05 (report by Ralf Treinen)
  * put examples explicitly in the public domain (report by Ralf Treinen)

2018.11.29 [Jacques]
  * create a banch called "lablgtk3", based on lablgtk2on3
    (the old lablgtk3 branch of 2011 is renamed lablgtk3_monate)
  * merge all changes from Hugo Herbelin's lablgtk2on3-hh
  * rename everything to lablgtk3, allow installing in parallel with lablgtk2
  * add memory management for cairo_t
  * update support for GtkSpell

2018.11.26 [Emilio J. Gallego Arias]
  * add support for building with Dune

2018.11.20 [Hugo Herbelin]
  * restore deprecated by still alive widgets and methods
  * various fixes to make gtksourceview3 work with CoqIDE

2018.11.19 [Hugo Herbelin]
  * In GToolbox, add support for declaring dialogs transient for a parent.

2018.11.12 [Maxence]
  * Add some properties to GText.tag

2018.08.25 [Francois Bobot]
  * Add require for threads in META

## In Lablgtk-2.18.6:

2017.10.30 [Jacques]
  * prepare release
  * finish transition for applications subdirectory

2017.09.19 [Jacques]
  * prepare for 4.06: -safe-string transition and warnings

In Lablgtk-2.18.5:

2016.08.10 [Jacques]
  * update applications/browser for 4.04

2016.08.02 [Jacques]
  * add CAMLparam before CAMLlocal (report by Francois Bobot)
  * add -fno-unwind-tables to GTKCFLAGS if the compiler allows it
    (suggested by Bart Jacobs)

In Lablgtk-2.18.4:

2016.04.27 [Jacques]
  * disable camlp4 make rule when no camlp4o available
  * update applications
  * rename GC module to GMain.Gc_custom

2016.04.11 [Jacques]
  * Fix ml_gnome_canvas_c2w (Didier Le Botlan)

2016.03.06 [Jacques]
  * remove build dependency on camlp4 (still needed for tree version)
  * allow to change the GC speed (i.e. the impact of custom blocks)
    see GMain.GC.set_speed.

2016.03.04 [Jacques]
  * use own definition of alloc_custom, to be sure to allocate in the heap

2015.04.16 [Jacques]
  * fix GtkTree.TreeModel.cast

2015.02.06 [Jacques]
  * add get_image and get_pixbuf to GDraw.drawable.

In Lablgtk-2.18.3:

2014.10.06 [Jacques]
  * add Gdk.Window.create_foreign and set_transient_for functions
    (Tim Cuthbertson)

2014.09.20 [Jacques]
  * CAMLparam initializes with Val_unit rather than 0 since ocaml 4.02.
    Fix a related problem in ml_gobject.
    This caused random crashes with unison (Christopher Zimmermann, PR#1425)

  * Also factorize some code to use Val_option_*
  * Replace XID by GdkNativeWindow where required.
    You may need to insert calls to Gdk.Window.native_of_xid in some places.

In Lablgtk-2.18.2:

2014.09.17 [Jacques]
  * Revert old commit which broke notify signals
  * Quote $(FLINSTALLDIR) in Makefile (cf PR#1342)
  * Update applications/browser for 4.02

2014.08.22 [Jacques]
  * Make Float_val an alias for Double_val, since it was used
    wrongly anyway (Felix Ruess)
  * Make GObj.misc_ops#add_accelerator polymorphic in the widget of
    the signal (Erkki Seppala)
  * Use properties in GtkAdjustment, rather than direct accessors

2013.12.31 [Jacques]
  * fix GtkTree.IconView.get_path_at_pos (Thomas Leonard)

In Lablgtk-2.18.1:

2013.12.6 [Jacques]
  * add gtksourceview2 to windows binaries

In Lablgtk-2.18.0:

2013.10.01 [Jacques]
  * prepare release
  * update applications for 4.01
  * various fixes in windows port

2013.9.17 [Jacques]
  * add some GTK enumerations and update stock icon list
  * add properties GtkTreeView.enable_{tree,grid}_lines
  * add properties GtkEntry.{primary,secondary}_icon_{stock,name,pixbuf},
    see examples/entry2.ml for usage

2013.7.29 [Pierre-Marie]
  * add tags in GtkMovementStep

2013.2.19 [Jacques]
  * fix compatibility with ocaml 4.01 (?lab for non-optional arguments)

2012.08.26 [Pierre-Marie]
  * add handling of new modifiers

2012.08.26 [Jacques]
  * detect findlib during configuration
  * support DESTDIR with findlib-install

2012.08.26 [Jacques]
  * indicate that only old-install supports DESTDIR
  * have old-install copy the META file too
  * cleanup the two phases of findlib-install

In Lablgtk-2.16.0:

2012.08.23 [Jacques]
  * update Windows port, compiles fine on mingw with
    ./configure --disable-gtktest
  * lablgtk2 script does not load extra libraries by default
    (use flag -all to load all extensions)

2012.08.17 [Jacques]
  * generate correct lablgtk2 script for findlib.
  * add old-uninstall target.
  * support threaded toplevel with Quartz backend, using gtkThTop.ml
    (runs the toplevel loop in another thread)
  * remove GtkThInit from META (not portable)
  * avoid busy waiting by using g_main_context_set_poll_func to
    make polling non-blocking.
    busy waiting is still needed for VM threads, and can be activated
    by setting the environment variable LABLGTK_BUSY_WAIT.

2012.08.16 [Jacques]
  * update applications/browser for OCaml 4.00
  * update applications/camlirc to use GText instead of GBroken.text

2012.07.26 [Pierre-Marie]
  * improvements to GtkSourceView2.
  * add cast and assignation functions to GText.nocopy_iter.
  * add Gtk 2.10 missing key modifiers.

2012.07.24 [Jacques]
  * can still install using old-install.

2012.06.19 [Adrien]
  * add a high-level API to create keyboard shortcuts.

2012.06.12 [Adrien]
  * add several #as_foo methods: entry, notebook, range
  * new signals for notebook: select_page, reorder_tab,
    change_current_page, move_focus_out, page_{added,removed,reordered}
  * add gtk_container_child_{set,get}_property
  * add gtk_notebook_{set,get}_tab_reorderable
  * add gtk_signal_new which can be used to create custom keyboard shortcuts
  * add g_signal_list and g_signal_query
  * add functions to connect to notify::foo signals which indicate when an
    object property changes
  * add foo#connect#notify_bar methods to add callbacks on changes of
    the "bar" property of the object "foo".

2012.04.11 [Maxence]
  * use findlib to install (see README for the list of installed packages)

2012.06.05 [Jacques]
  * merge GtkSourceView2 additions by Pierre-Marie Pedrot

2012.03.07 [Jacques]
  * add Make_Val_option to wrappers.h

2011.07.20 [Jacques]
  * add gtk_accelerator_name/get_label (for Pierre Boutillier)
  * add gtk_accel_map_foreach/change_entry (ibid)
  * add gdk_window_clear_area (for DDR)
  * make gtk_tree_view_get_visible_range version dependent (Thomas Ripoche)

In Lablgtk-2.14.2:

2010.09.09 [Jacques]
  * add GtkCurve (but it is deprecated since 2.20)

2010.08.16 [Jacques]
  * rename g_value_{get,set}_variant, as the name is used by recent
    versions of glib (reported by Florent Monnier)

2010.07.25 [Jacques]
  * add changed signal to cell_renderer_combo (reported by Dmitry Bely)

2010.07.23 [Jacques]
  * copy GtkTreePath arguments in callbacks, as reported by Benjamin.

2010.06.25 [Jacques]
  * remove gtkInit.cmo from gdk_pixbuf_mlsource, no need to
    initialize Gtk as Gobject is sufficient
  * protect GtkThread callbacks against exceptions, and provide a
    function to process messages inside a different main loop.
  * add -nothinit option to lablgtk2, since Quartz cannot run the main
    loop in a different thread (one should just call GtkThread.main).
    See dialog-thread.ml for an example.

2010.06.08 [Jacques]
  * correct interfaces due to the fixing of an unsoundness bug in ocaml 3.12
    (cf. http://caml.inria.fr/mantis/view.php?id=4824)

In Lablgtk-2.14.1:

2010.05.20 [Jacques]
  * update unison patch to 2.40.16 (for Quartz users)

2010.05.18 [Jacques]
  * rename gtkSignal.ml to gtkSignal.ml4 and fix depend target
  * move Glib.Utf8 code to gutf8.ml, so that it can be used in xml_lexer
    to fix a bug report by Pascal Brisset (multibyte entities of the form
    &#x25CF; in glade files).

2010.04.08 [Jacques]
  * remove useless methods (discovered by ocaml 3.12)

2010.01.14 [Benjamin]
  * Apply patch from Mike Spivey to support get_visible range in Gtree
  * Fixed incorrect target labgtkspell.cmxs in Makefile

2009.10.01 [Jacques]
  * Correct wrong module name SourceViewEnums -> SourceView2Enums

In Lablgtk-2.14.0:

2009.09.25 [Jacques]
  * Ensure compilation under windows

2009.09.22 [Benjamin]
  * Restore compatibility with pre-3.11 OCaml versions
2009.09.01 [Benjamin]
  * Apply patch from Mike Spivey:
    * Access to StyleSchemeManager objects
    * Some attributes are strings and not string options.  This seems
      sensible.
    * Languages and style schemes are treated alike in creating buffers:
      both arguments are wrapped.
    * draw_spaces deals with a list of flags, not a single flag.
    * Mark categories can have priorities, icons and backgrounds
    * Some attributes of languages are accessed by methods instead of
      properties to work around a GTK bug.

2009.09.01 [Benjamin]
  * Support for GtkSourceView 2.6 in library "lablgtksourceview2"
  * Support for GtkSourceView 1.x is still available in library
    "lablgtksourceview" but it is no longer linked into the lablgtk2
    default toplevel as it is not linkable with "lablgtksourceview2".

2009.05.21 [Jacques]
  * Apply Anil Madhavapeddy patch for lablgladecc2 -hide-default

2009.05.18 [Benjamin]
  * Make and install dynamic cmxs objects when available.
  * Fix compilation bug for ml_panel.c (Richard Jones message of 2009-02-06)

2009.05.12 [Jacques]
  * Merge new tooltip support from Moutinho's branch r1365
    (sorry for 1.5y delay...)
  * Merge tree DND from Moutinho's branch r1387 (1y delay...)

2009.05.08 [Jacques]
  * Add Gdk.Windowing.platform for platform dependent applications
  * Fix bug in Clist.set_pixmap when no mask given

2009.04.20 [Jacques]
  * Print backtrace if available when exception raised in signal callback.
    Requires ocaml 3.11. (suggested by Bart Jacobs)
  * Use "val virtual obj" in generated code. Requires ocaml 3.10.

2009.03.19 [Jacques]
  * In GtkAboutDialog, change internal property from "name" to "program-name"
    if version >= 2.12. The OO interface is left unchanged, since there is
    no conflict with #misc#name anyway.

2009.02.09 [Benjamin]
  * fix linking bug for older than 2.2 Gtk with g_io_channel_read_chars
2009.01.20 [Benjamin]
  * change handling of non existent properties.
    [Not_found] is no longer raised and [Invalid_argument prop_name] is
    used instead.
    No exception is raised by unknown dynamic property setters and a GLib
    warning is emitted.
    See the comments in src/gobject.mli in the local Property module.
2009.01.13 [Benjamin]
  * fix compilation issues with Gtk 2.4

In Lablgtk-2.12.0:
2008.12.20 [Jacques]
  * fix build process for ocaml 3.11 on MSVC and mingw.

2008.12.09 [Jacques]
  * fix ml_gtk_source_buffer_create_marker

2008.10.30 [Benjamin]
  * Support Gtk Quartz backend compilation (thanks to Pascal Cuoq)
2008.10.07 [Benjamin]
  * Revert last change on GEdit.entry_completion according to M. Clasen.
    Keeping the new type for the callback match_selected.
2008.10.05 [Benjamin]
  * Change type of model contained in GEdit.entry_completion from
    model to model_filter see
    http://bugzilla.gnome.org/show_bug.cgi?id=555087.
2008.09.10 [Benjamin]
  * Many custom tree model bugs fixed.

2008.09.04 [Benjamin]
  * First attempt to support custom_tree_models in GTree.
    I need some feedback on ways to improve the safety.
    An example of usage is given in examples/custom_tree.ml
    Part of the code comes from Robert Schneck: he agreed by private mail
    on relicensing it for lablgtk2.

2008.08.20 [Jacques]
  * Move model to head of properties in ComboBox
    (bug reported by Pierre-Marie Pedrot)

2008.08.03 [Benjamin]
  * Support for wrapped signal of GEdit.spin_button (Gtk 2.10)

2008.08.01 [Benjamin]
  * Support for GtkRendererAccel of Gtk 2.10

2008.07.26 [Benjamin]
  * Add a few 2.10 properties GAction.icon_name, GButton.image_position,

2008.07.25 [Olivier]
  * don't use G_QUEUE_INIT (dependency on glib 2.14)

2008.07.25 [Jacques]
  * Add [widget] to Gtk.file_chooser
  * configure did not work on FreeBSD

2008.05.09 [Benjamin]
  * Add Glib.Io.read_chars. Other g_io_* function could be added...

2008.04.14 [Olivier]
  * use Gc.create_alarm to delay GObject finalization instead of an idle
    function

2008.03.31 [Benjamin]
  * Support mingw compilation with OCaml 3.11. Still tricky...

2008.03.25 [Jacques]
  * add GtkWindow properties
  * add GMain.Event
  * add GtkMenu.Menu.popup_at

2008.03.22 [Benjamin]
  * prepare gtksourceview 2.1 support

In lablgtk-2.10.1:
2008.02.26 [Jacques]
  * fix wrong type in GContainer.mli (could not compile with 3.10.2)

2007.12.01 [Jacques]
  * revert to setting LC_NUMERIC to C (ocaml still uses strtod)

2007.11.28 [Jacques]
  * Fix Val_GType/GType_val (use Val_addr/Addr_val)

2007.10.09 [Benjamin]
  * add ui_manager#as_ui_manager

2007.09.27 [Jacques]
  * Fix examples.

In lablgtk-2.10.0:
2007.09.25 [Jacques]
  * Various preparations for release.
  * Use the "Glade for Windows" distribution for win32,
    supporting glade and rsvg.

2007.08.17 [Jacques]
  * some more patch by Julien Moutinho (style and Rc).
  * do not set LC_NUMERIC to C (ocaml is now ok) (Volker Grabsch).
  * avoid some warnings in ml_gdkpixbuf and ml_glib.

2007.08.09 [Benjamin]
  * GtkImage : clear support

2007.08.08 [Benjamin]
  * Fix typo in property "wrap-license" (was "wrap-licence") of GtkAboutDialog
  * Add GtkFileChooser "do-confirm-overwrite" property support and
     "confirm-overwrite" signal
  * GWindow "urgency-hint" property support

2007.08.07 [Benjamin]
  * Add Glib.usleep
  * Add Stock icons for Gtk 2.10 and 2.8
  * Add  has_selection and cursor_position properties in GText.buffer

2007.08.06 [Benjamin]
  * Add support for GtkAssistant of Gtk 2.10

2007.06.18 [Jacques]
  * merge patches by Julien Moutinho for GdkDisplay
    and gtk_tree_view_get_cell_area.

2007.06.08 [Benjamin]
  * Add support for gtk_link_button

2007.06.07 [Benjamin]
  * gtksourceview support

2007.05.27 [Benjamin]
  * fixed bug in GWindow.about_dialog whose callbacks raised an uncaught
    Not_found.
    The default Close button now responds `CANCEL and not `CLOSE.

2006.11.19 [Olivier]
  * add some missing properties in GtkIconView (in module GTree) (2.6)
  * add some missing properties in GtkButton (2.4, 2.6)

2006.11.03 [Olivier]
  * move GtkSocket code from ml_gtkbin.c to ml_gtk.c since it is
    wrapped in GWindow.

2006.10.27 [Jacques]
  * add Gdk.Cursor.get_image
  * remove Gdk.Cursor.destroy (could be dangerous)
  * add new methods to GData.clipboard (partly from SooHyoung Oh)

2006.10.13 [Jacques]
  * add GDraw.drawable#colormap,gc,set_gc

2006.09.15 [Olivier]
  * wrap GtkMenuToolButton (2.6)

In lablgtk2-20060908:
2006.08.08 [RobertR]
  * export copy_memblock_indirected and ml_lookup_flags_getter for Windows

2006.07.06 [Jacques]
  * make ABSVALUE=1 to use a custom mlvalues.h where value is abstract

2006.05.13 [Jacques]
  * delay finalization functions when they may trigger a callback

2006.02.03 [Jacques]
  * add GLayout#bin_window

2005.12.19 [Jacques]
  * lablgladecc : apply Keita Yamaguchi's patch

2005.12.02 [Benjalin]
  * lablgladecc : support for GtkAboutDialog

2005.11.10 [Olivier]
  * wrap gtk_tree_view_expand_to_path (2.2)

2005.11.03 [Benjamin]
  * lablgladecc : emit w#toplevel#misc#show_all instead of
    w#toplevel#show in check_all, because some toplevel widgets
    (gMenu for example) do not have a show method

2005.10.28 [Jacques]
  * add windows support for rsvg

In lablgtk2-20051027 (2.6.0):

2005.10.25 [Jacques]
  * fix GtkThread.sync (Robert Schneck-McConnell)

2005.10.17 [Jacques]
  * new recompilation approach for Windows

2005.10.03 [Olivier]
  * fix refcounting of pixbufs in GdkPixbuf

2005.09.24 [Olivier]
  * wrap gdk_cursor_new_from_pixbuf

2005.08.25 [Olivier]
  * gtk_about_dialog_set_{url,email}_hook are not methods : fix the
    external type declaration and remove from the GWindow.about_dialog class.

2005.08.18 [Olivier]
  * add special sort_column_id values in GTree to select default sort
    function or disable sorting
  * add a couple of utility functions in Glib :
      - getenv, setenv, unsetenv (2.4)
      - get_user_data_dir, etc. (2.6)
  * change the generated code of gdk-pixbuf-mlsource a bit.

In lablgtk2-20050701:
2005.06.30 [Jacques]
  * export same symbols under unix and windows

In lablgtk2-20050613:
2005.06.13 [Jacques]
  * define GText.buffer_skel and GText.view_skel

2005.06.02 [Jacques]
  * export all macro-generated functions (robertr)
  * change --rpath to -rpath (better done in ocamlmklib?)

2005.05.03 [Olivier]
  * wrap GdkPixbuf.get_file_info (2.4)
  * support serialization and deserialization of GdkPixbuf.pixbuf values
  * add a gdk-pixbuf-mlsource tool to help compiling images into programs.

2005.03.20 [Jacques]
  * add Gobject.Data.wrap to create new conversions

2005.03.07 [Olivier]
  * add GEdit.entry#xalign property (2.4)
  * make configure fail if GTK+ cannot be found

In lablgtk2-20050218:
2005.02.18 [Jacques]
  * add GObj.event_signals#scroll and other missing wevents (Hendrik Tews)

2005.02.17 [Jacques]
  * allow using vmthreads

2005.02.07 [Olivier]
  * GTree.Path.is_prev now returns bool (T. Kurt Bond)

2005.01.08 [Olivier]
  * add a use_markup optional argument to GEdit.combo_box_text.

2005.01.04 [Olivier] (2.6)
  * new stock items
  * add PangoEllipsizeMode for PangoLayout
  * new GtkLabel properties
  * new GtkProgressbar::ellipsize property
  * new GtkTreeView properties and separator rows

2005.01.02 [Olivier]
  * 2.6 improvements to GtkComboBox (separators and a couple of new
    properties)

2004.12.05 [Olivier]
  * add GtkFileChooserButton (2.6)

2004.12.04 [Jacques]
  * fix constraint in GUtil.memo

2004.12.02 [Olivier]
  * add GtkAboutDialog (2.6)

2004.12.02 [Jacques]
  * fix Michael Furr's bug reports

2004.11.24 [Olivier]
  * add GMisc.statusbar#has_resize_grip and #set_has_resize_grip
    GMisc.statusbar now inherits from GPack.box
  * add GtkIconView (2.6)

2004.11.22 [Olivier]
  * add GtkCellRendererCombo (2.6)
  * add GtkCellRendererProgress (2.6)

In lablgtk2-20041119:

2004.11.17 [Jacques]
  * fix make depend
  * cleanup lablgtk2.in

2004.11.15 [Olivier]
  * add max-position and min-position in GPack.paned (2.4)
  * add GtkSpell interface (http://gtkspell.sf.net/)

2004.11.10 [Olivier]
  * add GPack.paned#position
  * allow multiple conditions per watch in Glib.Io.add_watch

2004.10.24 [Olivier]
  * add a .mli for GnoDruid, reorganize gnoDruid.ml a bit
  * add the single-paragraph-mode property in GtkCellRendererText

2004.10.05 [Jacques]
  * revise Timeout.add and Idle.add for compatibility
    (optional arguments must be followed by a non-labeled argument)

2004.10.02 [Jacques]
  * 2.2 compatibility fixes (G_STRFUNC only defined in 2.4)

2004.09.21 [Olivier]
  * add optional priority argument for timeouts and idle callbacks in Glib
  * get rid of the print handler in Glib.Message (it's not used by libraries)
  * get rid of the Glib.Critical exception (callbacks should never raise exceptions)
  * add Glib.Message.log and a couple other functions related to logging
  * generally prevent exceptions from escaping callbacks

2004.09.18 [Jacques]
  * revert to using `OTHER in Gobject.data_kind

2004.09.17 [Olivier]
  * more unicode fixes, add a Utf8.to_unichar_validated function

2004.09.17 [Jacques]
  * Gobject.Data.boxed parameterized by the real type, to be able to
    create tree store columns from it. Gobject.fundamental_type
    modified accordingly.

2004.09.15 [Olivier]
  * add GText.buffer#select_range

2004.09.14 [Olivier]
  * add a few unicode-related functions

2004.09.08 [Olivier]
  * add GAction.ui_manager#add_ui
  * have #get_widget and #get_action raise Not_found instead of
    Null_pointer.

2004.09.03 [Olivier]
  * in GAction.action_group, do not merge #add_action and
    #add_action_with_accel in a single method because they have
    different behaviour. Fixes a bug where stock items accelerators
    were not connected.
  * add the padding properties of GBin.alignment (2.4)

2004.08.27 [Olivier]
  * add GTree.cell_layout#reorder and GTree.cell_layout#set_cell_data_func
  * add a couple of utility functions in Glib
  * decimate ml_gtkmisc.c, add a couple of things to GtkCalendar and GtkLabel

2004.08.24 [Olivier]
  * add GWindow.message_dialog#set_markup (2.4)
  * add override of default signal handlers
    (GtkSignal.override_class_closure, GtkSignal.chain_from_overridden)

2004.08.23 [Olivier]
  * wrap some 2.4 additions in GdkPixbuf (from_file_at_size,
    save_to_buffer). Add some Ocamldoc comments.
  * add 2.4 stock items in GtkStock

2004.08.20 [Jacques]
  * fix GdkPixbuf.render_to_drawable
  * support gtk-2.0.1
  * add examples/GL/texturesurf.ml with texture from pixbuf

2004.08.19 [Olivier]
  * add 'active' property of ComboBox as a constructor parameter.
  * qualify conversion tables as 'const' (so they end up in read-only
    pages)
  * add some ocamldoc comments

2004.08.11 [Olivier]
  * have GAction.ui_manager#add_ui_from_string raise an exception in
    case of error.
  * add Glib.Markup.Error exception.
  * avoid memory leaks in Glib.Convert.
  * remove some dead code (GtkPreview).

In lablgtk2-20040716 (2.4.0):

2004.07.16 [Jacques]
  * add GLib.Io.remove and Glib.Io.read, works under windows too

2004.07.09 [Olivier]
  * Rewrite Xml_lexer so that it is more conformant.

2004.07.08 [Olivier]
  * fix the support of SVGZ files for older versions of librsvg where
    the header is not always present.

2004.07.05 [Olivier]
  * add ocamldoc comments for some optional parameters.
  * add some optional parameters to the GtkFileFilter constructor.

2004.06.28 [Olivier]
  * support SVGZ files in Rsvg, fix for render_from_file on Win32, fix
    memory leak.

2004.06.22 [Olivier]
  * extend GtkComboBox convenience API to GtkComboBoxEntry.

2004.06.15 [Olivier]
  * fix the ocamldoc generator for ocaml 3.08
  * silence some GCC 3.4 warnings

2004.06.10 [Olivier]
  * add #event method for GtkComboBox (and descendants), and
    GtkFileChooserWidget

2004.06.06 [Olivier]
  * changed methods returning a char* or NULL in GFile: now they
    return string option instead of converting NULL into "".

2004.06.02 [Olivier]
  * add some properties for the GnomeCanvasText item, introduce a
    GnoCanvas.text class with getters for text height and width
  * relax type constraint in GUtil.memo so that it can work for
    non-widget gobjects
  * add Glib.Markup.escape_text (useful for dealing with pango markup)

2004.06.01 [Olivier]
  * export a couple of properties in GButton.button_skel

2004.05.09 [Olivier]
  * extended toolbar API (2.4)
  * update GtkAction* widgets to the final API

2004.04.04 [Olivier]
  * re-implement Gobject.Data.caml (correctly this time)

2004.03.26 [Olivier]
  * Add a common supertype for canvas items: GnoCanvas.base_item.
  * Improve the signatures of canvas, group and item classes in
    GnoCanvas (no more low-level Gtk.obj)

2004.03.23 [Olivier]
  * generic handling of GError on the C side
  * added exception Glib.Convert.Error

In lablgtk2-20040319:

2004.03.18 [Jacques]
  * move GTree.tree to GBroken.tree (really broken in 2.4?)
  * add GBroken.text
  * add GContainer#all_children
  * add GUtil.print_widget

2004.03.17 [Olivier]
  * add GFile.filter#add_custom
  * add special methods for adding open/save button in
    GWindow.file_chooser_dialog

2004.03.15 [Jacques]
  * allow destroying pixmaps manually
  * update GdkPixbuf support
  * PangoLayout corrections (incompatible with previous snapshot)

2004.03.10 [Olivier]
  * update several 2.4 widgets to the latest API (ComboBox, TreeView,
    FileChooser).
  * add a convenience function GTree.store_of_list
  * change the type of #iter_n_children and #iter_children in GTree.model

2004.03.05 [Olivier]
  * gtk_dialog->action_area is a GtkHButtonBox
  * add gtk_button_box_{set,get}_child_secondary (2.4)
  * misc. additions and cleanups in GPack.box and GPack.button_box

In lablgtk2-20040304:

2004.03.04 [Jacques]
  * fix dependencies in src/Makefile
  * fix #layout in GDraw.{drawable,pixmap}
  * fix typing problems in 3.06 and 3.07+14

2004.03.01 [Jacques]
  * add Pango.Layout and GDraw.drawable#layout

2004.02.29 [Olivier]
  * add Gobject.Data.caml to store caml values in GtkTreeModels.
  * add signal emitting gtk_tree_model_row_changed

2004.02.15 [Olivier]
  * change type of gdk_drag_status: argument is drag_action option
    instead of drag_action list

2004.01.27 [Jacques]
  * add GWindow.dialog_any (for glade)
  * restructure dialog code

2004.01.21 [Olivier]
  * GtkColorButton and GtkFontButton (2.4)

2004.01.15 [Olivier]
  * add gtk_tree_view_column_set_cell_data_func
  * log error messages if ml_gtktree callbacks raise exceptions
  * fix the types of some callbacks in GtkTreeSortable
    and GtkTreeModelFilter

In lablgtk2-20040113:

2004.01.13 [Jacques]
  * revert to GWindow.window_skel/window
  * prepare snapshot

2004.01.08 [Olivier]
  * GtkTreeModel{Sort,Filter} fixes
  * added some missing GtkTreeModel methods
    (get_iter_first, iter_has_child, iter_n_children, flags, foreach)
  * in wrappers, added a function for converting a C flags value into
    a variant list (the reverse of the Make_Flags_val macro)

2004.01.04 [Olivier]
  * support for GtkEntryCompletion (2.4)

2003.12.21 [Olivier]
  * add event-after signal for widgets

2003.12.20 [Olivier]
  * make the comparison function use gtk_tree_path_compare
    for Gtk.tree_path values.

2003.12.19 [Olivier]
  * added support for GtkTreeSortable, GtkTreeModelSort
    and GtkTreeModelFilter (2.4)
  * fixes for GtkComboBox
  * GTree.view_column inherit from GTree.cell_layout,
    add a few methods to GTree.view_column

2003.12.17 [Jacques]
  * some additions/improvements to lablgladecc

2003.12.13 [Olivier]
  * More GTK 2.4 support:
    Action-based menus and toolbars
  * added GtkData.AccelGroup.parse

2003.12.10 [Olivier]
  * support for GTK 2.4 widgets:
    GtkComboBox, GtkExpander, GtkFileChooser

2003.11.30 [Olivier]
  * move event method of GRange.scrollbar in GRange.range (GtkScale
    widgets also receive events), removed GRange.scrollbar class
  * added event method in GTree.view, GRange.ruler

2003.10.30 [Jacques]
  * add GWindow.file_selection#dir_list  (Francois Pessaux)
  * move GBin.socket to GWindow.socket (this wasn't a bin)
  * add GWindow.plug_signals

2003.10.28 [Olivier]
  * make Panel.applet inherit GContainer.bin;
    remove the unit arg for getters

2003.10.20 [Jacques]
  * add bin class for #child

2003.10.13 [Olivier]
  * autoconf support for lablGL location

2003.10.09 [Olivier]
  * wrap GtkButton label property in button_skel

In lablgtk-2.2.0:

2003.10.10 [Jacques]
  * merge Makefile.nt into Makefile, check for msvc

2003.10.09 [Benjamin]
  * doc: correct GtkAjustement link to the right Gtk doc
  * doc: fix Makefile for doc (use of OCAML instead of CAMLC and mkdir ../doc/html)

2003.10.07 [Jacques]
  * add Gpointer.{peek,poke}_nativeint

2003.09.27 [Olivier]
  * remove `NONE response in dialogs
  * improved ocamldoc documentation
    (custom generator with links to
     GTK+ API reference)

2003.09.22 [Jacques] (request F.Pottier)
  * add window#maximize/fulscreen/stick
  * add GTree.row_reference and GTree.Path

2003.09.17 [Olivier]
  * GNOME libpanelapplet support. Now we can write panel applets in caml.

2003.09.11 [Olivier]
  * configure script prints a summary of the libraries that will be built.
  * in the output of pkg-config, filter out the options that
    ocamlmklib doesn't like.

2003.08.28 [Benjamin]
  * mnemonic support for all kind of menus. Defaults to true in factory.

2003.08.18 [Olivier]
  * wrap GtkNotebook::switch_page instead of change_current_page

2003.08.15 [Jacques]
  * split gtk.props in small pieces, to allow more generation

2003.08.06 [Olivier]
  * in GWindow: color_selection_dialog, file_selection and
    font_selection_dialog now inherit from GWindow.dialog

2003.08.05 [Olivier]
  * Added some libgnomeui bindings (Druids)
  * some new things in Gdkpixbuf :
      save, fill, subpixbuf, saturate_and_pixelate
      gdkpixbuf-specific errors

2003.07.18 [Benjamin]
  * New Glib.Unichar module

2003.07.17 [Benjamin]
  * Fix Win32 compilation

2003.07.09 [Jun Furuse]
  Improvements of lablgladecc:
  * Internal widgets are now also accessible by instance variables.
    The user can use simply widget names inside sub-class definitions,
    instead writing self#widget_name.
  * A flag -hide-default hides all the widget with default names
    come from glade, like label123.
  * Added check_all function to the output so that one can check
    all the widgets really exist.
  * reparent method is added to facilitate to embed one glade toplevel
    widget into a container.

2003.07.09 [Jacques]
  * ?width and ?height in GWindow back to setting size_request
    (default size did not work properly)
  * backward compatibility: GMisc.label has two exclusive parameters,
    ?text and ?markup (and no ?use_markup).

2003.07.07 [Benjamin]
  * Fixed confusion between text/label in a Label. Now GMisc.label expects
    ~label instead of ~text. This is consistant with the semantic of text and
    label properties (label may contain pango makups/text never do)


In lablgtk2-20030707:

2003.07.05 [Jacques]
  * #misc#set_geometry renamed in #misc#set_size_request
  * ?width and ?height in GWindow set default size rather than size request

2003.07.02 [Jacques]
  * fix configure (split PKG_CHECK_MODULES for GTK and GTKALL)
  * fix name of gtk_gl_area_swap_buffers

2003.06.24 [Benjamin]
  * Fix deps in Makefile
  * Fix generation of an incorrect lablgtk2 when debug is enabled
  * Fix Gtk 2.0 compatibility

2003.06.24 [Jacques]
  * finish going to generation, add missing signals
  * wrap clipboard and cell renderers
  * add GMain.init to avoid "open GMain"

2003.06.23 [Jacques]
  * Lots of changes: generate signals and externals too.

2003.06.19 [Jacques]
  * Add GData.clipboard.
  * Properties for GtkCellRenderer.
  * Towards canvas properties.

2003.06.18 [Jacques]
  * Massive change: generate properties automatically.
    Probable incompatibilities: inform immediately.

2003.06.17 [Benjamin]
  * Fix Gtk 2.0 compatibility

2003.06.16 [Benjamin]
  * Fix dependencies in Makefile. Now make -j works.
  * Add "world" target in Makefile.

2003.06.15 [Jacques]
  * Starting automatic generation of code. Should reduce need to write
    wrappers and externals manually.

2003.06.13 [Benjamin]
  * Experimental g_type_register_static: not to be used at this time

2003.06.11 [Jacques]
  * changes in object properties (GtkBase.Tables, ...)
  * add check_externals utility, fix some bugs
  * additions in GtkWindow.ml

2003.06.10 [Jacques]
  * changes in object properties (gobject.ml, gtkTree.ml)

2003.06.06 [Jacques]
  * new #misc#get_flag to get misc widget info
  * font_desc handling in Pango

2003.06.04 [Jacques]
  * GtkDialog cleanup
  * add applications/osiris (just started)

2003.05.29 [Jacques]
  * fixed GtkTree.TreeView.Properties.model
  * fixed ml_gobject.{get,set}_value to assume interfaces are objects

2003.05.26 [Jun Furuse]
  * msvc port is done!

2003.05.24 [Jun Furuse]
  * added Window.get_visual

2003.05.23 [Benjamin]
  * fixed incorrect type of trreview#connect#row_activated

2003.05.21 [Jun Furuse]
  * fixed a problem of SpinButton.get_value_as_int for the case of
    the value is minus' src/gtkEdit.ml

2003.05.14 [Benjamin]
 * Glib.Convert convert_with_fallback support

2003.05.12 [Benjamin]
 * GtkData.AccelMap support
 * GtkImageMenuItem support
 * MenuFactory accel_map support by default
 * GtkStock.Item.lookup support

2003.05.01 [Maxence]
 * srcdoc target added to generate HTML doc in src/doc/index.html
   (I did not test on Windows)

In lablgtk2-20030423:

2003.04.22 [Jacques]
 * GtkThread.thread_main automatically switches to gui thread.

2003.04.21 [Benjamin]
 * GRange.progress_bar updated. Old functions deprecated.

2003.04.12 [Olivier]
 * add GWindow.message_dialog, add methods in GWindow.dialog

2003.04.11 [Jun]
 * add GtkWindow.Window.resize and its C interface

2003.04.08 [Jacques]
 * lots of change in GtkTree*, add examples/tree_store.ml

2003.04.02 [Jacques]
 * finish? GtkTreeView

In lablgtk2-20030326:

2003.03.20 [Olivier]
 * add stocks and mnemonics for buttons
 * add icon factories

2003.03.19 [Jacques]
 * more property support (phantom type like for signals)

2003.03.18 [Jacques]
 * lots of GtkTree* additions
 * small changes in ml_glibc, gObj.ml

2003.03.17 [Benjamin]
 * Restore Variant and stretch properties in GtkText
 * GTK 2.0 fixes in GtkTree

2003.03.16 [Olivier]
 * GnomeCanvas: avoid duplicate properties type declaration

2003.03.15
 * changes in Gobject.Property and Gobject.Value.set
   (use set_boxed in ml_gobject.c for automatic copying)
 * adapt text and gnome-canvas (no need to build g_values)

In lablgtk2-beta:

2003.03.14
 * libgnomecanvas support [Olivier]
 * prepare for release, and fix makefiles [Jacques]

2003.03.13
 * Add Idle support

2003.02.26 [Benjamin]
 * Use mnemonics by default in factories

2003.02.25 [Benjamin]
 * GMenu new methods
 * Support for mnemonic in labels.
 * First patch to correct alloca problem in insert_text*

2003.02.25
 * copy_block_indirected allocates in old generation
 * disable compaction in gtkMain.ml
 * copy young strings to the stack when needed
 * free lists obtained from Gtk

2003.02.24
 * replace alloc_final by alloc_custom (wrapper.h)
 * better gtk-2.0 support (ml_gdk.c)

2003.02.21
 * Support for GTK 2.0 and librsvg 2.0 compilation (O. Andrieu) [Benjamin]


In lablgtk2-20030221:

2003.02.21
 * add GObj.misc_ops#set_size_chars
 * applications/browser only works with CVS version of ocaml
 * bug fixes

2003.02.20
 * additions to Pango [Jacques]
[Benjamin]:
 * added set_stock to GMisc.image
 * In GMisc.label_skel :
	added : #set_markup #set_markup_with_mnemonic #label
	changed : semantic of #text (returns text with markups and mnemonics)
		old semantic available with #label.
 * In GText.iter : add #language

2003.02.19
 * GdkDrawable is also a GObject
 * split GText.iter/nocopy_iter (Benjamin)
 * finish split (Jacques)

2003.02.14
 * Added librsvg support (contributed by Olivier Andrieu)
 * Ported applications/browser
 * GText.iter#forward/backward return self

2003.02.13
 * Starting to add GtkTreeView. See tree2.ml.

2003.02.12
 * API changes and bug fixes in GText (Jacques)

2003.02.11
 * API changes in GText (Jacques)
 * Many bug fix in GText (Benjamin)

In lablgtk2-20030210:

2003.02.10
 * merge trunk
 * Add gtkgl-2.0 and libglade-2.0 support

2003.01.22
 * Support for interaction between GtkTextBuffer and GtkClipboard. (Benjamin)
 * Support for search functions in GtkTextIter. (Benjamin)

2002.01.16
 * fix memory management in ml_gdk.h
 * GObject and GtkObject are different! fix gtk.ml

2002.01.15
  * added GtkAccelGroup and GtkClipboard support (Jacques)
  * suppress Gdk.Tags.selection (use Gdk.Atom.primary/secondary/clipboard)
  * time is 32-bit! (Benjamin)

In lablgtk2-alpha:

2002.12.26
  * lots of changes to adapt to gtk2
  * callback handling and property support completely rewritten
  * many API changes
  * new text widget interfaced by Benjamin Monate
  * Gtk2 automatically calls setlocale in gtk_init, but we
    revert LC_NUMERIC to C immediately after

In trunk:

2003.04.14
  * fix Glib.IO (Henri Dubois-Ferriere)

2003.01.22
  * GtkThread.main switches GtkMain.Main.main to call GtkThread.thread_main

2003.01.10
  * added GList.clist#get_row_state and GWindow.file_selection#file_list
    (by Francois Pessaux)

2002.11.18
  * added META (by Stefano Zacchiroli)
  * fixed applications/camlirc (Tim Freeman)

2002.10.31
  * add gdk_property_*

2002.10.26
  * fix GdkPixbuf.create_pixmap
  * add GdkEventClient (requested by Didier le Botlan)

2002.08.26
  * add Gdk.Window.get_pointer_location (Tim Freeman)

In lablgtk-1.2.5:

2002.08.19
  * add GWindow.toplevel (Tim Freeman report)

2002.08.09
  * Makefile and tictactoe patches (Tim Freeman)

2002.08.07
  * add GtkThread.sync and GtkThread.async to post calls to GTK from
    different threads on windows (GTK/win32 is not reentrant)

In lablgtk-1.2.4:

2002.07.15
  * add dll support to windows port

2002.07.13
  * install dlls to stublibs directory

2002.07.06
  * add g_io_add_watch support in GMain.Io (requested by Maxence)

2002.07.04
  * add rpm spec (Ben Martin)

2002.07.01
  * add GdkPixbuf support

2002.06.20
  * add all color settings in GtkData.Style/GObj.style
    (requested by N. Raynaud)
  * add GMain.Rc

2002.06.19
  * add Gpointer.region, to handle bigarray/string/Raw.t in an uniform way

2002.06.18
  * add Gdk.Rgb.draw_image (requested by F. Dellaert)

2002.05.30
  * change typing of GtkSignal.t

2002.05.28
  * move GtkData.Selection to GtkBase.Selection
  * add actual selection handling
  * add Gdk.Atom

2002.04.30
  * added button#set_relief, paned#pack1/pack2/set_position,
    Gdk.Window.set_cursor (requested by malc)

2002.02.25
  * add GtkPreview support (by Lauri Alanko)
  * add applications/camlirc (by Noabuaki Yoshida)

2002.01.25
  * correct ml_gtk_spin_button_set_update_policy
  * update Makefile for gtkxmhtml

In lablgtk-1.2.3:

2001.12.12
  * add GToolbox utility module (contributed by Maxence Guesdon)

2001.12.10
  * add Adjustment.set_bounds (Alan Schmitt)

2001.11.22
  * add parameters to handle_box and color_selection (Maxence Guesdon)

2001.11.01
  * adapt to ocaml 3.03a+2 dlls.

In lablgtk-1.2.2:

2001.10.09
  * GList.clist returns a monomorphic "string clist",
    use GList.clist_poly for a polymorphic clist.

2001.10.04
  * add Gdk.Window.get_colormap
  * change APIs in Gdk.Pixmap/Bitmap and GDraw.create_pixmap*
    (window parameter is not strictly necessary)

2001.09.13
  * improve dll-ization
  * add patch for unison-2.7.1

2001.09.06
  * merge strict labels
  * attempt dll-ization

In lablgtk-1.2.1:

2001.08.10
  * change ?nolocale to ?setlocale, defaulting to false.
    Setting the locale must be required explicitly, by setting
    the environment variable GTK_SETLOCALE for instance
  * release version 1.2.1

2001.07.04
  * add signals to GList.liste

2001.05.22
  * add ?nolocale parameter to Main.init (cf. ocaml PR#275)
  * remove Main.flush (enough to have it as Gdk.X.flush)
  * include [main] and [quit] in GMain, so you can now write GMain.main
    rather than GMain.Main.main
  * move glade examples to examples/glade

2001.05.18
  * add -trace flag to lablgladecc, to trace handler calls

2001.05.17
  * add GRange.ruler
  * improve lablgladecc, support all widgets
  * add -root and -embed flags to lablgladecc

2001.05.16
  * add lablgladecc, a libglade wrapper compiler

2001.04.16
  * clipping patch by Michael Welsh

2001.03.13
  * support GTK 1.2.3

2001.03.12
  * released 1.2.0
  * merged in variance annotations
  * added gears example by Eric Cooper

In lablgtk-1.2.0:

2001.02.27
  * add extractors to Gdk.Image
  * slight API change in GDraw.drawing#put_{image,pixmap}

2001.02.21
  * add size-allocate signal

2001.02.15
  * changed directory structure: sources moved to src/
  * updated Makefile.nt, made Win32 port work with gtk-1.3 of 2000-12-26
  * remove gutter_size in GtkPack.Paned, since it disappeared in 1.3

2001.02.13
  * relax some types in Gdk.Window, to allow all drawables
  * support for (dangerous?) callbacks in libglade

2001.02.10
  * added preliminary support for libglade

2000.12.20
  * add Filesection.complete (Sven Luther's patch)

2000.12.07
  * merge wakita's patch for gdk_draw_pixmap
    rename GDraw.drawable#image/pixmap to #put_image/put_pixma

2000.11.29
  * remove unison port, since unison already works with this snapshot

2000.11.16
  * internal change: switch from var2def/var2conv to varcc,
    and split ml_gtk.c in smaller files

2000.8.29
  * bugs in color selection reported by Nicolas George
  * changed the license

2000.8.21
  * correct GtkStyle.set_font bug reported by Patrick Doane

2000.7.27
  * changed GUtil.signal and GUtil.variable for better usability
  * suppressed obsolete color settings in tooltips

2000.6.19
  * patch by Michael Welsh for Gdk regions

2000.6.15
  * add CList.set_cell_style/set_row_style
  * change set_usize/set_uposition into set_geometry
  * return an option rather than raise an exception for null pointers
  * map empty strings to NULL when meaningful
  * Gdk.Font.get_type/ascent/descent

2000.6.14
  * add GDraw.optcolor for functions with a default (Jerome suggested)

2000.6.8
  * apply Jerome Vouillon's patch
  * changes in GtkSignal and GtkArgv.ml

2000.6.7
  * create #misc#connect for widget generic signals

2000.6.6
  * move notebook from GMisc to GPack
  * #connect#event, #add_event, #misc#event, #misc#set_events_extension
    transferred to #event su-bobject.
  * #connect#drag -> #drag#connect.
  * #get_type, #connect#disconnect, #connect#stop_emit transferred to #misc.

2000.5.25
  * split misc.ml into gaux.ml and gpointer.ml

2000.5.23
  * add GMisc.notebook#get_{tab,menu}_label. Rename nth_page to get_nth_page.
  * modified ML signals in GUtil, to allow signals without widget.

2000.5.22
  * Incompatible!: Change default for ~expand in Box.pack,
    Pack.build_options, Table.build_options. Now defaults to false/`NONE.
    This means that all options default to false/`NONE, except ~show
    (true for all widgets except windows) and ~fill (always true but
    effect controlled by ~expand).
  * add GtkArgv.get_nativeint and GtkArgv.set_nativeint.
  * make offset and length optional in GtkArgv.string_at_pointer.

2000.5.10
  * rename GtkFrame to GtkBin and GFrame to GBin
  * move socket to GBin

2000.5.9
  * add arrow and image classes to GMisc
  * add list and set_item_string methods to GEdit.combo
  * add socket and plug classes to GContainer and GWindow
  * two new examples: combo.ml and socket.ml

2000.4.28
  * add GUtil.variable

2000.4.27
  * add GtkXmHTML widget

In lablgtk-1.00:

2000.4.24
  * merge in changes for ocaml 3.00: label and syntax changes, autolink
  * added better visual and colormap handling to Gdk
  * GdkObj renamed to GDraw, GtkPixmap moved to GMisc
  * Initialize Gtk in gtkInit.cmo/cmx, start a thread in gtkInitThread.cmo.
    These are only included in toplevels, link them explicitely or call
    GMain.Main.init and GtkThread.start otherwise.
  * install to caml standard library
  * many other forgotten changes...

2000.3.02
  * move locale setting inside GtkMain.init, since it requires an
    X display

2000.2.24
  * add checks in add methods, to avoid critical errors

2000.2.23
  * add dcalendar.ml (submitted by Ken Wakita) and csview.ml
  * correct bug in GdkObj.pixmap#line

1999.12.19
  * release lablGTK beta2

1999.12.16
  * upgraded unison to version 1.169
  * radio groups are of type {radio_menu_item,radio_button} obj option,
    otherwise you could not use them several times

1999.12.13
  * added GtkEdit::{insert_text,delete_text} signals
  * better syntax highlighting and ergonomy in the browser's shell

1999.11...
  * switched to Objective Caml 3
  * constructors are no longer classes, but simple functions

1999.10.29
  * changed GtkArgv.get_{string,pointer,object} to return option types

1999.10.27
  * added radtest/CHANGES for cooperative editing on radtest

1999.10.21
  * added a UI for unison
    (ask bcpierce@saul.cis.upenn.edu about how to get unison)

1999.10.20
  * corrected CList signals
  * moved initialization out of the library, in gtkInit.cmo

1999.10.15
  * release lablGTK beta1

1999.10.13
  * improved gtkThread.ml (no timer)
  * modify Sys.argv in place (gtkMain.ml)
  * add set_row_data and get_row_data for GtkCList

1999.10.11
  * bugfixes in Makefile, radtest and lv

1999.10.6
  * added Gdk.X.flush and Gdk.X.beep
  * Gdk.X.flush is exported in GtkMain.Main

1999.9.9
  * added font selection dialog

1999.8.25
  * re-added connect#draw

1999.8.10
  * reduced the number of methods in widget
  * moved disconnect and stop_emit to object_signals
  * moved ?:after to each signal
  * more functions in applications/browser

1999.8.9
  * Major change: created one set_param method by parameter,
    rather than grouping them and using options.
    You can get previous versions with tag "changing_set"
  * corrected examples, radtest and browser for these changes
  * a bit of clean-up in radtest (treew.ml and Makefile)

1999.8.5
  * corrected a bad bug with indirected pointers in caml heap

1999.7.15
  * add GdkKeysyms for exotic keysyms

1999.7.14
  * moved Truecolor inside Gdk
  * added COPYING
  * prepared for release

1999.7.12
  * clean up drag-and-drop

1999.7.9
  * corrected bug in Container.children
  * added ML signal support in GUtil

1999.7.6
  * added DnD, improved radtest (Hubert)
  * small corrections (Jacques)

1999.7.1
  * added some gdk functions related window and ximage
  * also added applications/lv, "labl image viewer" with
    the camlimage library.
  (JPF)

1999.7.1
  * added applications/lablglade (Koji)

1999.6.28
  * added applications/radtest (Hubert)

1999.6.23
  * improved variant conversions for space.

1999.6.22
  * updated olabl.patch. With this new version you can access fields
    of records without opening modules.  You can also use several times
    the same label in one module.
  * examples/GL/morph3d.ml uses it.

1999.6.21
  * moved event functions to GdkEvent

1999.6.20
  * new example: radtest.ml (Hubert)

1999.6.18
  * added GL extension

1999.6.15
  * grouped set methods into set_<keyword>
  * added width and height option to all classes
  * windows not shown are automatically destroyed by the GC

1999.6.14
  * added GPack.layout, GPack.packer, GPack.paned, GMisc.notebook,
    GRange.scale, GMisc.calendar
  * added 3 examples
  * #add_events only available on windowed widgets

1999.6.11
  * added CList widget in GList module, and examples/clist.ml
  * improved pixmap abstraction in GdkObj / GPix

1999.6.10
  * suppressed almost all raw pointers from the code. Pointers are now
    either boxed (second field of an abstract block) or marked (lowest
    bit set to 1).

1999.6.9
  * added GtkBase.Object.get_id and GObj.gtkobj#get_id to get an
    unique identifier to gtk objects. Nice for hash-tables, etc...
  * GUtil.memo is such an hash-table, allowing you to recover an
    object's wrapper.
  * added a show option to all classes, commanding whether the widget
    should be shown immediately.  It is by default true on all widgets
    except in module GWindow.
  * moved non-OO examples to examples/old. Do "cvs update -d old" to
    get them.
  * changes in Gdk/GtkData/GObj about styles.

1999.6.8
  * updated olabl.patch

1999.6.7
  * split gtk.ml into gtk*.ml

1999.6.5
  * grouped Container focus operations in a "focus" subwidget

1999.6.4
  * slightly reorganized widget grouping

1999.6.3
  * disabled gtk_caller
  * subtle hack to have GTree get the right interface
  * switched completely to the new widget scheme (including examples)
  * added olabl.patch to apply to olabl-2.02 to compile new sources

1999.6.2
  * integrated changes from Hubert in Gtk, GtkObj and testgtk.ml
  * added G* modules to replace GtkObj. "make lablgtk2" for it

1999.6.1
  * added experimental GtkMenu for a cleaner approach to OO (Jacques)

1999.5.31
  * GtkObj: list, tree and menu_shell inherit from item_container (Jacques)
  * Argv.get_{string,pointer,object} may raise Null_pointer (Jacques)
  * Support for creating new widgets (Hubert)

1999.5.28
  * a few stylistic corrections
  * added Packer in gtk.ml

1999.5.27
  * new Gtk.Main.main Gtk.Main.quit and GtkThread.main (for modal windows)
  * added x: and y: to Window.setter
  * new methods: object#get_type widget#misc#lock_accelerators
    widget#misc#visible widget#misc#parent container#set_focus#vadjustment
    container#set_focus#hadjustment (could be container#set_focus#adjustment with a dir param)
    window#set_modal window#set_position window#set_default_size
    window#set_transient_for
    menu#set_accel_group
  * new classes: handle_box_skel handle_box_signals handle_box
    bbox color_selection color_selection_dialog toolbar
    and the corresponding modules in gtk.ml
    new class type: is_window and method as_window
  * new param tearoff: in new_menu_item
    new param x: and y: modal: in Window.setter
  * Widget.event and Widget.activate return bool
  * new example: examples/testgtk.ml and test.xpm
  (Hubert)

1999.5.25
  * upgraded to gtk+-1.2.3 (all examples work)
  * suppressed deprecated function calls and corrected examples
  * added a patch to use toplevel threads in olabl-2.02

1998.12.13
  * upgraded to olabl-2.01

1998.12.9
  * replicated Main, Timeout and Grab to GtkObj (no need to open Gtk anymore)
  * moved some non standard classes to GtkExt

1998.12.8
  * added the first application, xxaplay, Playstation audio track
    player for linux. (How architecture specific!) (Furuse)

1998.12.8
  * more widgets in GtkObj
  * refined memory management
  * all variants in upper case

1998.12.7
  * after deeper thought, re-introduced the connect sub-object
  * simplified GtkObj: use simple inheritance and allow easy subtyping
  * updated olabl.diffs for bugs in class functions parsing and printing
  * add ThreadObj for concurrent object programming
  (Jacques)

1998.12.3
  * pousse.ml is now a reversi game (idea for strategy ?)
  * solved startup bug (a value checker for ocaml is now available)
  (Jacques)

1998.12.2
  * added GdkObj for high level drawing primitives (Jacques)

1998.11.30
  * removed cast checking for NULL valued widgets (ml_gtk.[ch])
  * module Arg is renamed as GtkArg because of the name corrision with
	the module Arg in the standard library
  * Makefile : native code compilation added
  (Furuse)

1998.11.29
  * renamed widget_ops sub-object to misc
  * various improvements of set functions
  (Jacques)

1998.11.28
  * switched to object-oriented model. GtkObj is now the standard way
    to access the library, but not all objects are ready (see README)
  * removed inheritance in gtk.ml
  (Jacques)

1998.11.24
  * added inheritance in gtk.ml

1998.11.22
  * added gtkObj.ml and examples/*_obj.ml
  * various modifications in gtk.ml
