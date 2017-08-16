#! /bin/sh
# add password for user with 'name' to file htpasswd
if [ $# != 1 ]; then
    echo "Usage: htpasswd_add.sh name"
    exit -1;
fi
password=`pwgen 12 1`
echo "$1:`openssl passwd $password`:$password" >> htpasswd
echo "add pair: $1,$password"
