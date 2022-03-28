#!/usr/bin/env bash
# Author: JialeHao
# Version: 1.0

CONFIG_PATH='.ssh'
CONFIG_FILE='.ssh/config'

function usage() {
    cat <<EOF
Usage:

1.Add a ssh client configuration
    $0 -a -h host -i ip_address -u ssh_user -p ssh_port

2.Delete a ssh client configuration
    $0 -d host
EOF
    exit 1
}

function checkenv() {
    cd ~
    if [ ! -d $CONFIG_PATH ]; then
        mkdir $CONFIG_PATH
        chmod -R 700 $CONFIG_PATH
    elif [ ! -f $CONFIG_FILE ]; then
        touch $CONFIG_FILE
    fi
}

function add_config() {
    while getopts :h:i:u:p: argv; do
        case $argv in
        "h")
            host=$OPTARG
            ;;
        "i")
            ipaddr=$OPTARG
            ;;
        "u")
            sshuser=$OPTARG
            ;;
        "p")
            sshport=$OPTARG
            ;;
        *)
            usage
            ;;
        esac
    done
    echo -e "Host $host\n  HostName $ipaddr\n  User $sshuser\n  Port $sshport\n" >> $CONFIG_FILE
}

function delete_config() {
    for host in $@; do
        sed -i "/^Host $host$/,+4d" ~/$CONFIG_FILE
        echo "- delete $host"
    done
}

function exec_config() {
    checkenv
    case $1 in
    "--help")
        usage
        ;;
    "-a")
        shift
        add_config $@
        ;;
    "-d")
        shift
        delete_config $@
        ;;
    *)
        echo "\n\tWrong parameters are provided!"
        usage
        ;;
    esac
}

exec_config $@
