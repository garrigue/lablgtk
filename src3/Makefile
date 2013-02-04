# Makefile for lablgtk.

COMPILER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS) -w s -c
LINKER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -c
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

all: byte
world: byte $(CAMLBEST)

byte:: lablgtk.cma
opt::  lablgtk.cmxa # lablgtkopt

stubs: $(EXTRACT_STUBS)
	mkdir -p stubs
	$(EXTRACT_STUBS)  --outdir stubs --datadir data $(GIRDIR)/Gtk-3.0.gir > LOG

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

GTKOBJS=
COBJS= \
	ml_gobject$(XO) \
	ml_gpointer$(XO) \
	ml_gvaluecaml$(XO) \
	wrappers$(XO) \
	$(GTKOBJS)

MLOBJS=


# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .cmxs .cmxa .c $(XO) .d$(XO) .var .h .opt .def .ml4
.c$(XO):
	$(CCOMPILER) $<
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


clean:
	rm -f *.cm* *.a *.so *.o *.exe *.obj *.dll *.lib *.gch
	rm -f varcc$(XE) *_tags.[ch]
	rm -f  \#*\# *~

.PHONY: stubs

include .depend
