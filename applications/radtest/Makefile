# $Id$
# Makefile for lablgtk.

all: radtest

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../.. -w s -labels

ifdef DEBUG
CFLAGS = -g $(GTKCFLAGS)
MLFLAGS += -g
else
CFLAGS = -O -DGTK_NO_CHECK_CASTS -DGTK_DISABLE_COMPAT_H $(GTKCFLAGS)
endif

ifdef USE_CC
CCOMPILER = $(CC) -c -I$(LIBDIR) $(CFLAGS)
else
CCOMPILER = ocamlc -c -ccopt "$(CFLAGS)"
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

# Targets
MLOBJS = utils.cmo property.cmo propwin.cmo \
	load_parser.cmo load_lexer.cmo tiBase.cmo tiContainer.cmo tiBin.cmo \
	tiButton.cmo tiEdit.cmo tiList.cmo tiMisc.cmo tiPack.cmo tiWindow.cmo \
	tiWidget.cmo main.cmo

MLSRC = common.mli utils.ml property.mli property.ml propwin.mli \
	propwin.ml \
	load_parser.ml load_lexer.ml tiBase.ml tiContainer.ml tiBin.ml \
	tiButton.ml tiEdit.ml tiList.ml tiMisc.ml tiPack.ml tiWindow.ml \
	tiWidget.ml main.ml

radtest: $(MLOBJS)  libgtk2.a gtk2.cma
	$(LINKER) -o $@ lablgtk.cma gtkInit.cmo -I . gtk2.cma \
	    $(MLOBJS)

radtestopt: $(MLOBJS:.cmo=.cmx) libgtk2.a gtk2.cmxa
	$(LINKOPT) -o $@ lablgtk.cmxa gtkInit.cmx -I . gtk2.cmxa \
	    $(MLOBJS:.cmo=.cmx)

%.mli %.ml: %.mly
	ocamlyacc $<

%.ml: %.mll
	ocamllex $<

libgtk2.a: gtktree2.o gtktreeitem2.o ml_gtk2.o
	ar rc $@ gtktree2.o gtktreeitem2.o ml_gtk2.o
	$(RANLIB) $@

gtk2.cma: gtkTree2.cmo gTree2.cmo gToolbar2.cmo libgtk2.a
	$(LINKER) -a -o $@ gtkTree2.cmo gTree2.cmo gToolbar2.cmo -cclib -lgtk2

gtk2.cmxa: gtkTree2.cmx gTree2.cmx gToolbar2.cmx libgtk2.a
	$(LINKOPT) -a -o $@ gtkTree2.cmx gTree2.cmx gToolbar2.cmx -cclib -lgtk2

clean:
	rm -f *.cm* *.o *.a radtest *_parser.ml *_parser.mli *_lexer.ml

.depend: $(MLSRC)
	ocamldep $(MLSRC) > .depend

include .depend
