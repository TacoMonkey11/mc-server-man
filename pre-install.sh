#!/usr/bin/env sh
normal=$'\e[0m'                           
bold=$(tput bold)                                      
brown=$(tput setaf 94)                
green=$(tput setaf 2)                   
tag="${green}[${brown}MSI${green}]${normal}"

checkJava() {
    javaVersion=$1
    if [[ "$OSTYPE" == "linux-gnu" ]] 
    then 
        if [[ $javaVersion == "1.8" ]]
        then 
            javaVersion="8"
        fi
        if ls /usr/lib/jvm | grep -q $javaVersion
        then 
            echo "${tag} Java ${javaVersion} has been detected"
        else 
            echo "${tag} Java ${javaVersion} has NOT been detected, it may not be installed"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then 
        if /usr/libexec/java_home -v $javaVersion >/dev/null
        then 
            echo "${tag} Java ${javaVersion} has been detected"
        else 
            echo "${tag} Java ${javaVersion} has NOT been detected, it may not be installed"
        fi
    fi
}

checkTmux() {
    if command -v tmux >/dev/null
    then
        echo "${tag} Tmux has been detected"
    else 
        echo "${tag} Tmux has not been detected"
    fi
}

if [[ "$OSTYPE" != "linux-gnu" ]] && [[ "$OSTYPE" != "darwin"* ]]; then 
    echo "${tag} You are not using a tested OS! Things may break!"
fi

checkJava "1.8" && checkJava "17"
checkTmux


