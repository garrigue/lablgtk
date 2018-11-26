; Enums
(rule
 (targets glib_tags.h glib_tags.c)
 (action (run ./varcc.exe %{dep:glib_tags.var})))

(rule
 (targets gdk_tags.h gdk_tags.c gdkEnums.ml)
 (action (run ./varcc.exe %{dep:gdk_tags.var})))

(rule
 (targets gdkpixbuf_tags.h gdkpixbuf_tags.c)
 (action (run ./varcc.exe %{dep:gdkpixbuf_tags.var})))

(rule
 (targets gobject_tags.h gobject_tags.c)
 (action (run ./varcc.exe %{dep:gobject_tags.var})))

(rule
 (targets gtk_tags.h gtk_tags.c gtkEnums.ml)
 (action (run ./varcc.exe %{dep:gtk_tags.var})))

(rule
 (targets pango_tags.h pango_tags.c pangoEnums.ml)
 (action (run ./varcc.exe %{dep:pango_tags.var})))

(rule
 (targets sourceView2_tags.h sourceView2_tags.c sourceView2Enums.ml)
 (action (run ./varcc.exe %{dep:sourceView2_tags.var})))

(rule
 (targets gtkgl_tags.h gtkgl_tags.c)
 (action (run ./varcc.exe %{dep:gtkgl_tags.var})))

(rule
 (targets gnomeui_tags.h gnomeui_tags.c)
 (action (run ./varcc.exe %{dep:gnomeui_tags.var})))
