#!/bin/bash

DOMAIN=gcp2.mfisch.io

set -e
echo "Generating CA"
openssl genrsa -out ${DOMAIN}-CA.key 2048
openssl req -x509 -new -nodes -key ${DOMAIN}-CA.key -sha256 -days 1024 -out ${DOMAIN}-CA.pem -config config.CA

echo "Generating CSRs"
openssl req -newkey rsa:2048 -nodes -keyout central.${DOMAIN}.key -config config.central -out central.${DOMAIN}.csr
openssl req -newkey rsa:2048 -nodes -keyout west.${DOMAIN}.key -config config.west -out west.${DOMAIN}.csr

echo "Generating Certs"
openssl x509 -req -in central.${DOMAIN}.csr  -CA ${DOMAIN}-CA.pem -CAkey ${DOMAIN}-CA.key -CAcreateserial -out central.${DOMAIN}.pem -days 1024 -sha256 -extfile config.CA -extensions req_ext
openssl x509 -req -in west.${DOMAIN}.csr  -CA ${DOMAIN}-CA.pem -CAkey ${DOMAIN}-CA.key -CAcreateserial -out west.${DOMAIN}.pem -days 1024 -sha256 -extfile config.CA -extensions req_ext

echo "Convert key to PEM so credhub is happy"
openssl rsa -in west.${DOMAIN}.key -out west.${DOMAIN}.key.pem -outform PEM
openssl rsa -in central.${DOMAIN}.key -out central.${DOMAIN}.key.pem -outform PEM

