# $Id$
# Makefile for lablgtk.

all: radtest

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

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
MLOBJS = utils.cmo property.cmo propwin.cmo paste_parser.cmo paste_lexer.cmo \
	wpaste_parser.cmo wpaste_lexer.cmo \
	treew.cmo load_parser.cmo load_lexer.cmo main.cmo
MLSRC = paste_parser.ml paste_lexer.ml wpaste_parser.ml wpaste_lexer.ml \
	load_parser.ml load_lexer.ml

radtest: $(MLOBJS)  libtree2.a gtree2.cma
	$(LINKER) -o $@ lablgtk.cma gtkInit.cmo -I . gtree2.cma \
	    $(MLOBJS)

radtestopt: $(MLOBJS:.cmo=.cmx) libtree2.a gtree2.cmxa
	$(LINKOPT) -o $@ lablgtk.cmxa gtkInit.cmx -I . gtree2.cmxa \
	    $(MLOBJS:.cmo=.cmx)

%.mli %.ml: %.mly
	ocamlyacc $<

%.ml: %.mll
	ocamllex $<

libtree2.a: gtktree2.o gtktreeitem2.o ml_gtk2.o
	ar rc $@ gtktree2.o gtktreeitem2.o ml_gtk2.o
	$(RANLIB) $@

gtree2.cma: gtkTree2.cmo gTree2.cmo
	$(LINKER) -a -o $@ gtkTree2.cmo gTree2.cmo -cclib -ltree2

gtree2.cmxa: gtkTree2.cmx gTree2.cmx
	$(LINKOPT) -a -o $@ gtkTree2.cmx gTree2.cmx -cclib -ltree2

clean:
	rm -f *.cm* *.o *.a radtest *_parser.ml *_parser.mli *_lexer.ml

.depend: $(MLSRC)
	ocamldep *.ml *.mli > .depend

include .depend
