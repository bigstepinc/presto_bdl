#!/bin/bash

curl --silent $PRESTO_APP_NAME:8080/v1/node | tr "," "\n" | grep --silent $(hostname -i)
