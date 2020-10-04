#!/bin/bash
#########################################################
#                                                       #
#   Name: Database Creator                              #
#   Author: Diego Castagna (diegocastagna.com)          #
#   Description: This script will create                #
#   a new database and the associated user with         #
#   all privileges on the database                      #
#   License: diegocastagna.com/license                  #
#                                                       #
#########################################################

# Constants
WEBSITE="diegocastagna.com"
SCRIPTNAME="DATABASE_CREATOR"
PREFIX="[$WEBSITE][$SCRIPTNAME]"

# Variables
dbName="${1}"
dbPass=$(openssl rand -base64 32)

# Performing some checks
if [[ $EUID -ne 0 ]]; then
    echo "$PREFIX This script must be run as root or with sudo privileges"
    exit 1
fi
if [ $# -le 0 ]; then
    echo "Usage: ${0} DBName"
    echo "Remember: Do not use special char in database name"
    exit 1
fi

echo "$PREFIX Starting the script.."
echo "$PREFIX Creating Database and associated user.."
mysql -u root <<_EOF_
CREATE DATABASE ${dbName};
CREATE USER '${dbName}'@'localhost' IDENTIFIED BY '${dbPass}'
GRANT ALL PRIVILEGES ON ${dbName}.* TO '${dbName}'@'localhost';
FLUSH PRIVILEGES;
_EOF_

echo "$PREFIX Printing out Database autogenerated password.."
echo -e "\n\nPassword: '$dbPass'\n\n"

echo "$PREFIX Script finished!"
echo "$PREFIX Thank you for downloading this script from $WEBSITE"