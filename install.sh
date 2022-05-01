#!/usr/bin/env bash                      
normal=$'\e[0m'                           
bold=$(tput bold)                         
red="$bold$(tput setaf 1)"               
green=$(tput setaf 2)                     
fawn=$(tput setaf 3); beige="$fawn"       
yellow="$bold$fawn"                       
darkblue=$(tput setaf 4)                  
blue="$bold$darkblue"                     
purple=$(tput setaf 5); magenta="$purple" 
pink="$bold$purple"                       
darkcyan=$(tput setaf 6)                  
cyan="$bold$darkcyan"                     
gray=$(tput setaf 7)                      
darkgray="$bold"$(tput setaf 0)           
white="$bold$gray"
tag="${cyan}[${fawn}MSI${cyan}]${normal}"

modloader=0

function forge () {
    mcversion=0
    forgeversion=0
    echo "${tag} This script only supports versions 1.10+ and 1.5.2-1.6.4!"
    echo "${tag} Enter minecraft version"
    read -p "> " mcversion
    echo "${tag} Enter forge version"
    read -p "> " forgeversion
    echo "${tag} Downloading server"
    curl -OJ -s "https://maven.minecraftforge.net/net/minecraftforge/forge/${mcversion}-${forgeversion}/forge-${mcversion}-${forgeversion}-installer.jar" -o forge-installer.jar
    echo "${tag} Installing server in current directory"
    java -jar "forge-${mcversion}-${forgeversion}-installer.jar" --installServer >> /dev/null
    echo "$tag Cleaning up"
    if [[ -f "run.bat" ]]
    then
        rm run.bat && rm "forge-${mcversion}-${forgeversion}-installer.jar.log"
    fi
    echo "${tag} All finished!"

}

function fabric () {
    echo "fabric"
}

function quilt () {
    echo "quilt"
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