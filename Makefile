# Toplevel makefile for LablGtk2

all opt srcdoc install byte clean depend: config.make
	$(MAKE) -C src $@

arch-clean:
	@rm -f config.status config.make config.cache config.log 
	@rm -f \#*\# *~ aclocal.m4
	@rm -rf autom4te*.cache

#configure: configure.in
#	aclocal
#	autoconf 

config.make: config.make.in configure
	@echo config.make is not up to date. Execute ./configure first.
	@exit 2
