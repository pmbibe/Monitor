#!/bin/bash
# Check GO exist or not
# 2>&1 output command
function checkGo {
    go version > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo "Done"
    else
        installGo
    fi
}
function installGo {
    yum -y install wget
    wget https://dl.google.com/go/go1.15.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz && rm -rf go1.15.linux-amd64.tar.gz
    echo """export PATH=$PATH:/usr/local/go/bin""" >> /etc/profile
    . /etc/profile
    checkGo
}
checkGo