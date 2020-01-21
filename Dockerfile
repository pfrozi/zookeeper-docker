FROM amd64/openjdk:11.0.6-jdk

ENV ZOOKEEPER_VERSION 3.5.6

#Download Zookeeper
RUN wget -q http://mirror.vorboss.net/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    wget -q https://www.apache.org/dist/zookeeper/KEYS && \
    wget -q https://www.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc && \
    wget -q https://www.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.sha512

#Verify download
RUN sha512sum -c apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.sha512 && \
    gpg --import KEYS && \
    gpg --verify apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc

#Install
RUN tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt
RUN mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/apache-zookeeper

#Configure
RUN rm -rf /opt/apache-zookeeper/conf/*
ADD config/* /opt/apache-zookeeper/conf/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV ZK_HOME /opt/apache-zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/apache-zookeeper
VOLUME ["/opt/apache-zookeeper/conf", "/tmp/zookeeper"]

CMD /opt/apache-zookeeper/bin/zkServer.sh start-foreground
