%define _enable_debug_package 1

%define __strip /bin/true
%define __os_install_post %{nil}

%define __requires_exclude ^libfreetype\\.so.*|.*libxkbcommon\\.so.*$
%define __provides_exclude_from ^%{_datadir}/%{name}/lib/.*\\.so.*$

Name: ru.yareg.game

Summary: Godot 4 game example
Version: 1.1
Release: 1
License: MIT
URL: https://github.com/YaregBel/porting_godot4_AURORA
BuildRequires: patchelf

%description
%{summary}

%prep 
# nothing to do, or gen desktop

%build
# nothing to do

%install
# icons should be in icons folder
install -m 0655 -D icons/86.png  %{buildroot}%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
install -m 0655 -D icons/108.png %{buildroot}%{_datadir}/icons/hicolor/108x108/apps/%{name}.png
install -m 0655 -D icons/128.png %{buildroot}%{_datadir}/icons/hicolor/128x128/apps/%{name}.png
install -m 0655 -D icons/172.png %{buildroot}%{_datadir}/icons/hicolor/172x172/apps/%{name}.png
# PCK file
install -m 0655 -D /home/mersdk/docker/builds/pck/test.pck  %{buildroot}%{_datadir}/%{name}/ru.yareg.game.pck
# install desktop file
install -m 0655 -D rpm/template.desktop %{buildroot}%{_datadir}/applications/%{name}.desktop
# template runner
install -m 755 -D /home/mersdk/docker/godot.linuxbsd.template_debug.arm32 %{buildroot}%{_bindir}/%{name}
patchelf --force-rpath --set-rpath %{_datadir}/%{name}/lib %{buildroot}%{_bindir}/%{name}
# dependencies
install -D %{_libdir}/libfreetype.so.* -t %{buildroot}%{_datadir}/%{name}/lib/
install -D %{_libdir}/libxkbcommon.so.* -t %{buildroot}%{_datadir}/%{name}/lib/

%files 
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
%{_datadir}/icons/hicolor/108x108/apps/%{name}.png
%{_datadir}/icons/hicolor/128x128/apps/%{name}.png
%{_datadir}/icons/hicolor/172x172/apps/%{name}.png
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_bindir}/%{name}

%changelog
* Mon Mar 10 2025 Yaroslav Belikov <yaroslav03bel@gmail.com> - 1.1-1 
- Initial release
