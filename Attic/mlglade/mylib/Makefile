#
# $Id$
#

include         Makefile.ocaml

#
# Name and version for tar file and library
#

NAME =          mylib
VERSION =       0.5

#
# default target
#

all::           mylib.cma 
all.opt::	mylib.cmxa

realclean::	clean

#
# important file sets 
#

ML =            pp.ml  pc.ml  lc.ml  pc2.ml  std.ml
MLI =           pp.mli pc.mli lc.mli pc2.mli std.mli

CMO =           $(ML:.ml=.cmo)
CMX =           $(ML:.ml=.cmx)
CMI =           $(ML:.ml=.cmi)
OBJ =           $(ML:.ml=.o)

clean::;     	rm -f $(CMO) $(CMX) $(OBJ) $(CMI) 

#
# generate XML documentation from the MLI files
#

MLI2XML =	mli2xml

.SUFFIXES:	.xml

.mli.xml:	
		$(MLI2XML) $< > $@

XML =		$(MLI:.mli=.xml)

doc::		$(XML)

clean::;	rm -f $(XML)

# all files that go into the library

LIBCMO =        $(CMO)
LIBCMX =        $(CMX)

mylib.cma:	$(LIBCMO)
		$(CAMLC) $(CFLAGS) -a -o $@ $(LIBCMO)

mylib.cmxa:	$(LIBCMX)
		$(CAMLOPT) $(OFLAGS) -a -o $@ $(LIBCMX)

realclean::;	rm -f mylib.cma mylib.cmxa mylib.a

#
# build a source distribution
#

DIST =          $(NAME)-$(VERSION).tar.gz

dist:           $(DIST)

$(DIST):	FILES
		ln -s . $(NAME)-$(VERSION) 
		tar cvf - `cat FILES` | gzip > $@
		rm -f $(NAME)-$(VERSION)
		rm -f FILES 

FILES:	        FORCE
		find .							\
			-name CVS 				-prune	\
			-o -name '*.o' 				-prune	\
			-o -name '*.cmi' 			-prune	\
			-o -name '*.cmo'			-prune 	\
			-o -name '*.cma'			-prune 	\
			-o -name '*.html'			-prune 	\
			-o -name '*.xml'			-prune  \
			-o -name '*.cmxa'			-prune 	\
			-o -name '*.cmx'			-prune  \
			-o -name '*.tar*'			-prune  \
			-o -name '*.tmp*'			-prune  \
                        -o -name 'FILES'                        -prune  \
			-o -type f -print | sort | 			\
		sed 	-e 's|^\./|$(NAME)-$(VERSION)/|'  > $@



# dummy target 

FORCE:

# recalculate dependencies

depend:;        $(CAMLDEP) *.mli *.ml > DEPEND

# include dependencies

-include DEPEND

#
# $Log$
# Revision 1.1  2001/09/06 17:22:29  monate
# first commit of mlglade
#
# Revision 1.1.1.1  2001/05/15 15:04:33  monate
#
#
# Revision 1.8  1999/01/10 14:00:08  lindig
#
#
# * Lexer combinators are now more flexible because saving results can
#   be controlled by a function passed to the save function.
#
# Revision 1.7  1999/01/01 17:07:21  lindig
#
# Makefile support for XML documentation from MLI files.
#
# Revision 1.6  1999/01/01 17:05:52  lindig
#
# Makefile support for generating XML files.
#
# Revision 1.5  1998/12/14 17:44:33  lindig
#
# * new modules added
#
# Revision 1.4  1998/12/13 19:17:45  lindig
#
#
# Makefiles and README for possible release refinded.
#
# Revision 1.3  1998/11/24 19:33:17  lindig
#
#
# * functions renamed, extracted substrings are now ordered by their
#   start position.
#
# Revision 1.2  1998/11/18 18:31:33  lindig
#
#
# * pc.ml: extra level of abstraction for recursive combinator [many]
#   added to avoid endless recursion when many is used to define new
#   combinators.
#
# * lc.ml - lexer combinators added
#
# Revision 1.1.1.1  1998/11/15 16:24:08  lindig
# file put into CVS
#
#

