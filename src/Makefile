# $Id$
# Makefile for lablgtk.

TARGETS = varcc lablgtktop lablgtktop_t lablgtkrun lablgtk

COMPILER = $(CAMLC) $(MLFLAGS) -w s -labels -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -labels -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)
TOPLEVEL = ocamlmktop $(MLFLAGS)
CONFIG = ../config.make

include $(CONFIG)

LABLGLDIR = +lablGL

MLLIBS = lablgtk.cma
CLIBS = liblablgtk.a
MLLINK = unix.cma str.cma

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
MLLINK += -cclib -lcamlrund
MLFLAGS = -g
else
CFLAGS = -O -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
endif

THFLAGS = -thread
THLINK = unix.cma threads.cma

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LIBDIR) $(CFLAGS)
else
CCOMPILER = ocamlc -c -ccopt "$(CFLAGS)"
endif

ifdef USE_GL
MLFLAGS += -I $(LABLGLDIR)
MLLINK += lablgl.cma
MLLIBS += lablgtkgl.cma
CLIBS += liblablgtkgl.a
GLLINK = -cclib -llablgtkgl -cclib -lgtkgl
GLMLOBJS = glGtk.cmo
GLCOBJS = ml_gtkgl.o
endif

ifdef USE_GNOME
MLLIBS += lablgnome.cma
CLIBS += liblablgnome.a
GNOMEMLOBJS = gtkXmHTML.cmo gHtml.cmo
GNOMECOBJS = ml_gtkxmhtml.o
endif

ifdef USE_GLADE
MLLIBS += lablglade.cma
CLIBS += liblablglade.a
GLADEMLOBJS = glade.cmo
GLADECOBJS = ml_glade.o
TARGETS += lablgladecc
endif

# Main targets

all: $(TARGETS)

opt: lablgtkopt

depend:
	ocamldep *.ml *.mli > .depend

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
	./varcc $<

# Targets
GTKOBJS = ml_gtk.o ml_gtkbin.o ml_gtkbutton.o ml_gtkedit.o ml_gtklist.o \
	ml_gtkmenu.o ml_gtkmisc.o ml_gtknew.o ml_gtkpack.o ml_gtkrange.o \
	ml_gtktree.o
COBJS = ml_gdk.o ml_glib.o wrappers.o $(GTKOBJS)
MLOBJS = gaux.cmo gpointer.cmo glib.cmo gdk.cmo gdkEvent.cmo gdkKeysyms.cmo \
	gtk.cmo gtkArgv.cmo gtkSignal.cmo \
	gtkData.cmo gtkBase.cmo gtkPack.cmo gtkButton.cmo \
	gtkMenu.cmo gtkMisc.cmo gtkWindow.cmo gtkTree.cmo gtkList.cmo \
	gtkBin.cmo gtkEdit.cmo gtkRange.cmo gtkMain.cmo gtkNew.cmo \
	gDraw.cmo \
	gObj.cmo gMain.cmo gData.cmo gContainer.cmo gPack.cmo gButton.cmo \
	gMenu.cmo gMisc.cmo gWindow.cmo gTree.cmo gList.cmo gBin.cmo \
	gEdit.cmo gRange.cmo gUtil.cmo
THOBJS = gtkThread.cmo
INITOBJS = gtkInit.cmo
THINITOBJS = gtkThInit.cmo
ALLOBJS = $(MLOBJS) $(GLMLOBJS) $(GNOMEMLOBJS) $(GLADEMLOBJS) $(INITOBJS)
ALLTHOBJS = $(THOBJS) $(THINITOBJS)

lablgtktop: $(CLIBS) $(MLLIBS) $(INITOBJS)
	$(TOPLEVEL) -o $@ $(MLLINK) -ccopt -L. $(MLLIBS) $(INITOBJS)

lablgtktop_t: $(CLIBS) $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS)
	$(TOPLEVEL) $(THFLAGS) -o $@ $(THLINK) $(MLLINK) \
	   -ccopt -L. $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS)

lablgtk: Makefile $(CONFIG) lablgtk.in
	sed -e "s|@INSTALLDIR@|$(INSTALLDIR)|g" \
	    -e "s|@LABLGLDIR@|$(LABLGLDIR)|g" \
	    -e "s|@LIBDIR@|$(LIBDIR)|g" \
	    < lablgtk.in > $@
	chmod 755 $@

lablgtkrun: $(CLIBS) $(MLLIBS)
	$(LINKER) -o $@ -make-runtime $(MLLINK) -ccopt -L. $(MLLIBS)

lablgtkopt: $(CLIBS) $(MLLIBS:.cma=.cmxa) $(INITOBJS:.cmo=.cmx) \
	$(THOBJS:.cmo=.cmx)

lablgladecc: xml_lexer.cmo lablgladecc.cmo
	$(LINKER) -o $@ $(MLLINK) xml_lexer.cmo lablgladecc.cmo

testcc: lablgladecc lablgtktop
	./lablgladecc -test > testcc.ml
	./lablgtktop testcc.ml
	rm -f testcc.ml

install:
	if test -d $(INSTALLDIR); then : ; else mkdir -p $(INSTALLDIR); fi
	cp $(ALLOBJS:.cmo=.cmi) $(THOBJS:.cmo=.cmi) $(INSTALLDIR)
	cp -p *.mli $(INSTALLDIR)
	cp -p $(ALLOBJS:.cmo=.ml) $(ALLTHOBJS:.cmo=.ml) $(INSTALLDIR)
	cp $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS) $(INSTALLDIR)
	cp $(CLIBS) $(INSTALLDIR)
	cp lablgtktop lablgtktop_t varcc $(INSTALLDIR)
	cp -p *.h $(INSTALLDIR)
	cp lablgtk lablgtkrun $(BINDIR)
	if test -f lablgladecc; then cp lablgladecc $(BINDIR); fi
	if test -f lablgtk.cmxa; then $(MAKE) installopt; fi

installopt:
	cp $(MLLIBS:.cma=.cmxa) $(MLLIBS:.cma=.a) $(INSTALLDIR)
	cp $(ALLOBJS:.cmo=.cmx) $(INSTALLDIR)
	cp $(INITOBJS:.cmo=.o) $(INSTALLDIR)
	if test -f gtkThread.cmx; then \
	   cp $(THOBJS:.cmo=.cmx) $(THOBJS:.cmo=.o) $(INSTALLDIR); fi

liblablgtk.a: $(COBJS)
	ar rc $@ $(COBJS)
	$(RANLIB) $@
lablgtk.cma: $(MLOBJS)
	$(LINKER) -a -custom -o $@ $(MLOBJS) \
	  -cclib -llablgtk $(GTKLIBS)
lablgtk.cmxa: $(MLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(MLOBJS:.cmo=.cmx) \
	  -cclib -llablgtk $(GTKLIBS)

liblablgtkgl.a: $(GLCOBJS)
	ar rc $@ $(GLCOBJS)
	$(RANLIB) $@
lablgtkgl.cma: $(GLMLOBJS)
	$(LINKER) -a -custom -o $@ $(GLLINK) $(GLMLOBJS)
lablgtkgl.cmxa: $(GLMLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(GLLINK) $(GLMLOBJS:.cmo=.cmx)

liblablgnome.a: $(GNOMECOBJS)
	ar rc $@ $(GNOMECOBJS)
	$(RANLIB) $@
lablgnome.cma: $(GNOMEMLOBJS)
	$(LINKER) -a -custom -o $@ $(GNOMEMLOBJS) \
	  -cclib -llablgnome $(GNOMELIBS)
lablgnome.cmxa: $(GNOMEMLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(GNOMEMLOBJS:.cmo=.cmx) \
	  -cclib -llablgnome $(GNOMELIBS)

liblablglade.a: $(GLADECOBJS)
	ar rc $@ $(GLADECOBJS)
	$(RANLIB) $@
lablglade.cma: $(GLADEMLOBJS)
	$(LINKER) -a -custom -o $@ $(GLADEMLOBJS) \
	  -cclib -llablglade $(GLADELIBS)
lablglade.cmxa: $(GLADEMLOBJS:.cmo=.cmx)
	$(LINKOPT) -a -o $@ $(GLADEMLOBJS:.cmo=.cmx) \
	  -cclib -llablglade $(GLADELIBS)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

gtkThread.cmx: gtkThread.ml
	if test -f $(LIBDIR)/libthreadsnat.a; then \
	   $(COMPOPT) $(THFLAGS) gtkThread.ml; fi

xml_lexer.ml: xml_lexer.mll
	ocamllex xml_lexer.mll

varcc: varcc.cmo
	$(LINKER) -o $@ varcc.cmo
	rm -f *_tags.h *_tags.c

clean:
	rm -f *.cm* *.o *.a *_tags.[ch] $(TARGETS)

$(GTKOBJS): gtk_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gdk.o: gdk_tags.h ml_gdk.h wrappers.h
ml_gtkgl.o: gtkgl_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gtkxmhtml.o: gtkxmhtml_tags.h ml_gtk.h ml_gdk.h wrappers.h

include .depend
