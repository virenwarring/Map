#!/bin/bash
timeda=$(date)
dirc=$(pwd)
if [ "$1" == "" ] || [ "$2" == "" ]; then
echo
echo "Hello $USER!"
echo
echo '!!!!!!!Arguments are not provided!!!!!!!'
echo
echo "Please use the Syntax as mentioned below"
echo "Example: [$USER@server]$ ./keymatch.sh file.key file.crt"
echo
echo 'The first argument "file.key" is a key file'
echo 'The second argument "file.crt" is a certificate file'
echo
exit
fi
openssl rsa -in $1 -check > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo
  echo "Hello $USER! Please provide the proper File"
  echo
  exit 1
  fi
openssl x509 -in $2 -noout > /dev/null  2>&1
if [ $? -eq 1 ]
then
  echo
  echo "Hello $USER! Please Provide the Proper Cert File"
  echo
  exit 1
fi
echo Current Directory: $dirc
echo User: $USER $timeda
echo
key=$(openssl rsa -modulus -noout -in $1 | openssl md5)
cert=$(openssl x509 -modulus -noout -in $2 | openssl md5)
echo The Hash of Key is $key
echo The Hash of Crt is $cert
if [ "$key" = "$cert" ]
then
  echo "Result: The key matched."
  echo
else
  echo "Result: The key does not match."
  echo
fi
read -sn1 -p "Press any key to exit"
echo
exit 0
