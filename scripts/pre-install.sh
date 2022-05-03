#!/usr/bin/env bash
normal=$'\e[0m'                           
bold=$(tput bold)                                      
brown=$(tput setaf 94)                
green=$(tput setaf 2)                   
tag="${green}[${brown}MSI${green}]${normal}"

checks=0
declare -i checks

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
            checks+=1
        else 
            echo "${tag} Java ${javaVersion} has NOT been detected, it may not be installed"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then 
        if /usr/libexec/java_home -v $javaVersion >/dev/null
        then 
            echo "${tag} Java ${javaVersion} has been detected"
            checks+=1
        else 
            echo "${tag} Java ${javaVersion} has NOT been detected, it may not be installed"
        fi
    fi
}

checkTmux() {
    if command -v tmux >/dev/null
    then
        echo -e "${tag} Tmux has been detected\n"
        checks+=1
    else 
        echo "${tag} Tmux has not been detected"
    fi
}

if [[ $PWD != *"/mc-server-installer/scripts" ]] 
then
    echo "${tag} You are NOT running this script in the right directory! Please run it's own folder"
    exit
fi

if [[ "$OSTYPE" != "linux-gnu" ]] && [[ "$OSTYPE" != "darwin"* ]]; then 
    echo "${tag} You are not using a tested OS! Things may break!"
fi

checkJava "1.8" && checkJava "17"
checkTmux

if [[ ${checks} == 3 ]] 
then 
    echo -e "${tag} Passed all checks. Moving on.\n"
else 
    echo "${tag} Some checks have failed, exiting\n"
    return 0
    exit
fi

echo "${tag} Symlinking script"
chmod +x setup-server
if [[ "$OSTYPE" == "linux-gnu" ]]
then
    ln -snf "${PWD}/setup-server" "/usr/bin/"
elif [[ "$OSTYPE" == "darwin"* ]]
then
    ln -snf "${PWD}/setup-server" "/usr/local/bin"
fi