# $Id$
# Makefile for lablgtk.

all: browser

CAMLC = olablc
CAMLOPT = olablopt
COMPILER = $(CAMLC) $(MLFLAGS) -c
LINKER = $(CAMLC) $(MLFLAGS)
COMPOPT = $(CAMLOPT) $(MLFLAGS) -c
LINKOPT = $(CAMLOPT) $(MLFLAGS)

TOPLEVEL = olablmktop $(MLFLAGS)
RANLIB = ranlib

include ../../config.make

MLFLAGS = -I ../.. -I olabl-src/utils -I olabl-src/parsing

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
	toplevellib.cma stdclass.cma str.cma unix.cma \
	lablgtk.cma -cclib "-lstr -lunix" $(MLOBJS) 

clean:
	rm -f *.cm* browser

.depend:
	olabldep *.ml *.mli > .depend

include .depend
