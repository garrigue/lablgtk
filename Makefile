# Toplevel makefile for LablGtk2

all opt srcdoc install byte clean depend world: config.make src/.depend
	$(MAKE) -C src $@

src/.depend:
	touch src/.depend
	make -C src depend

arch-clean:
	@rm -f config.status config.make config.cache config.log 
	@rm -f \#*\# *~ aclocal.m4
	@rm -rf autom4te*.cache

configure: configure.in
	aclocal
	autoconf 

config.make: config.make.in
	@echo config.make is not up to date. Execute ./configure first.
	@exit 2
