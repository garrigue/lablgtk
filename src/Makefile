# $Id$
# Makefile for lablgtk.

COMPILER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS) -w s -c
LINKER = $(CAMLC) $(MLFLAGS) $(MLBYTEFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -w s -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)
LIBRARIAN = $(CAMLMKLIB) -verbose
TOPLEVEL = $(CAMLMKTOP) $(MLFLAGS)
CAMLP4 = $(CAMLP4O) pr_o.cmo
CONFIG = ../config.make

# protect against missing definitions
BINDIR = ""
LIBDIR = ""
INSTALLDIR = $(LIBDIR)/lablgtk2
DLLDIR = $(LIBDIR)/stublibs

include $(CONFIG)

TARGETS = varcc lablgtktop lablgtk2 lablgladecc

all: byte

world: byte $(OCAMLBEST)

byte: $(TARGETS)
opt:  $(TARGETS) lablgtkopt

LABLGLDIR = $(LIBDIR)/lablGL

MLLIBS = lablgtk.cma
CLIBS = liblablgtk2.a
#MLLINK = unix.cma str.cma

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
MLLINK = -custom
#MLLINK += -cclib -lcamlrund
MLBYTEFLAGS = -g
else
CFLAGS = -O -DG_DISABLE_CAST_CHECKS $(GTKCFLAGS)
endif

THFLAGS = -thread
THLINK = unix.cma threads.cma

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LIBDIR) $(CFLAGS)
else
CCOMPILER = $(CAMLC) -c -ccopt "$(CFLAGS)"
endif

ifdef USE_GL
MLFLAGS += -I $(LABLGLDIR)
MLLINK += lablgl.cma
MLLIBS += lablgtkgl.cma
CLIBS += liblablgtkgl2.a
GLMLOBJS = glGtk.cmo
GLCOBJS = ml_gtkgl.o
endif

#ifdef USE_GNOME
#MLLIBS += lablgnome.cma
#CLIBS += liblablgnome.a
#GNOMEMLOBJS = gtkXmHTML.cmo gHtml.cmo
#GNOMECOBJS = ml_gtkxmhtml.o
#endif

ifdef USE_GLADE
MLLIBS += lablglade.cma
CLIBS += liblablglade2.a
GLADEMLOBJS = glade.cmo
GLADECOBJS = ml_glade.o
endif

ifdef USE_GNOMECANVAS
MLLIBS += lablgnomecanvas.cma
CLIBS += liblablgnomecanvas.a
GNOMECANVASMLOBJS = gnomeCanvas.cmo gnoCanvas.cmo
GNOMECANVASCOBJS = ml_gnomecanvas.o
endif

ifdef USE_GNOMEUI
MLLIBS += lablgnomeui.cma
CLIBS += liblablgnomeui.a
GNOMEUIMLOBJS = gnomeDruid.cmo gnoDruid.cmo
GNOMEUICOBJS = ml_gnomedruid.o
endif

ifdef USE_PANEL
MLLIBS += lablpanel.cma
CLIBS += liblablpanel.a
PANELMLOBJS = panel.cmo
PANELCOBJS = ml_panel.o
endif

ifdef USE_RSVG
MLLIBS += lablrsvg.cma
CLIBS += liblablrsvg.a
RSVGMLOBJS = rsvg.cmo
RSVGCOBJS = ml_rsvg.o
endif


# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def .ml4
.c.o:
	$(CCOMPILER) $<
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<
.ml4.cmo:
	$(CAMLC) -c -pp "$(CAMLP4O) -impl" -impl $<
#.ml4.ml:
#	$(CAMLP4) -impl $< -o $@

%_tags.h %_tags.c %Enums.ml: %_tags.var varcc
	./varcc $<

%Props.ml o%Props.ml: %.props propcc
	./propcc $<


# Targets
GTKOBJS =  ml_gtk.o ml_pango.o ml_gtkbin.o ml_gtkbutton.o ml_gtkedit.o \
	ml_gtklist.o ml_gtkmenu.o ml_gtkmisc.o ml_gtkpack.o ml_gtkrange.o \
	ml_gtktext.o ml_gtktree.o ml_gtkstock.o
COBJS = ml_gdkpixbuf.o ml_gdk.o ml_glib.o ml_gobject.o ml_gpointer.o \
	wrappers.o $(GTKOBJS)
GTKPROPS = gtkBase.props gtkBin.props gtkButton.props gtkEdit.props \
	gtkList.props gtkMenu.props gtkMisc.props gtkPack.props \
	gtkRange.props gtkText.props gtkTree.props
MLOBJS1 =  gaux.cmo gpointer.cmo glib.cmo gobject.cmo
ENUMOBJS = gdkEnums.cmo pangoEnums.cmo gtkEnums.cmo
MLOBJS2 = gdk.cmo gdkEvent.cmo gdkKeysyms.cmo gdkPixbuf.cmo \
	gtk.cmo pango.cmo gtkSignal.cmo gtkStock.cmo gtkObject.cmo
MLOBJS3 = gtkData.cmo gtkBase.cmo gtkPack.cmo gtkButton.cmo \
	gtkMenu.cmo gtkMisc.cmo gtkWindow.cmo gtkList.cmo \
	gtkBin.cmo gtkEdit.cmo gtkRange.cmo gtkText.cmo gtkTree.cmo \
	gtkMain.cmo \
	gPango.cmo gDraw.cmo gObj.cmo gData.cmo gMain.cmo
MLOBJS4 = gContainer.cmo gPack.cmo gButton.cmo gText.cmo \
	gMenu.cmo gMisc.cmo gTree.cmo gList.cmo gWindow.cmo gBin.cmo \
	gEdit.cmo gRange.cmo gUtil.cmo gToolbox.cmo
MLOBJS =  $(MLOBJS1) $(ENUMOBJS) $(MLOBJS2) $(GTKPROPS:.props=Props.cmo) \
	$(MLOBJS3) $(GTKPROPS:%.props=o%Props.cmo) $(MLOBJS4)
MLXOBJS = $(MLOBJS1) $(ENUMOBJS) $(MLOBJS2) $(MLOBJS3) $(MLOBJS4)
THOBJS = gtkThread.cmo
INITOBJS = gtkInit.cmo
THINITOBJS = gtkThInit.cmo
ALLOBJS = $(MLXOBJS) $(GLMLOBJS) $(GNOMEMLOBJS) $(GLADEMLOBJS) \
	$(RSVGMLOBJS) $(GNOMECANVASMLOBJS) $(GNOMEUIMLOBJS) $(PANELOBJS) $(INITOBJS)
ALLTHOBJS = $(THOBJS) $(THINITOBJS)

depend: $(ENUMOBJS:.cmo=.ml) $(GTKPROPS:%.props=%Props.ml) $(GTKPROPS:%.props=o%Props.ml)
	ocamldep *.ml *.mli > .depend

ifeq ($(THREADS_LIB),no)
lablgtktop: $(MLLIBS) $(INITOBJS)
	$(TOPLEVEL) $(CUSTOM) -o $@ $(MLLINK) -I . $(MLLIBS) $(INITOBJS)
else
lablgtktop: $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS)
	$(TOPLEVEL) $(THFLAGS) $(CUSTOM) -o $@ $(THLINK) $(MLLINK) \
	   -I . $(MLLIBS) $(THOBJS) $(INITOBJS)
endif

lablgtk2: Makefile $(CONFIG) lablgtk2.in
	sed -e "s|@INSTALLDIR@|$(INSTALLDIR)|g" \
	    -e "s|@LABLGLDIR@|$(LABLGLDIR)|g" \
	    -e "s|@LIBDIR@|$(LIBDIR)|g" \
	    -e "s|@MLLIBS@|$(MLLINK:-custom=) $(MLLIBS)|g" \
	    -e "s|@INITOBJS@|$(INITOBJS)|g" \
	    -e "s|@THOBJS@|$(THOBJS)|g" \
	    -e "s|@THINITOBJS@|$(THINITOBJS)|g" \
	    -e "s|@USEDLL@|$(HAS_DLL_SUPPORT)|g" \
	    -e "s|@THREADS_LIB@|$(THREADS_LIB)|g" \
	    < lablgtk2.in > $@
	chmod 755 $@

lablgtkopt:: $(MLLIBS:.cma=.cmxa) $(INITOBJS:.cmo=.cmx)
ifeq ($(THREADS_LIB),system)
lablgtkopt:: $(THOBJS:.cmo=.cmx)
endif

lablgladecc: xml_lexer.cmo lablgladecc.cmo
	$(LINKER) -o $@ $(MLLINK) xml_lexer.cmo lablgladecc.cmo

testcc: lablgladecc lablgtktop
	./lablgladecc -test > testcc.ml
	./lablgtktop testcc.ml
	rm -f testcc.ml

install:
	mkdir -p $(INSTALLDIR) $(BINDIR) $(DLLDIR)
	cp $(ALLOBJS:.cmo=.cmi) $(THOBJS:.cmo=.cmi) $(INSTALLDIR)
	cp -p *.mli $(INSTALLDIR)
	cp -p $(ALLOBJS:.cmo=.ml) $(ALLTHOBJS:.cmo=.ml) $(INSTALLDIR)
	cp $(MLLIBS) $(THOBJS) $(INITOBJS) $(THINITOBJS) $(INSTALLDIR)
	cp $(CLIBS) $(INSTALLDIR)
	cd $(INSTALLDIR) && $(RANLIB) $(CLIBS)
	cp varcc propcc $(INSTALLDIR)
	if test $(THREADS_LIB) != system || test $(HAS_DLL_SUPPORT) != yes; \
	   then cp lablgtktop $(INSTALLDIR); \
	fi
	cp -p *.h $(INSTALLDIR)
	if test -f lablgtk.cmxa; then $(MAKE) installopt; fi
	@if test -f dlllablgtk2.so; then \
	   if test -d $(DLLDIR); then : ; else mkdir -p $(DLLDIR); fi; \
	   cp $(CLIBS:lib%.a=dll%.so) $(DLLDIR) || \
	   echo "Couldn't install dlls in default location: " $(DLLDIR); \
	fi
	cp lablgtk2 $(BINDIR)
	if test -f lablgladecc; then cp lablgladecc $(BINDIR)/lablgladecc2; fi

installopt:
	cp $(MLLIBS:.cma=.cmxa) $(MLLIBS:.cma=.a) $(INSTALLDIR)
	cd $(INSTALLDIR) && $(RANLIB) $(MLLIBS:.cma=.a)
	cp $(ALLOBJS:.cmo=.cmx) $(INSTALLDIR)
	cp $(INITOBJS:.cmo=.o) $(INSTALLDIR)
	if test -f gtkThread.cmx; then \
	   cp $(THOBJS:.cmo=.cmx) $(THOBJS:.cmo=.o) $(INSTALLDIR); fi

liblablgtk2.a: $(COBJS)
	$(LIBRARIAN) -o lablgtk2 $(COBJS) $(GTKLIBS)
lablgtk.cma: liblablgtk2.a $(MLOBJS)
	$(LIBRARIAN) -o lablgtk -oc lablgtk2 $(MLOBJS) $(GTKLIBS)
lablgtk.cmxa: liblablgtk2.a $(MLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtk -oc lablgtk2 $(MLOBJS:.cmo=.cmx) $(GTKLIBS)

liblablgtkgl2.a: $(GLCOBJS)
	$(LIBRARIAN) -o lablgtkgl2 $(GLCOBJS) \
	    $(GTKGLLIBS)
lablgtkgl.cma: liblablgtkgl2.a $(GLMLOBJS)
	$(LIBRARIAN) -o lablgtkgl -oc lablgtkgl2 $(GLMLOBJS) \
	    $(GTKGLLIBS)
lablgtkgl.cmxa: liblablgtkgl2.a $(GLMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgtkgl -oc lablgtkgl2 $(GLMLOBJS:.cmo=.cmx) \
	    $(GTKGLLIBS)

#liblablgnome.a: $(GNOMECOBJS)
#	$(LIBRARIAN) -o lablgnome $(GNOMECOBJS) $(GNOMELIBS)
#lablgnome.cma: liblablgnome.a $(GNOMEMLOBJS)
#	$(LIBRARIAN) -o lablgnome $(GNOMEMLOBJS) $(GNOMELIBS)
#lablgnome.cmxa: liblablgnome.a $(GNOMEMLOBJS:.cmo=.cmx)
#	$(LIBRARIAN) -o lablgnome $(GNOMEMLOBJS:.cmo=.cmx) $(GNOMELIBS)

liblablglade2.a: $(GLADECOBJS)
	$(LIBRARIAN) -o lablglade2 $(GLADECOBJS) $(GLADELIBS)
lablglade.cma: liblablglade2.a $(GLADEMLOBJS)
	$(LIBRARIAN) -o lablglade -oc lablglade2 $(GLADEMLOBJS) $(GLADELIBS)
lablglade.cmxa: liblablglade2.a $(GLADEMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablglade -oc lablglade2 \
	    $(GLADEMLOBJS:.cmo=.cmx) $(GLADELIBS)

liblablrsvg.a: $(RSVGCOBJS)
	$(LIBRARIAN) -o lablrsvg $(RSVGCOBJS) $(RSVGLIBS)
lablrsvg.cma: liblablrsvg.a $(RSVGMLOBJS)
	$(LIBRARIAN) -o lablrsvg -oc lablrsvg $(RSVGMLOBJS) $(RSVGLIBS)
lablrsvg.cmxa: liblablrsvg.a $(RSVGMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablrsvg -oc lablrsvg \
	    $(RSVGMLOBJS:.cmo=.cmx) $(RSVGLIBS)

liblablgnomecanvas.a: $(GNOMECANVASCOBJS)
	$(LIBRARIAN) -o lablgnomecanvas $(GNOMECANVASCOBJS) $(GNOMECANVASLIBS)
lablgnomecanvas.cma: liblablgnomecanvas.a $(GNOMECANVASMLOBJS)
	$(LIBRARIAN) -o lablgnomecanvas $(GNOMECANVASMLOBJS) $(GNOMECANVASLIBS)
lablgnomecanvas.cmxa: liblablgnomecanvas.a $(GNOMECANVASMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgnomecanvas \
	    $(GNOMECANVASMLOBJS:.cmo=.cmx) $(GNOMECANVASLIBS)
# gnoCanvas.cmo: COMPILER+= -i

liblablgnomeui.a: $(GNOMEUICOBJS)
	$(LIBRARIAN) -o lablgnomeui $(GNOMEUICOBJS) $(GNOMEUILIBS)
lablgnomeui.cma: liblablgnomeui.a $(GNOMEUIMLOBJS)
	$(LIBRARIAN) -o lablgnomeui $(GNOMEUIMLOBJS) $(GNOMEUILIBS)
lablgnomeui.cmxa: liblablgnomeui.a $(GNOMEUIMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablgnomeui \
	    $(GNOMEUIMLOBJS:.cmo=.cmx) $(GNOMEUILIBS)
# gnoDruid.cmo: COMPILER+= -i

liblablpanel.a: $(PANELCOBJS)
	$(LIBRARIAN) -o lablpanel $(PANELCOBJS) $(PANELLIBS)
lablpanel.cma: liblablpanel.a $(PANELMLOBJS)
	$(LIBRARIAN) -o lablpanel $(PANELMLOBJS) $(PANELLIBS)
lablpanel.cmxa: liblablpanel.a $(PANELMLOBJS:.cmo=.cmx)
	$(LIBRARIAN) -o lablpanel \
	    $(PANELMLOBJS:.cmo=.cmx) $(PANELLIBS)

gtkThread.cmo: gtkThread.ml
	$(COMPILER) $(THFLAGS) gtkThread.ml

gtkThread.cmi: gtkThread.mli
	$(COMPILER) $(THFLAGS) gtkThread.mli

gtkThread.cmx: gtkThread.ml
	if test -f $(LIBDIR)/libthreadsnat.a; then \
	   $(COMPOPT) $(THFLAGS) gtkThread.ml; fi

xml_lexer.ml: xml_lexer.mll
	$(OCAMLLEX) xml_lexer.mll
xml_lexer.cmo xml_lexer.cmx : xml_lexer.cmi

varcc: varcc.cmo
	$(LINKER) -o $@ $<
	rm -f *_tags.h *_tags.c

propcc: propcc.cmo
	$(LINKER) -o $@ $<

check_externals: check_externals.cmo
	$(LINKER) -o $@ $<

clean:
	rm -f *.cm* *.o *.a *.so *_tags.[ch] $(TARGETS) varcc.ml xml_lexer.ml \
	  propcc check_externals check_externals.ml propcc.ml \
	  *Enums.ml *Props.ml
	rm -f \#*\# *~


DOCFILES =  gaux.ml gpointer.mli glib.mli gobject.mli \
        gdk.mli gdkEvent.ml gdkPixbuf.mli \
        gtk.ml pango.ml gtkSignal.mli gtkObject.ml \
        $(GTKPROPS:%.props=%Props.ml) \
        gtkStock.ml gtkData.ml gtkBase.ml gtkPack.ml gtkButton.ml \
        gtkMenu.ml gtkMisc.ml gtkWindow.ml gtkList.ml \
        gtkEdit.ml gtkRange.ml gtkText.ml gtkTree.ml \
        gtkMain.ml \
        gPango.ml gDraw.mli \
        gObj.mli gMain.mli gData.mli gContainer.mli gBin.mli gPack.mli gButton.mli \
        gText.mli \
        gMenu.mli gMisc.mli gTree.mli gList.mli gWindow.mli \
        gEdit.mli gRange.mli gUtil.mli gToolbox.mli
ifdef USE_GLADE
DOCFILES += glade.mli xml_lexer.mli
endif
ifdef USE_GL
DOCFILES += glGtk.mli
endif
ifdef USE_RSVG
DOCFILES += rsvg.mli
endif
ifdef USE_GNOMECANVAS
DOCFILES += gnomeCanvas.ml gnoCanvas.mli
endif
ifdef USE_PANEL
DOCFILES += panel.mli
endif

OCAMLDOC = ocamldoc
lablgtk.odoc : $(DOCFILES) $(ALLOBJS)
	$(OCAMLDOC) -dump $@ -v  -I $(LABLGLDIR) $(DOCFILES)
gtkdoc.cmo : gtkdoc.ml
	$(OCAMLC) -I +ocamldoc -c $<
doc : lablgtk.odoc gtkdoc.cmo
	$(OCAMLDOC) -g ./gtkdoc.cmo -v -t LablGTK -d ../doc/html -load $<
doc_texi : lablgtk.odoc
	$(OCAMLDOC) -texi -v -t LablGTK -o ../doc/lablgtk2.texi -load $<

srcdoc: $(ALLOBJS)
	mkdir -p doc
	$(OCAMLDOC) -html -t "Lablgtk2" -d doc -I . `ls $(ALLOBJS:.cmo=.mli) 2> /dev/null`

$(GTKOBJS): pango_tags.h gtk_tags.h ml_gtk.h gdk_tags.h ml_gdk.h \
	    ml_gobject.h ml_glib.h wrappers.h
$(GNOMEUICOBJS) : gnomeui_tags.h
$(PANELCOBJS) : panel_tags.h
ml_glib.o: glib_tags.h ml_glib.h wrappers.h
ml_gobject.o: gobject_tags.h wrappers.h
ml_gdk.o: gdk_tags.h ml_gdk.h ml_gpointer.h ml_pango.h wrappers.h
ml_gtk.o ml_gtktext.o: ml_pango.h
ml_gtkgl.o: gtkgl_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gtkxmhtml.o: gtkxmhtml_tags.h ml_gtk.h ml_gdk.h wrappers.h
ml_gpointer.o: ml_gpointer.h
ml_gdkpixbuf.o: gdkpixbuf_tags.h ml_gdk.h gdk_tags.h wrappers.h ml_gpointer.h
ml_pango.o: pango_tags.h ml_pango.h
ml_rsvg.o: ml_gobject.h ml_gdkpixbuf.h wrappers.h
ml_gnomecanvas.o: ml_gtk.h ml_gobject.h wrappers.h
ml_gnomedruid.o: ml_gtk.h ml_gobject.h wrappers.h
ml_panel.o: ml_gtk.h ml_gobject.h wrappers.h
varcc.cmo: varcc.ml4

include .depend
