# $Id$
# Makefile for lablgtk.

all: browser

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -labels -w s -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -labels -w s -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../../src -I ocaml-src/utils -I ocaml-src/parsing

# Rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx .c .o .var .h .opt .def
.ml.cmo:
	$(COMPILER) $<
.mli.cmi:
	$(COMPILER) $<
.ml.cmx:
	$(COMPOPT) $<

# Targets
MLOBJS = text.cmo file.cmo lexical.cmo shell.cmo editor.cmo

browser: $(MLOBJS)
	$(LINKER) -o $@	toplevellib.cma str.cma unix.cma \
	    lablgtk.cma	$(MLOBJS) 

clean:
	rm -f *.cm* browser

.depend:
	ocamldep *.ml *.mli > .depend

include .depend
