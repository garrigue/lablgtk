# $Id$
# Makefile for lablgtk.

all: browser

CAMLC = ocamlc
CAMLOPT = ocamlopt
COMPILER = $(CAMLC) $(MLFLAGS) -modern -w s -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -modern -w s -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../.. -I ocaml-src/utils -I ocaml-src/parsing

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
	$(LINKER) -o $@ -custom -cclib "-L../..	-llablgtk $(GTKLIBS)" \
	toplevellib.cma str.cma unix.cma \
	lablgtk.cma -cclib "-lstr -lunix" $(MLOBJS) 

clean:
	rm -f *.cm* browser

.depend:
	olabldep *.ml *.mli > .depend

include .depend
