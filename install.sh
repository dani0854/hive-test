#!/bin/sh
set -ex


# Pre
apk add --no-cache --virtual \
    wget                     \
    tar                      \
    gnupg                       
apk add --no-cache \
    procps         \
    bash
mkdir /tmp/hive-test

# Install java
apk add --no-cache openjdk8


# Install hadoop
wget -O /tmp/hive-test/hadoop-keys https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
gpg --import /tmp/hive-test/hadoop-keys                             
wget -P /tmp/hive-test "$APACHE_MIRROR/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"                 
wget -P /tmp/hive-test "https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz.asc" 
gpg --verify /tmp/hive-test/hadoop-$HADOOP_VERSION.tar.gz.asc     
tar xzf /tmp/hive-test/hadoop-$HADOOP_VERSION.tar.gz -C /usr/local


# Install hive
wget -O /tmp/hive-test/hive-keys https://dist.apache.org/repos/dist/release/hive/KEYS
gpg --import /tmp/hive-test/hive-keys                             
wget -P /tmp/hive-test "$APACHE_MIRROR/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz"
wget -P /tmp/hive-test "https://www.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz.asc"
gpg --verify /tmp/hive-test/apache-hive-$HIVE_VERSION-bin.tar.gz.asc
tar zxvf /tmp/hive-test/apache-hive-$HIVE_VERSION-bin.tar.gz -C /usr/local
cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh


# Install postgres driver
wget -P $HIVE_HOME/lib https://jdbc.postgresql.org/download/postgresql-42.2.9.jar


# Clean
rm -r /tmp/hive-test
apk del  \
    wget \
    tar  \
    gnupg                   
rm /tmp/install.sh
