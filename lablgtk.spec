%define	name	 lablgtk
%define ver      20020702
%define rel      1
%define prefix   /usr/local/
%define sysconfdir /etc/
%define exec_prefix /usr/local/bin/
%define bindir /usr/local/bin/
%define libdir /usr/lib/ocaml/
%define includedir /usr/local/include/

Summary: LablGTK : an interface to the GIMP Tool Kit
Name: %{name}
Version: %{ver}
Release: %{rel}
Copyright: LGPL
Group: System Environment/Libraries
Source: http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/%{name}-%{ver}.tar.gz
BuildRoot: %{_tmppath}/%{name}-root
Packager: Ben Martin <monkeyiq@users.sourceforge.net>
URL: http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgl.html

%description
LablGTK is is an Objective Caml interface to gtk+.

It uses the rich type system of Objective Caml 3 to provide a strongly typed, yet very comfortable, object-oriented interface to gtk+. This is not that easy if you know the dynamic typing approach taken by gtk+.

It is still under development, but already fully functional. All widgets (but one) are available, with almost all their methods. The GLArea widget is also supported in combination with LablGL. Lots of examples are provided.

Objective Caml threads are supported, including for the toplevel, which allows for interactive use of the library.

LablGTK also works under Windows. See the README for details about how to build it for Win32.

Since release 1.2.1, LablGTK contains support for rapid development with glade, through an interface wrapper compiler, and a libglade binding. You can also find code generators in the tools section. 
%package lablgtk_examples
Summary: Examples of using lablgtk
Group: System/Libraries
Requires: %{name} >= %{ver}
%description lablgtk_examples
Examples of using lablgtk

%prep -q
rm -rf $RPM_BUILD_ROOT;


%setup -q -n  lablgtk

%build

make configure USE_GL=1 #USE_GNOME=1 USE_GLADE=1
if [ "$SMP" != "" ]; then
  (make "MAKE=make -k -j $SMP"; exit 0)
  make 
else
  make 
fi

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{prefix}/lablgtk-examples
cp -av examples/* $RPM_BUILD_ROOT%{prefix}/lablgtk-examples
mkdir -p $RPM_BUILD_ROOT%{bindir}
make \
	prefix=$RPM_BUILD_ROOT%{prefix} \
	sysconfdir=$RPM_BUILD_ROOT%{sysconfdir} \
	exec_prefix=$RPM_BUILD_ROOT%{exec_prefix} \
	bindir=$RPM_BUILD_ROOT%{bindir} \
	libdir=$RPM_BUILD_ROOT%{libdir} \
	includedir=$RPM_BUILD_ROOT%{includedir} \
	LIBDIR=$RPM_BUILD_ROOT%{libdir} \
	INSTALLDIR=$RPM_BUILD_ROOT%{libdir}/lablgtk \
	BINDIR=$RPM_BUILD_ROOT%{bindir} \
	install



%clean
rm -rf $RPM_BUILD_ROOT

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%defattr(-,root,root,0755)
%doc AUTHORS README COPYING ChangeLog INSTALL
%{bindir}/*
%{libdir}/*

%files lablgtk_examples
%defattr(-,root,root,0755)
%{prefix}/lablgtk-examples


%changelog
* Thu Apr 22 2002 Ben Martin
- Created 
