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
BINDIR = `$(GETLIBDIR) | sed -e 's|/lib/[^/]*$$|/bin|' -e 's|/lib$$|/bin|'`
RANLIB = `which ranlib 2>/dev/null | sed -e 's|.*/ranlib$$|!|' -e 's/^[^!]*$$/:/' -e 's/!/ranlib/'`

GTK_CONFIG = gtk-config
GNOME_CONFIG = gnome-config
GLADE_CONFIG = libglade-config

ifdef USE_GNOME
ifdef USE_GLADE
GTKCFLAGS = `$(GLADE_CONFIG) --cflags gnome`
GLADELIBS = `$(GLADE_CONFIG) --libs gnome`
else
GTKCFLAGS = `$(GTK_CONFIG) --cflags`" -I"`gnome-config --includedir`
endif
GNOMELIBS = `$(GNOME_CONFIG) --libs gtkxmhtml`
else
ifdef USE_GLADE
GTKCFLAGS = `$(GLADE_CONFIG) --cflags gtk`
GLADELIBS = `$(GLADE_CONFIG) --libs gtk`
else
GTKCFLAGS = `$(GTK_CONFIG) --cflags`
endif
endif

GTKLIBS = `$(GTK_CONFIG) --libs`

configure: .depend config.make

.depend:
	ocamldep *.ml *.mli > .depend

config.make:
	@echo CAMLC=$(CAMLC) > config.make
	@echo CAMLOPT=$(CAMLOPT) >> config.make
	@echo USE_GL=$(USE_GL) >> config.make
	@echo USE_GNOME=$(USE_GNOME) >> config.make
	@echo USE_GLADE=$(USE_GLADE) >> config.make
	@echo USE_CC=$(USE_CC) >> config.make
	@echo DEBUG=$(DEBUG) >> config.make
	@echo CC=$(CC) >> config.make
	@echo RANLIB=$(RANLIB) >> config.make
	@echo LIBDIR=$(LIBDIR) >> config.make
	@echo BINDIR=$(BINDIR) >> config.make
	@echo INSTALLDIR=$(INSTALLDIR) >> config.make
	@echo GTKCFLAGS=$(GTKCFLAGS) >> config.make
	@echo GTKLIBS=$(GTKLIBS) | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LRWr][^ ]*/-ccopt &/g' \
	  >> config.make
	@echo GNOMELIBS=$(GNOMELIBS) | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LRWr][^ ]*/-ccopt &/g' \
	  >> config.make
	@echo GLADELIBS=$(GLADELIBS) | \
	  sed -e 's/-l/-cclib &/g' -e 's/-[LRWr][^ ]*/-ccopt &/g' \
	  >> config.make
	cat config.make
