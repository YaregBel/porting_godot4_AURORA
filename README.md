# porting_godot4_AURORA
## Данный файл описывает подробный процесс сборки godot4 под операционную систему AURORA.

### Сборка игрового движка под платформу linuxbsd
Для начала попробуем собрать наш игровой движок, под linux, чтобы иметь представление о процессе сборки. 
Для этого, используем следующий bash скрипт:
```bash
cd ~/
mkdir builds && cd $_
git clone https://github.com/godotengine/godot.git -b 4.3-stable
pacman -Sy --noconfirm --needed \
  scons \
  pkgconf \
  gcc \
  libxcursor \
  libxinerama \
  libxi \
  libxrandr \
  wayland-utils \
  mesa \
  glu \
  libglvnd \
  alsa-lib \
  pulseaudio
scons platform=linuxbsd wayland=yes
```
по итогу работы scons, в директории godot создается bin директория, которая хранит в себе готовый бинарник, для запуска игрового движка. Также добавляем поддержку wayland, сборкой с соответствующим флажком.

### Подключение к build engine по SSH
Дальнейшая работа уже будет проводится в build engine, который предоставляется вместе с Аврора SDK. 
Для начала нужно подключиться к build engine:
```bash
ssh -p 2222 -i {путь к SDK}/vmshare/ssh/private_keys/sdk mersdk@localhost
```

Данная команда позволяет подключиться через терминал по SSH к build engine и работать уже в нем. 

### Установка Аврора SDK
Данный этап, пока не полностью реализован, в связи с недостатком необходимых библиотек, а именно:
`libxcb-glx.so.0` Так как ее нет в репозиториях используемых zypper и pkcon.

Сам же установщик Аврора SDK был скачан, используя утилиты curl:
`curl -O https://sdk-repo.omprussia.ru/sdk/installers/5.1.3/5.1.3.85-release/AuroraSDK-MB2/AuroraSDK-5.1.3.85-MB2-release-linux-64-offline-24.12.11-07.44.11.run`

### Установка и сборка godot4
Сборка godot4 под ОС Аврора так же неудалась, по причине устаревшего инструмента для сборки, который как раз таки используется для сборки игрового движка.

Для начала разберемся, какие необходимо иметь пакеты, чтобы сборка удалась:
```
GCC 9+ or Clang 6+.
Python 3.6+.
SCons 3.1.2+ build system.
pkg-config (used to detect the development libraries listed below).

Development libraries:
X11, Xcursor, Xinerama, Xi and XRandR.
Wayland and wayland-scanner.
Mesa.
ALSA.
PulseAudio.
Optional - libudev (build with udev=yes).
```
Их загрузка и установка производилась используя следующие команды:
```
pkcon install zypper
pkcon install scons
pkcon install alsa-lib
pkcon install wayland
pkcon install wayland-devel 
pkcon install gcc

sudo zypper install pkgconfig
sudo zypper install mesa-llvmpipe
sudo zypper install alsa-lib-devel
sudo zypper install pkgconfig
sudo zypper install python
sudo zypper install python3
sudo zypper install python3-devel
sudo zypper install python3-base
sudo zypper install wayland
sudo zypper install pulseaudio
sudo zypper install alsa-lib alsa-utils alsa-plugins-pulseaudio

sudo zypper install git
sudo zypper install yasm
sudo zypper install harfbuzz harfbuzz-icu
sudo zypper install pcre2
```
Но среди них не удалось найти следующие пакеты в репозиториях:
```
X11, Xcursor, Xinerama, Xi and XRandR.
wayland-scanner
libudev (опциальная зависимость)
```

Также сделан вывод, что пакеты для работы с X11 отсутсвуют на Aurora ОС, поэтому нужно добавить их поддержку, для успешной сборки игрового движка.







