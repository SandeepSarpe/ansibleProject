FROM mesoscloud/mesos-slave:0.28.1-ubuntu-14.04
MAINTAINER Sandeep Sarpe <sarpe.sandeep@gmail.com>

Run echo 'Updating the base ubuntu image with dependencies needed for Spark.......'
RUN apt-get update

# Install Oracle JDK instead of OpenJDK
RUN sudo apt-get remove -y --auto-remove openjdk* && \
    sudo apt-get update && \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:webupd8team/java && \
    sudo apt-get update && \
    sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && \
    sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections && \
    sudo apt-get install -y oracle-java8-installer oracle-java8-set-default && \
    sudo rm -r /var/cache/oracle-jdk*

#Install wget
RUN apt-get install -y wget

RUN mkdir /opt/spark


RUN echo 'Updated the base ubuntu image with dependencies needed for Spark.'
#RUN wget http://diwo.teranetworks.com:9080/nexus/content/repositories/thirdparty/org/spark/spark/1.6.0/spark-1.6.0.tgz
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2-bin-hadoop2.7.tgz
#RUN tar --strip-components=1 -xzf /spark-1.6.0.tgz -C /opt/spark
RUN tar --strip-components=1 -xzf spark-2.0.2-bin-hadoop2.7.tgz -C /opt/spark

RUN echo 'Setting up environment variables for spark.......'
ENV SPARK_HOME /opt/spark
ENV PATH $PATH:/opt/spark/bin
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so
RUN echo 'Set environment variables for spark.'



