## porting_godot4_AURORA
### Данный файл описывает подробный процесс сборки godot4 под операционную систему AURORA.

#### Сборка игрового движка под платформу linuxbsd
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
scons platform=linuxbsd
```
по итогу работы scons, в директории godot создается bin директория, которая хранит в себе готовый бинарник, для запуска игрового движка.



#### 
