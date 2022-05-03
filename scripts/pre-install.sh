#!/usr/bin/env bash
normal=$'\e[0m'                                                            
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

checkCommand() {
    if command -v $1 >/dev/null
    then
        echo -e "${tag} ${1} has been detected"
        checks+=1
    else 
        echo "${tag} ${1} has not been detected"
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
checkCommand "tmux" && checkCommand "yq"

if [[ ${checks} == 4 ]] 
then 
    echo -e "\n${tag} Passed all checks. Moving on.\n"
else 
    echo -e "\n${tag} Some checks have failed, exiting\n"
    exit
fi

echo "${tag} Symlinking script"
chmod +x servermanager
if [[ "$OSTYPE" == "linux-gnu" ]]
then
    ln -snf "${PWD}/servermanager" "/usr/bin/"
elif [[ "$OSTYPE" == "darwin"* ]]
then
    ln -snf "${PWD}/servermanager" "/usr/local/bin"
fi