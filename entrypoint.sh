#!/bin/bash

# fix aws dependencies
#cp /opt/bigstepdatalake-0.12.3/lib/aws-java-sdk-1.7.4.jar /presto/plugin/hive-hadoop2/
#rm /presto/plugin/hive-hadoop2/gcs-connector-hadoop2-1.9.10.jar
#rm /presto/plugin/hive-hadoop2/gcsio-1.9.10.jar
rm /presto/plugin/hive-hadoop2/jackson-core-2.9.8.jar
rm /presto/plugin/hive-hadoop2/jackson-databind-2.9.8.jar	
rm /presto/plugin/hive-hadoop2/jackson-datatype-joda-2.9.8.jar

#cp /opt/bigstepdatalake-0.12.3/lib/aws-java-sdk-1.7.4.jar /presto/etc/data/plugin/hive-hadoop2/
#rm /presto/etc/data/plugin/hive-hadoop2/gcs-connector-hadoop2-1.9.10.jar
#rm /presto/etc/data/plugin/hive-hadoop2/gcsio-1.9.10.jar
rm /presto/etc/data/plugin/hive-hadoop2/jackson-core-2.9.8.jar
rm /presto/etc/data/plugin/hive-hadoop2/jackson-databind-2.9.8.jar	
rm /presto/etc/data/plugin/hive-hadoop2/jackson-datatype-joda-2.9.8.jar



rm /opt/bigstepdatalake-0.12.3/lib/bdl-client-libraries-0.12.3.jar
rm /presto/plugin/hive-hadoop2/bdl-client-libraries-0.12.3.jar

#wget https://repo.lentiq.com/bdl-client-libraries-0.12.3.test.jar
#cp --verbose bdl-client-libraries-0.12.3.test.jar /opt/bigstepdatalake-0.12.3/lib/
#cp --verbose bdl-client-libraries-0.12.3.test.jar  /presto/plugin/hive-hadoop2/

#mkdir -p /presto/etc/data/plugin/hive-hadoop2/ 

#cp --verbose bdl-client-libraries-0.12.3.test.jar /presto/etc/data/plugin/hive-hadoop2/

./tmp/docker-presto.sh

launcher run
