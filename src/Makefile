# $Id$
# Makefile for lablgtk.

all: var2conv var2def lablgtk

opt: lablgtkopt

configure:
	@rm -f config.make .depend
	@$(MAKE) nothing > /dev/null 2> /dev/null

nothing:

COMPILER = olablc $(MLFLAGS) -c
LINKER = olablc $(MLFLAGS)
COMPOPT = olablopt $(MLFLAGS) -c
LINKOPT = olablopt $(MLFLAGS)

TOPLEVEL = olablmktop $(MLFLAGS)
RANLIB = ranlib

include config.make

CFLAGS = -g $(GTKCFLAGS) #-DGTK_NO_CHECK_CASTS
LDFLAGS = $(GTKLIBS)

THFLAGS = -thread
THLIBS = unix.cma threads.cma
THLDFLAGS = -lthreads -lunix

ifdef USE_CC
CCOMPILER = $(CC) -c -I/usr/local/lib/olabl -DGTK_NO_CHECK_CASTS $(CFLAGS)
else
CCOMPILER = olablc -c -ccopt "$(CFLAGS)"
endif

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.c.o:
	$(CCOMPILER) $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<
.var.h:
	./var2def < $< > $@
.var.c:
	./var2conv < $< > $@

# Targets
COBJS = ml_gtk.o ml_gdk.o ml_glib.o ml_gtkcaller.o wrappers.o
MLOBJS = misc.cmo glib.cmo gdk.cmo gtk.cmo gtkObj.cmo gdkObj.cmo

lablgtk: liblablgtk.a lablgtk.cma
	$(TOPLEVEL) -o $@ -custom -cclib "-L. -llablgtk $(LDFLAGS)" lablgtk.cma

lablgtkopt: liblablgtk.a lablgtk.cmxa

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@

lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -o $@ $(MLOBJS)

lablgtk.cmxa: $(MLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(MLOBJS:.cmo=.cmx)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

gtkThread.cmx: gtkThread.ml
	$(COMPOPT) $(THFLAGS) gtkThread.ml

lablgtk_t: liblablgtk.a lablgtk.cma gtkThread.cmo
	$(TOPLEVEL) $(THFLAGS) -o $@ -custom \
		-cclib "-L. -llablgtk $(LDFLAGS) $(THLDFLAGS)" \
		$(THLIBS) lablgtk.cma gtkThread.cmo

var2conv: var2conv.cmo
	olablc -o $@ var2conv.cmo

var2def: var2def.cmo
	olablc -o $@ var2def.cmo

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] var2conv var2def lablgtk

.depend:
	olabldep *.ml *.mli > .depend

config.make:
	echo GTKCFLAGS=`gtk-config --cflags` > config.make
	echo GTKLIBS=`gtk-config --libs` >> config.make

ml_gtk.o: gtk_tags.c gtk_tags.h ml_gtk.h ml_gdk.h wrappers.h ml_gtkcaller.h
ml_gdk.o: gdk_tags.c gdk_tags.h ml_gdk.h wrappers.h

include .depend
