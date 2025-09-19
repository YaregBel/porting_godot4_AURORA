arch="`[ "X${1}" == "X" ] && echo armv7hl || echo $1`"

__package_license__="MIT"
__package_summary__="Godot 4 game example"
__package_version__="1.1"
__package_release__="1"
__package_premissions__=""
__application_read_name__="Godot 4 Materials"
__application_org__="ru.yareg"
__application_name__="game"
__pck_file__="/home/mersdk/docker/builds/pck/test.pck"

__template_file__="/home/mersdk/docker/godot.linuxbsd.template_release.arm64"

if [ "${arch}" == "armv7hl" ]; then
    __template_file__="/home/mersdk/docker/godot.linuxbsd.template_debug.arm32"
fi

__package_name__="${__application_org__}.${__application_name__}"

templates=".desktop.in .spec.in"
mkdir -p rpm
for each in $templates; do
    cat template${each} | sed \
        -e "s/__package_name__/${__package_name__}/g" \
        -e "s/__package_summary__/${__package_summary__}/g" \
        -e "s/__package_version__/${__package_version__}/g" \
        -e "s/__package_release__/${__package_release__}/g" \
        -e "s/__package_premissions__/${__package_premissions__}/g" \
        -e "s/__application_read_name__/${__application_read_name__}/g" \
        -e "s/__application_org__/${__application_org__}/g" \
        -e "s~__pck_file__~${__pck_file__}~g" \
        -e "s~__template_file__~${__template_file__}~g" \
        -e "s/__package_license__/${__package_license__}/g" \
        -e "s/__application_name__/${__application_name__}/g" > /home/mersdk/docker/builds/rpm/template${each%%.in}
done

# check icons
error="no"
for each in 86 108 128 172; do
    file="icons/${each}.png"
    if [ ! -f $file ]; then
        echo "ERROR: file not found: $file"
        error="yes"
    fi
done

[ $error == "yes" ] && exit 1
