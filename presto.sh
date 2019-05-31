#!/bin/bash

./etc/presto/init.sh

cp /etc/presto/*.properties $PRESTO_CONF_DIR
cp /etc/presto/*.config $PRESTO_CONF_DIR
cp /etc/presto/catalog/*properties $PRESTO_CONF_DIR/catalog
launcher run
