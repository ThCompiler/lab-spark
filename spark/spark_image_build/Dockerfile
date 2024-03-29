FROM ubuntu:20.04

ENV hadoop_ver 3.3.6
ENV spark_ver 3.4.2

RUN apt-get update && \
    apt-get -y install openjdk-8-jdk && \
    apt-get install -y python-numpy && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Get Hadoop from US Apache mirror and extract just the native
# libs. (Until we care about running HDFS with these containers, this
# is all we need.)
RUN mkdir -p /opt && \
    cd /opt && \
    curl https://dlcdn.apache.org/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

# Get Spark from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
    curl -L https://dlcdn.apache.org/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop3.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop3 spark && \
    echo Spark ${spark_ver} installed in /opt

# Add the GCS connector.
RUN mkdir -p /opt/spark/lib && \
    cd /opt/spark/lib && \
    curl -O https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar

# if numpy is installed on a driver it needs to be installed on all
# workers, so install it everywhere
#RUN sed -i '/security.debian.org jessie/d' /etc/apt/sources.list && \
 #   sed -i '/jessie-updates/d' /etc/apt/sources.list && \
 #   apt-get update && \
 #   apt-get install -y python-numpy && \
 #   apt-get clean && \
 #   rm -rf /var/lib/apt/lists/*

ADD log4j.properties /opt/spark/conf/log4j.properties
ADD start-common.sh start-worker start-master /
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ENV PATH $PATH:/opt/spark/bin
