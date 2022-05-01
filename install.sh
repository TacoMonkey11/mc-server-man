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

modloader=0

function forge () {
    mcversion=0
    echo "Enter Version (1.5+)"
    read -p "> " mcversion
    curl -O --progress-bar "https://raw.githubusercontent.com/TacoMonkey11/mc-server-installer/main/forge.txt"
}

function fabric () {
    echo "fabric"
}

function quilt () {
    echo "quilt"
}

echo -ne "
${green}${bold}MC SERVER INSTALLER

Select Mod Loader
-----------------

(1) Forge
(2) Fabric
(3) Quilt

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