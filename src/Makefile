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

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS) -lcamlrund
MLFLAGS = -g
else
CFLAGS = -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
LDFLAGS = $(GTKLIBS)
endif

THFLAGS = -thread
THLIBS = unix.cma threads.cma
THLDFLAGS = -lthreads -lunix

ifdef USE_CC
CCOMPILER = $(CC) -c -I/usr/local/lib/olabl $(CFLAGS)
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
COBJS = ml_gtk.o ml_gdk.o ml_glib.o wrappers.o
OLDMLOBJS = misc.cmo glib.cmo gdk.cmo gtk.cmo gdkObj.cmo gtkObj.cmo gtkExt.cmo
MLOBJS = misc.cmo glib.cmo gdk.cmo gtk.cmo gdkObj.cmo gUtil.cmo \
	gObj.cmo gMain.cmo gData.cmo gCont.cmo gPack.cmo gButton.cmo \
	gMenu.cmo gWin.cmo gTree.cmo gMisc.cmo gDialog.cmo gList.cmo \
	gEdit.cmo gPix.cmo gRange.cmo
THOBJS = gtkThread.cmo threadObj.cmo

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

threadObj.cmo: threadObj.ml
	$(COMPILER) $(THFLAGS) threadObj.ml

gtkThread.cmx: gtkThread.ml
	$(COMPOPT) $(THFLAGS) gtkThread.ml

threadObj.cmx: threadObj.ml
	$(COMPOPT) $(THFLAGS) threadObj.ml

lablgtk_t: liblablgtk.a lablgtk.cma $(THOBJS)
	$(TOPLEVEL) $(THFLAGS) -o $@ -custom \
		-cclib "-L. -llablgtk $(LDFLAGS) $(THLDFLAGS)" \
		$(THLIBS) lablgtk.cma $(THOBJS)

var2conv: var2conv.cmo
	$(LINKER) -o $@ var2conv.cmo

var2def: var2def.cmo
	$(LINKER) -o $@ var2def.cmo

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
