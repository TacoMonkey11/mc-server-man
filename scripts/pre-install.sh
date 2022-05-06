#!/usr/bin/env bash
normal=$'\e[0m'                                                            
brown=$(tput setaf 94)                
green=$(tput setaf 2)                   
tag="${green}[${brown}MSI${green}]${normal}"

checks=0 && declare -i checks

checkJava() {
    javaVersion=$1
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        if [[ $javaVersion == "1.8" ]]; then 
            javaVersion="8"
        fi
        if ls /usr/lib/jvm | grep -q $javaVersion; then 
            printf "${tag} Java ${javaVersion} has been detected\n"
            checks+=1
        else 
            printf "${tag} Java ${javaVersion} has NOT been detected, it may not be installed\n"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then 
        if /usr/libexec/java_home -v $javaVersion >/dev/null; then 
            printf "${tag} Java ${javaVersion} has been detected\n"
            checks+=1
        else 
            printf "${tag} Java ${javaVersion} has NOT been detected, it may not be installed\n"
        fi
    fi
}

checkCommand() {
    if command -v $1 >/dev/null; then
        printf "${tag} ${1} has been detected\n"
        checks+=1
    else 
        printf "${tag} ${1} has not been detected\n"
        if [[$1 == "yq"]]; then
            printf "You can get it from the snap store on linux\n"
        fi
    fi
}

if [[ $PWD != *"/mc-server-installer/scripts" ]]; then
    printf "${tag} You are NOT running this script in the right directory! Please run it's own folder\n"
    exit
fi

if [[ "$OSTYPE" != "linux-gnu" ]] && [[ "$OSTYPE" != "darwin"* ]]; then 
    printf "${tag} You are not using a tested OS! Things may break!\n"
fi

checkJava "1.8" && checkJava "17"
checkCommand "tmux" && checkCommand "yq"

if [[ ${checks} == 4 ]]; then 
    printf "\n${tag} Passed all checks. Moving on.\n\n"
else 
    printf "\n${tag} Some checks have failed, exiting\n\n"
    exit
fi

printf "${tag} Final step is to symlink the script, run the following as root: "
chmod +x servermanager
if [[ "$OSTYPE" == "linux-gnu" ]]; then
printf "ln -snf ${PWD}/servermanager /usr/bin/"
elif [[ "$OSTYPE" == "darwin"* ]]; then
printf "ln -snf ${PWD}/servermanager /usr/local/bin/"
fi