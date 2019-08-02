#!/bin/bash

cp /etc/presto/*.properties /presto/etc
cp /etc/presto/*.config /presto/etc
cp /etc/presto/catalog/*properties /presto/etc/catalog
launcher run
