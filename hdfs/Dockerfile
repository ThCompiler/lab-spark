# FROM ubuntu:18.04

# RUN apt-get update -y \
#     && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
#         sudo \
#         wget \
#         openjdk-8-jdk \
#     && apt-get clean
FROM eclipse-temurin:8-jdk-focal
RUN apt-get update -y \
    && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
        sudo \
        curl \
        ssh \
    && apt-get clean

RUN useradd -m hduser && echo "hduser:supergroup" | chpasswd && adduser hduser sudo && echo "hduser     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && cd /usr/bin/ && sudo ln -s python3 python

WORKDIR /home/hduser
USER hduser
ENV HADOOP_VERSION=3.3.3
ENV HADOOP_HOME /home/hduser/hadoop-${HADOOP_VERSION}
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /home/hduser/ \
 && rm -rf ${HADOOP_HOME}/share/doc

ENV HDFS_NAMENODE_USER hduser
ENV HDFS_DATANODE_USER hduser
ENV HDFS_SECONDARYNAMENODE_USER hduser

ENV YARN_RESOURCEMANAGER_USER hduser
ENV YARN_NODEMANAGER_USER hduser

ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin


EXPOSE 50070 50075 50010 50020 50090 8020 9000 9864 9867 9870 10020 19888 8088 8030 8031 8032 8033 8040 8042 22

WORKDIR /home/hduser

