#!/bin/bash

# Script for building and signing RPM-package

# Variables
TARGET="AuroraOS-5.1.3.85-MB2-armv7hl"
PACKAGE_NAME="ru.yareg.game"
VERSION="1.1"
RELEASE="1"
ARCH="armv7hl"
RPM_FILE="RPMS/${PACKAGE_NAME}-${VERSION}-${RELEASE}.${ARCH}.rpm"
KEY_FILE="regular_key.pem"
CERT_FILE="regular_cert.pem"

#1. Loading generate.sh
sfdk engine exec sb2 -t $TARGET bash generate.sh

#2. Building package
echo "Starting building process"
sfdk engine exec mb2 -t $TARGET build-init
sfdk engine exec mb2 -t $TARGET prepare
sfdk engine exec mb2 -t $TARGET build

#3. Signing RPM-package
echo "Signing RPM-package"
rpmsign-external sign --key $KEY_FILE --cert $CERT_FILE $RPM_FILE

#4. Package Validation
echo "Checking package"
rpm-validator -p regular $RPM_FILE

echo "Process completed"
