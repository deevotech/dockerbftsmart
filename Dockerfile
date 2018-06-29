# ubuntu-openjdk-8-jdk
#
# VERSION               0.0.3
#
# Extends ubuntu-base with java 8 openjdk jdk installation
# 
FROM picoded/ubuntu-base
MAINTAINER Datlv <datle2011@gmail.com> 
# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
apt-get install -y openjdk-8-jdk && \
apt-get install -y ant && \
apt-get install -y unzip && \
apt-get install -y wget && \
apt-get install -y libc6-dev-i386 && \
apt-get install -y autoconf && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer; 
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302 
RUN apt-get update && \
apt-get install -y ca-certificates-java && \
apt-get clean && \
update-ca-certificates -f && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer; 
# Setup JAVA_HOME, this is useful for docker commandline 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
RUN wget https://github.com/mcfunley/juds/archive/master.zip --output-document=/tmp/juds.zip;

RUN unzip /tmp/juds.zip -d /tmp/juds && \
cd /tmp/juds/juds-master && \
./autoconf.sh && \
./configure && \
make && \
make install;
RUN mkdir -p /opt && \
 mkdir -p /opt/gopath/ && \
 mkdir -p /opt/gopath/src && \
 mkdir -p /opt/gopath/src/github.com && \
 mkdir -p /opt/gopath/src/github.com/hyperledger;
RUN wget https://github.com/jcs47/hyperledger-bftsmart/archive/release-1.1.zip --output-document=/tmp/hyperledger-bftsmart.zip
RUN unzip /tmp/hyperledger-bftsmart.zip -d /opt/gopath/src/github.com/hyperledger/ && \
cd /opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-release-1.1 && \
ant clean && \
ant;
