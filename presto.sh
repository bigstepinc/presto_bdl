#!/bin/bash

ls /etc/presto/catalog
sleep 100
ls /etc/presto/catalog
cp --verbose /etc/presto/*.properties /presto/etc
cp --verbose /etc/presto/*.config /presto/etc
cp --verbose /etc/presto/catalog/*properties /presto/etc/catalog
