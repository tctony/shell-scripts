#! /bin/sh

if [ $# = 0 ]; then
    echo "Usage: p12_to_pem.sh input.p12 [output.pem]"
    exit -1;
fi

INPUT_FILE=$1
OUTPUT_FILE=$2

if [ -z $OUTPUT_FILE ]; then
    OUTPUT_FILE=$(dirname $INPUT_FILE)/$(basename $INPUT_FILE .p12).pem
fi

openssl pkcs12 -nodes -in $INPUT_FILE -out $OUTPUT_FILE

echo "generated $OUTPUT_FILE"
