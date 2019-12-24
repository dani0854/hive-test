FROM alpine

ARG HADOOP_VERSION=2.8.5
ARG HIVE_VERSION=2.3.6
ARG APACHE_MIRROR="http://apache-mirror.rbc.ru/pub/apache"


# Env
ENV LANG=en_US.utf8                                                                                                                      \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/                                                                                             \
    HADOOP_HOME=/usr/local/hadoop-$HADOOP_VERSION                                                                                        \ 
    HIVE_HOME=/usr/local/apache-hive-$HIVE_VERSION-bin                                                                                   \
    PATH=$PATH:/usr/local/hadoop-$HADOOP_VERSION/sbin:/usr/local/hadoop-$HADOOP_VERSION/bin:/usr/local/apache-hive-$HIVE_VERSION-bin/bin \
    CLASSPATH=$CLASSPATH:/usr/local/hadoop-$HADOOP_VERSION/lib/*:/usr/local/apache-hive-$HIVE_VERSION-bin/lib


# Install
COPY install.sh /tmp/

RUN chmod 755 /tmp/install.sh && \
    /tmp/install.sh


# Conf
COPY hive-site.xml $HIVE_HOME/conf/hive-site.xml

EXPOSE 10000

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["hiveserver2"]
