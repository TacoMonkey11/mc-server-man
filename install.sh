#!/usr/bin/env bash                      
normal=$'\e[0m'                           
bold=$(tput bold)                                      
fawn=$(tput setaf 3); beige="$fawn"                    
cyan="$bold$darkcyan"                     
tag="${cyan}[${fawn}MSI${cyan}]${normal}"

modloader=0

function forge () {
    mcversion=0
    forgeversion=0
    echo "${tag} This script only supports forge minecraft versions 1.10+ and 1.5.2-1.6.4!"
    echo "${tag} Enter minecraft version"
    read -p "> " mcversion
    echo "${tag} Enter fabric loader version"
    read -p "> " forgeversion
    echo "${tag} Downloading server"
    curl -OJ -s "https://maven.minecraftforge.net/net/minecraftforge/forge/${mcversion}-${forgeversion}/forge-${mcversion}-${forgeversion}-installer.jar"
    java -jar forge-${mcversion}-${forgeversion}-installer.jar --installServer >> /dev/null
    echo "$tag Cleaning up"
    if [[ -f "run.bat" ]]
    then
        rm run.bat && rm "forge-${mcversion}-${forgeversion}-installer.jar.log"
    fi
    echo "${tag} All finished!"

}

function fabric () {
    mcversion=0
    fabricversion=0
    echo "${tag} Fabric only supports versions 1.14+!"
    echo "${tag} Enter minecraft version (leave empty for latest)"
    read -p "> " mcversion
    echo "${tag} Enter fabric loader version (leave empty for latest)"
    read -p "> " fabricversion
    echo "${tag} Downloading server"
    curl -OJ -s "https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.10.2/fabric-installer-0.10.2.jar"
    echo "${tag} Installing server"
    if [[ $mcversion == "" ]]; then
        if [[ $fabricversion == "" ]]; then
            java -jar fabric-installer-0.10.2.jar server >/dev/null
        else
            java -jar fabric-installer-0.10.2.jar server -loader ${fabricversion} >/dev/null
        fi
    else 
        if [[ $fabricversion == "" ]]; then
            java -jar fabric-installer-0.10.2.jar server -mcversion ${mcversion} >/dev/null
        else 
            java -jar fabric-installer-0.10.2.jar server -mcversion ${mcversion} -loader ${fabricversion} >/dev/null
        fi
    fi
    echo "${tag} Cleaning up"
    rm fabric-installer-0.10.2.jar
}

function quilt () {
    mcversion=0
    quiltversion=0
    echo "${tag} Quilt only supports versions 1.14+!"
    echo "${tag} Enter minecraft version"
    read -p "> " mcversion
    echo "${tag} Enter quilt loader version (leave empty for latest)"
    read -p "> " quiltversion
    echo "${tag} Downloading server"
    curl -OLJ -s "https://maven.quiltmc.org/repository/release/org/quiltmc/quilt-installer/latest/quilt-installer-latest.jar"
    echo "${tag} Installing server"
    if [[ $quiltversion == "" ]]; then 
        java -jar quilt-installer-latest.jar install server ${mcversion} --download-server >/dev/null
    else 
        java -jar quilt-installer-latest.jar install server ${mcversion} ${quiltversion} --install-dir=.. --download-server >/dev/null
    fi
    echo "${tag} Cleaning up"
    rm quilt-installer-latest.jar
    mv server/* . && rm -r server
}

echo -ne "
${fawn}${bold}MC SERVER INSTALLER
${cyan}-------------------

${tag} Select Mod Loader

${cyan}(${fawn}1${cyan})${normal} Forge
${cyan}(${fawn}2${cyan})${normal} Fabric
${cyan}(${fawn}3${cyan})${normal} Quilt

"
read -p "> " modloader
case $modloader in

  "1")
    forge
    ;;

  "2")
    fabric
    ;;

  "3")
    quilt
    ;;

  *)
    echo "That's not a modloader!"
    ;;
esac