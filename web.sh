#!/bin/bash

print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options:\n";
    print_style "   up" "success"; printf "\t\t\t Starts docker-sync and runs docker compose.\n"
    print_style "   stop" "success"; printf "\t\t\t Stops containers and docker-sync.\n"
    print_style "   sync" "info"; printf "\t\t\t Manually triggers the synchronization of files.\n"
    print_style "   clean" "danger"; printf "\t\t Removes all files from docker-sync.\n"
}

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
fi

source ~/.bashrc

cd /mnt/d/docker

if [ "$1" == "up" ] ; then
    print_style "Initializing Docker Sync\n" "info"
    docker-sync start;

    print_style "Initializing Docker Compose\n" "info"
    docker-compose up -d

elif [ "$1" == "stop" ]; then
    print_style "Stopping Docker Compose\n" "info"
    docker-compose stop

    print_style "Stopping Docker Sync\n" "info"
    docker-sync stop

elif [ "$1" == "sync" ]; then
    print_style "Manually triggering sync between host and docker-sync container.\n" "info"
    docker-sync sync;

elif [ "$1" == "clean" ]; then
    print_style "Removing and cleaning up files from the docker-sync container.\n" "warning"
    docker-sync clean

else
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi
