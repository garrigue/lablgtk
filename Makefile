# Toplevel makefile for LablGtk2

all opt srcdoc install byte clean depend: config.make
	cd src && $(MAKE) $@

arch-clean: clean
	@rm -f config.status config.make config.cache \#*\# *~

configure: configure.in
	autoconf 

config.make: config.make.in configure
	@./configure
