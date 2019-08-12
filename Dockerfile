FROM openjdk:8-jre-slim

ENV PRESTO_VERSION=215
ENV BDLCL_VERSION=0.12.3

ENV PRESTO_HOME /presto
ENV PRESTO_USER presto
ENV PRESTO_CONF_DIR ${PRESTO_HOME}/etc
ENV PATH $PATH:$PRESTO_HOME/bin

ENV BDLCL_HOME /opt/bigstepdatalake-$BDLCL_VERSION
ENV PRESTO_USER presto
ENV PYTHON2_DEBIAN_VERSION 2.7.13-2

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated curl wget less && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 
    
USER root

RUN useradd \
		--create-home \
		--home-dir ${PRESTO_HOME} \
        --shell /bin/bash \
		$PRESTO_USER

RUN wget https://github.com/prestosql/presto/archive/0.$PRESTO_VERSION.tar.gz && \
#https://repo1.maven.org/maven2/io/prestosql/presto-server/$PRESTO_VERSION/presto-server-$PRESTO_VERSION.tar.gz && \
   # tar xzvf presto-server-$PRESTO_VERSION.tar.gz && \
   # rm presto-server-$PRESTO_VERSION.tar.gz && \
   # mv presto-server-${PRESTO_VERSION}/* $PRESTO_HOME && \
   # rm -rf presto-server-${PRESTO_VERSION} && \
    tar xzvf 0.$PRESTO_VERSION.tar.gz && \
    rm 0.$PRESTO_VERSION.tar.gz && \
    mv presto-0.${PRESTO_VERSION}/* $PRESTO_HOME && \
    rm -rf presto-0.${PRESTO_VERSION} && \
    mkdir -p ${PRESTO_CONF_DIR}/catalog/ && \
    mkdir -p ${PRESTO_HOME}/data && \
    cd ${PRESTO_HOME}/bin && \
    wget https://repo1.maven.org/maven2/io/prestosql/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar && \
    mv presto-cli-${PRESTO_VERSION}-executable.jar presto && \
    chmod +x presto && \
#    chown -R ${PRESTO_USER}:${PRESTO_USER} $PRESTO_HOME && \ 
    cd /opt && \
    wget https://repo.lentiq.com/bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    tar xzvf bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    rm -rf bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    cp $BDLCL_HOME/lib/* $PRESTO_HOME/plugin/hive-hadoop2/ && \
    rm $PRESTO_HOME/plugin/hive-hadoop2/aws-java-sdk-1.7.4.jar && \
    mkdir /etc/presto 
       
ADD presto.sh /etc/presto/docker-presto.sh
ADD healthcheck.sh /etc/presto/
ADD entrypoint.sh /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
		python="${PYTHON2_DEBIAN_VERSION}" \
	&& rm -rf /var/lib/apt/lists/* \
    && cd /usr/local/bin \
	&& rm -rf idle pydoc python python-config && \
	chmod 777 -R /etc/presto && \
	chmod 777 /etc/presto/docker-presto.sh && \
	chmod 777 /etc/presto/healthcheck.sh && \
	chmod 777 /opt/entrypoint.sh
RUN cp /etc/presto/docker-presto.sh /tmp && \
    chmod 777 /tmp/docker-presto.sh 
    

#USER $PRESTO_USER

#      PrestoUI
EXPOSE 8080

ENTRYPOINT ["./opt/entrypoint.sh"]
