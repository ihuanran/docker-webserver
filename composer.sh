#!/bin/bash

# create the php composer container for docker and execute the command.
# You can put this file in PATH to perform "composer.sh install/update" in the project directory.

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
    print_style "   install <dir/default pwd>" "success"; printf "\t\t\t composer install.\n"
    print_style "   update <dir/default pwd>" "success"; printf "\t\t\t composer update.\n"
    printf "and the other composer command.\n"
}

isCommand() {
  for cmd in \
    "about" \
    "archive" \
    "browse" \
    "clear-cache" \
    "clearcache" \
    "config" \
    "create-project" \
    "depends" \
    "diagnose" \
    "dump-autoload" \
    "dumpautoload" \
    "exec" \
    "global" \
    "help" \
    "home" \
    "info" \
    "init" \
    "install" \
    "licenses" \
    "list" \
    "outdated" \
    "prohibits" \
    "remove" \
    "require" \
    "run-script" \
    "search" \
    "self-update" \
    "selfupdate" \
    "show" \
    "status" \
    "suggests" \
    "update" \
    "validate" \
    "why" \
    "why-not"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

runDir='';

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
elif [ $# -eq 1 ]; then
    runDir=$(pwd)
else
    runDir=$2
fi

if ! isCommand "$1"; then
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi

command="docker run --rm --interactive --tty --volume /tmp:/tmp --volume $runDir:/app huanran/composer $1"

print_style "run the command:";
print_style "$command\n" "success";

eval ${command}