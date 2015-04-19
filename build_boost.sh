#!/bin/bash
# Bash script to build the boost library
# Copyright 2015 Andy Lawrence

# Set the boost version
BOOST_VERSION="1_58_0"
BOOST_BASENAME=boost_$BOOST_VERSION

# Check that the archives directory exists
cd ..
echo "Extracting boost archive"
if [ ! -d ./archives ]; then
    echo "Can not find archives directory"
    return 1
fi
if [ ! -f ./archives/$BOOST_BASENAME.tar.gz ]; then
    echo "Can not find boost archives"
    return 2
fi
cd ./archives

# if the directory already exists delete it
if [ -d ./$BOOST_BASENAME ]; then 
    echo "Deleting existing directory"
    rm -r ./$BOOST_BASENAME
fi
tar -xvf $BOOST_BASENAME.tar.gz

# cd into the directory and build boost
if [ ! -d ./$BOOST_BASENAME ]; then 
    echo "Can not find boost directory"
    return 3
fi
cd ./$BOOST_BASENAME
./bootstrap.sh --prefix=../$BOOST_BASENAME
./b2 variant=debug link=shared threading=multi address-model=64 install
