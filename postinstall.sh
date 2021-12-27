arch_name="$(uname -m)"
filename=""
DMGsPath="/private/var/tmp/AdobeCC"
AdobeMountPath="/Volumes/Creative Cloud"


dmgInstall (){
    hdiutil mount "${DMGsPath}"/"${filename}"
	sudo "${AdobeMountPath}"/Install.app/Contents/MacOS/Install --mode=silent
    hdiutil unmount -force "${AdobeMountPath}"
    rm -rf ${DMGsPath}
}

armVersion () {
    echo "==== ARM Adobe CC START Install ===="
    filename="ACCCx5_6_0_788M1.dmg"
    dmgInstall
    echo "==== ARM Adobe END Install ===="
}

intelVersion () {
    echo "==== Intel Adobe CC START Install ===="
    filename="ACCCx5_6_0_788.dmg"
    dmgInstall
    echo "==== Intel ARM Adobe END Install ===="
}


if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
        armVersion
    else
        intelVersion
    fi
    elif [ "${arch_name}" = "arm64" ]; then
    armVersion
else
    exit 1  ## Fail
fi

exit 0		## Success
