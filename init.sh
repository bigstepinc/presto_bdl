#!/bin/bash

# define the config.properties file
touch /presto/etc/config.properties
if [ "$MODE" == "coordinator" ]; then
	echo "coordinator=true" >> /presto/etc/config.properties
  echo "node-scheduler.include-coordinator=false"  >> /presto/etc/config.properties
  echo "http-server.http.port=8080" >> /presto/etc/config.properties
  echo "query.max-memory=4GB" >> /presto/etc/config.properties
  echo "query.max-memory-per-node=1GB" >> /presto/etc/config.properties
  echo "discovery-server.enabled=true" >> /presto/etc/config.properties
else 
  echo "coordinator=false" >> /presto/etc/config.properties
  echo "http-server.http.port=8080" >> /presto/etc/config.properties
  echo "query.max-memory=4GB" >> /presto/etc/config.properties
  echo "query.max-memory-per-node=1GB" >> /presto/etc/config.properties
fi

if [ "$DISCOVERY_URI" != "" ]; then
      echo "discovery.uri=http://$DISCOVERY_URI:8080"  >> /presto/etc/config.properties
fi

cp /presto/etc/config.properties /etc/presto/config.properties
cp /etc/presto/jvm.config /presto/etc/jvm.config
cp /etc/presto/log.properties /presto/etc/log.properties



