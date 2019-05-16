FROM openjdk:8-jre-slim

ENV PRESTO_VERSION=311
ENV BDLCL_VERSION=0.12.1
ENV PRESTO_HOME /opt/presto
ENV BDLCL_HOME /opt/bigstepdatalake-$BDLCL_VERSION
ENV PRESTO_USER presto
ENV PRESTO_CONF_DIR ${PRESTO_HOME}/etc
ENV PATH $PATH:$PRESTO_HOME/bin
ENV PYTHON2_DEBIAN_VERSION 2.7.13-2

ADD presto.sh /etc/presto
ADD healthcheck.sh /etc/presto

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated curl wget less && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
    
USER root

RUN useradd \
		--create-home \
		--home-dir ${PRESTO_HOME} \
        --shell /bin/bash \
		$PRESTO_USER

RUN cd /opt && \
    wget https://repo1.maven.org/maven2/io/prestosql/presto-server/$PRESTO_VERSION/presto-server-$PRESTO_VERSION.tar.gz && \
    tar xzvf presto-server-$PRESTO_VERSION.tar.gz && \
    rm presto-server-$PRESTO_VERSION.tar.gz && \
    mv presto-server-${PRESTO_VERSION}/* $PRESTO_HOME && \
    rm -rf presto-server-${PRESTO_VERSION} && \
    mkdir -p ${PRESTO_CONF_DIR}/catalog/ && \
    mkdir -p ${PRESTO_HOME}/data && \
    cd ${PRESTO_HOME}/bin && \
    wget https://repo1.maven.org/maven2/io/prestosql/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar && \
    mv presto-cli-${PRESTO_VERSION}-executable.jar presto && \
    chmod +x presto && \
    chown -R ${PRESTO_USER}:${PRESTO_USER} $PRESTO_HOME && \ 
    cd /opt && \
    wget https://repo.lentiq.com/bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    tar xzvf bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    rm -rf bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    cp $BDLCL_HOME/lib/* $PRESTO_HOME/plugin/hive-hadoop2/

# Need to work with python2
# See: https://github.com/prestodb/presto/issues/4678
RUN apt-get update && apt-get install -y --no-install-recommends \
		python="${PYTHON2_DEBIAN_VERSION}" \
	&& rm -rf /var/lib/apt/lists/* \
    && cd /usr/local/bin \
	&& rm -rf idle pydoc python python-config 

USER $PRESTO_USER

#      PrestoUI
EXPOSE 8080

CMD ["launcher", "run"]
