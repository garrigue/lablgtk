# makefile for configuring lablGTK

# Default compilers
CAMLC = ocamlc
CAMLOPT = ocamlopt

# Default installation directories
BINDIR = `$(GETBINDIR)`
INSTALLDIR = $(LIBDIR)/lablgtk

# Autoconf
GETLIBDIR = ocamlc -v | grep "^Standard" | sed 's/^.*: *//'
LIBDIR = `$(GETLIBDIR)`
GETBINDIR = $(GETLIBDIR) | sed -e 's|/lib/[^/]*$$|/bin|' -e 's|/lib$$|/bin|'
GETRANLIB = which ranlib 2>/dev/null | sed -e 's|.*/ranlib$$|!|' -e 's/^[^!]*$$/:/' -e 's/!/ranlib/'

GTK_CONFIG = gtk-config
GNOME_CONFIG = gnome-config

ifdef USE_GNOME
GTKGETCFLAGS = $(GTK_CONFIG) --cflags`" -I"`gnome-config --includedir
GNOMELIBS = `$(GNOME_CONFIG) --libs gtkxmhtml`
else
GTKGETCFLAGS = $(GTK_CONFIG) --cflags
endif

GTKGETLIBS = $(GTK_CONFIG) --libs

configure: .depend config.make

.depend:
	ocamldep *.ml *.mli > .depend

config.make:
	@echo CAMLC=$(CAMLC) > config.make
	@echo CAMLOPT=$(CAMLOPT) >> config.make
	@echo USE_GL=$(USE_GL) >> config.make
	@echo USE_GNOME=$(USE_GNOME) >> config.make
	@echo USE_CC=$(USE_CC) >> config.make
	@echo DEBUG=$(DEBUG) >> config.make
	@echo CC=$(CC) >> config.make
	@echo RANLIB=`$(GETRANLIB)` >> config.make
	@echo LIBDIR=$(LIBDIR) >> config.make
	@echo BINDIR=`$(GETBINDIR)` >> config.make
	@echo INSTALLDIR=$(INSTALLDIR) >> config.make
	@echo GTKCFLAGS=`$(GTKGETCFLAGS)` >> config.make
	@echo GTKLIBS=`$(GTKGETLIBS)` | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LRWr][^ ]*/-ccopt &/g' \
	  >> config.make
	@echo GNOMELIBS=$(GNOMELIBS) | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LRWr][^ ]*/-ccopt &/g' \
	  >> config.make
	cat config.make
