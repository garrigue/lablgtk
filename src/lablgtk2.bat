@echo off
rem start lablgtk2

if "%1" == "-thread" goto thread
ocaml -w s -I +lablgtk2 lablgtk.cma gtkInit.cmo %1 %2 %3 %4 %5 %6 %7 %8 %9
goto done
:thread
ocaml -w s -I +threads unix.cma threads.cma -I +lablgtk2 lablgtk.cma gtkThread.cmo gtkInit.cmo gtkThInit.cmo %2 %3 %4 %5 %6 %7 %8 %9
:done