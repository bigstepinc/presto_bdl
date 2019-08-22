#!/bin/bash

cp --verbose /etc/presto/*.properties /presto/etc
cp --verbose /etc/presto/*.config /presto/etc
cp --verbose /etc/presto/catalog/*properties /presto/etc/catalog

rm /presto/plugin/hive-hadoop2/jackson-databind-2.8.9.jar
