#!/usr/bin/env bash

function usage () {
    echo "Usage:"
    echo "$0 -f file -i conf\n"
    echo "-f file: mysql binary package"
    echo "-i conf: mysql configuration file"
    exit 1
}

while getopts ':f:i:' OPT; do
   case "${OPT}" in
       f) INSTALL_PACKAGE=${OPTARG};;
       i) CONFIG_FILE=${OPTARG};;
       *) usage;;
   esac
done

BASE_DIR="/usr/local/mysql"
DATA_BASE_DIR="/db"
DATA_DIR="${DATA_BASE_DIR}/data"
RUN_DIR="${DATA_BASE_DIR}/run"
LOG_DIR="${DATA_BASE_DIR}/log"


groupadd -r mysql
useradd -r -g mysql -s /bin/false mysql

