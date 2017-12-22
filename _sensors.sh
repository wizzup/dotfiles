#!/usr/bin/env bash

if [ "$1" == "--cpu" ];
then sensors k10temp-pci-00c3 | grep temp1 | awk '{print $2}'
fi

if [ "$1" == "--gpu" ];
then sensors nouveau-pci-0200 | grep temp1 | awk '{print $2}'
fi
