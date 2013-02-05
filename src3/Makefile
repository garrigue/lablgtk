# Makefile for lablgtk.

COMPILER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS) -annot -I . -I stubs -w s -c
LINKER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -annot -w s -c -I stubs
LINKOPT = $(CAMLOPT) $(MLFLAGS)
LIBRARIAN = $(CAMLMKLIB) -verbose -ocamlc "$(CAMLC)" -ocamlopt "$(CAMLOPT)"
TOPLEVEL = $(CAMLMKTOP) $(MLFLAGS)
CAMLP4 = $(CAMLP4O) pr_o.cmo

GIRDIR=/usr/share/gir-1.0
EXTRACT_STUBS=../tools/extract_stubs$(XE)

CONFIG = ../config.make

# protect against missing definitions
BINDIR = ""
LIBDIR = ""
INSTALLDIR = $(LIBDIR)/lablgtk3
DLLDIR = $(LIBDIR)/stublibs

include $(CONFIG)

# redefine GTK variables using GTK3 variables from configuration
GTKCFLAGS=$(GTK3CFLAGS)
GTKLIBS=$(GTK3LIBS)
USE_GL=$(USE_GTKGL3)
USE_GLADE=$(USE_GLADE3)
# to complete when configuration will handle these:
USE_RSVG=
HAVE_SVGZ=
USE_GNOMECANVAS=
USE_GNOMEUI=
USE_PANEL=
USE_GTKSPELL=
USE_GTKSOURCEVIEW=
USE_GTKSOURCEVIEW2=
USE_GTKQUARTZ=


TARGETS = lablgtktop$(XE)

# Targets

all: byte opt
world: byte $(CAMLBEST)

byte: lablgtk.cma
opt:  lablgtk.cmxa # lablgtkopt

stubs: $(EXTRACT_STUBS)
	mkdir -p stubs
	$(EXTRACT_STUBS)  --outdir stubs --datadir data $(GIRDIR)/Gtk-3.0.gir > LOG
	sed -i "s/intern()/g_variant_get_type/g" stubs/ml_stubs_GLib.c

$(EXTRACT_STUBS):
	cd ../tools && $(MAKE) extract_stubs$(XE)

MLLIBS = lablgtk.cma
CLIBS = liblablgtk3$(XA)
#MLLINK = unix.cma str.cma

# For -DG_LOG_DOMAIN=\"LablGTK\"
ifneq ($(TOOLCHAIN),msvc)
GTKCFLAGS += -imacros ml_domain.h
else
GTKCFLAGS += /FI ml_domain.h
endif

# compile using a custom version of mlvalues.h, where value is abstract
ifdef ABSVALUE
GTKCFLAGS += -Iabsvalue -DABSVALUE
endif

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
CUSTOM = -custom
#MLLINK += -cclib -lcamlrund
MLBYTEFLAGS = -g -dtypes
else
CFLAGS = -DG_DISABLE_ASSERT -DG_DISABLE_CAST_CHECKS $(GTKCFLAGS)
ifneq ($(TOOLCHAIN),msvc)
CFLAGS += -O
endif
endif

ifeq ($(THREADS_LIB),system)
THFLAGS = -thread
else
THFLAGS = -vmthread
CUSTOM = -custom
endif
THLINK = unix.cma threads.cma

ifdef USE_CC
CCOMPILER = $(CC) -c -I"$(LIBDIR)" $(CFLAGS)
else
CCOMPILER = $(CAMLC) -c -ccopt '$(CFLAGS)' -verbose
endif


ifdef USE_GTKQUARTZ
CFLAGS += -DHAS_GTKQUARTZ
endif

STUBCOBJS= \
	stubs/mltags_Atk$(XO) \
	stubs/mltags_GLib$(XO) \
	stubs/mltags_Gdk$(XO) \
	stubs/mltags_GdkPixbuf$(XO) \
	stubs/mltags_GObject$(XO) \
	stubs/mltags_GModule$(XO) \
	stubs/mltags_Gio$(XO) \
	stubs/mltags_Pango$(XO) \
	stubs/mltags_Gtk$(XO) \
	stubs/ml_stubs_Gtk$(XO) \
	stubs/ml_stubs_GLib$(XO) \
#	stubs/mltags_cairo$(XO) \
#	stubs/mltags_xlib$(XO) \
#	stubs/ml_stubs_Atk.o \
#	stubs/ml_stubs_GModule.o \
#	stubs/ml_stubs_GObject.o \
#	stubs/ml_stubs_Gdk.o \
#	stubs/ml_stubs_Gio.o \

#	stubs/ml_stubs_xlib.o \
#	stubs/ml_stubs_Pango.o \
#	stubs/ml_stubs_cairo.o \
#	stubs/ml_stubs_GdkPixbuf.o \

STUBMLOBJS= \
	stubs/tags_GLib.cmo \
	stubs/tags_Atk.cmo \
	stubs/tags_Gdk.cmo \
	stubs/tags_GdkPixbuf.cmo \
	stubs/tags_GObject.cmo \
	stubs/tags_GModule.cmo \
	stubs/tags_Gio.cmo \
	stubs/tags_Pango.cmo \
	stubs/tags_cairo.cmo \
	stubs/tags_xlib.cmo \
	stubs/tags_Gtk.cmo \
	stubs/stubs_GLib.cmo \
	stubs/stubs_Gtk.cmo \

#	stubs/stubs_Atk.cmo \
#	stubs/stubs_GModule.cmo \
#	stubs/stubs_GObject.cmo \
#	stubs/stubs_Gdk.cmo \
#	stubs/stubs_GdkPixbuf.cmo \
#	stubs/stubs_Gio.cmo \
#	stubs/stubs_Pango.cmo \
#	stubs/stubs_cairo.cmo \
#	stubs/stubs_xlib.cmo

COBJS= \
	ml_gobject$(XO) \
	ml_gpointer$(XO) \
	ml_gvaluecaml$(XO) \
	wrappers$(XO) \
	$(STUBCOBJS)

MLOBJS= \
	gaux.cmo \
	gpointer.cmo \
	gobject.cmo \
	gtk.cmo \
	gtkWidget.cmo \
	gtkSignal.cmo \
	$(STUBMLOBJS)


# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .cmxs .cmxa .c $(XO) .d$(XO) .var .h .opt .def .ml4
.c$(XO):
	$(CCOMPILER) -I . $<
stubs/%$(XO): stubs/%.c
	(cd stubs && $(CCOMPILER) -I .. `basename $<` 2>&1 | grep -v "is deprecated")
.cpp$(XO):
	$(CCOMPILER) $<
.c.d$(XO):
	$(CAMLC) -c -ccopt '-MT -DCAML_DLL -Fo$@ $(CFLAGS)' $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<
.ml4.cmo:
	$(CAMLC) -c -pp "$(CAMLP4O) -impl" -impl $<
.cmxa.cmxs:
	$(CAMLOPT) -verbose -o $@ -shared -linkall -I . \
        -ccopt '$(filter -L%, $(DYNLINKLIBS))' $<

lablgtk.cma liblablgtk3$(XA): $(COBJS) $(MLOBJS)
	$(LIBRARIAN) -o lablgtk -oc lablgtk3 $^ $(GTKLIBS)
lablgtk.cmxa: $(COBJS) $(MLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtk -oc lablgtk3 $^ $(GTKLIBS)
lablgtk.cmxs: DYNLINKLIBS=$(GTK_LIBS)

# Bulding C

varcc$(XE): varcc.cmo
	$(LINKER) -o $@ $<
	rm -f *_tags.h *_tags.c

varcc.cmo: varcc.ml4

%_tags.h %_tags.c %Enums.ml: %_tags.var varcc$(XE)
	./varcc$(XE) $<

ml_gobject$(XO): gobject_tags.h  ml_gvaluecaml.h wrappers.h

# building tests programs

tests:
	cd tests && $(MAKE)

# cleaning

clean:
	rm -f *.cm* *.a *.so *.o *.exe *.obj *.dll *.lib *.gch
	(cd stubs && rm -f *.cm* *.a *.so *.o *.obj)
	rm -f varcc$(XE) *_tags.[ch]
	rm -f  \#*\# *~

.PHONY: stubs tests

include .depend
