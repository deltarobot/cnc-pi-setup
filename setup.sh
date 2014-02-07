#!/bin/sh

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $dir
. $dir/runner.sh

function rootPassword {
    echo -n "Enter password for root account: "
    read -s password1
    echo
    echo -n "Confirm password for root account: "
    read -s password2
    echo
    cat << FILE
$password1
$password2
FILE
}

function addUsers {
    groupadd cnc
    useradd -m -g cnc cnc
    echo -n "Enter password for the cnc account: "
    read -s password
    echo
    passwd cnc << FILE
$password
$password
FILE
}

runWithRetry rootPassword addUsers

