CAMLC=olablc
CAMLCOMP=olablc -nolabels  -c
LABLCOMP=olablc  -c
CAMLLEX=ocamllex
CAMLYACC=ocamlyacc
CAMLLIBR=olablc -a
CAMLDEP=olabldep
CAMLOPT=olablopt -nolabels -unsafe
LABLOPT=olablopt -unsafe
COMPFLAGS= -I ../..

THFLAGS= 

GTKCFLAGS=-I/usr/local/lib/glib/include -I/usr/local/include -I/usr/X11R6/include
GTKLIBS=-L/usr/local/lib -L/usr/X11R6/lib -lgtk -lgdk -lglib -lXext -lX11 -lm

CC = gcc
CCFLAGS= -I /usr/local/lib/ocaml/

CAMLLIBS= unix.cma
LINKLIBS= -cclib -lunix

XALIBS= -cclib cdhacks.o
XAO= cdhacks.o
XAOBJS= xafile.cmo xaadpcm.cmo

WAVOBJS= wav.cmo

DSPLIBS= -cclib dsphacks.o
DSPO= dsphacks.o
DSPOBJS= dsp.cmo

LABLGTKOBJS= lablgtk.cma
LABLGTKLIBS= -cclib "-L../.. -llablgtk $(GTKLIBS)"

all: xxaplay

xxaplay: $(DSPOBJS:.cmo=.cmx) $(DSPO) $(XAOBJS:.cmo=.cmx) $(XAO) $(WAVOBJS:.cmo=.cmx) xxaplay.cmx
	$(LABLOPT) $(COMPFLAGS) -o $@ $(CAMLLIBS:.cma=.cmxa) \
		$(LABLGTKOBJS:.cma=.cmxa) \
		$(DSPOBJS:.cmo=.cmx) \
		$(XAOBJS:.cmo=.cmx) \
		$(WAVOBJS:.cmo=.cmx) \
			xxaplay.cmx $(DSPLIBS) $(XALIBS) $(LINKLIBS) $(LABLGTKLIBS)

xxaplay.cmo: xxaplay.ml
	$(LABLCOMP) $(COMPFLAGS) -c $<

xxaplay.cmx: xxaplay.ml
	$(LABLOPT) $(COMPFLAGS) -c $<

clean:
	rm -f core *.o *.cm* *~ xxaplay

depend:
	$(CAMLDEP) $(INCS) *.ml *.mli > .depend

.SUFFIXES :
.SUFFIXES : .mli .ml .cmi .cmo .cmx .mlp .c .o

.mli.cmi:
	$(CAMLCOMP) $(COMPFLAGS) $<

.ml.cmo:
	$(CAMLCOMP) $(COMPFLAGS) $<

.ml.cmx:
	$(CAMLOPT) $(COMPFLAGS) -c $<

.c.o:
	$(LABLCOMP) $(CCFLAGS) $<

include .depend

