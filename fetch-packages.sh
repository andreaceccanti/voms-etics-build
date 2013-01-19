#!/bin/bash

base_url=https://raw.github.com/andreaceccanti/voms-etics-build

if [ $# -lt 2 ]; then
	echo "Wrong number of arguments!"
	echo "Usage: $0 srcPackageDir packagesFile [tag]"
	exit 1
fi

srcPackagesDir=$1
packagesFile=$2
tag=master

if [ $# -eq 3]; then
	tag=$3
fi

echo "Starting ETICS VOMS build..."
echo "Downloading packages file..."
wget --no-check-certificate $base_url/$tag/$packagesFile

# Strip comments
sed '/^#/d;/^$/d' $packagesFile > $packagesFile.stripped

if [ ! -d "$srcPackagesDir" ]; then
	echo "Building source packages dir $srcPackagesDir"
	mkdir -p $srcPackagesDir
fi

echo "Downloading source packages..."
wget --no-check-certificate -P $srcPackagesDir -i $packagesFile.stripped

echo "Downloaded source packages:"
ls -l  $srcPackagesDir
