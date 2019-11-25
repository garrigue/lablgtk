; Enums
(rule
 (targets gobject_tags.h gobject_tags.c)
 (action (run varcc %{dep:gobject_tags.var})))

(rule
 (targets glib_tags.h glib_tags.c)
 (action (run varcc %{dep:glib_tags.var})))

(rule
 (targets gdk_tags.h gdk_tags.c gdkEnums.ml)
 (action (run varcc %{dep:gdk_tags.var})))

(rule
 (targets gtk_tags.h gtk_tags.c gtkEnums.ml)
 (action (run varcc %{dep:gtk_tags.var})))

(rule
 (targets pango_tags.h pango_tags.c pangoEnums.ml)
 (action (run varcc %{dep:pango_tags.var})))

(rule
 (targets gdkpixbuf_tags.h gdkpixbuf_tags.c)
 (action (run varcc %{dep:gdkpixbuf_tags.var})))
