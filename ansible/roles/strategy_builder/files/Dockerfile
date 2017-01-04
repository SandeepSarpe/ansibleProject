FROM shukla2009/scala
MAINTAINER Sandeep Sarpe <sarpe.sandeep@gmail.com>

# Copy lpsolve lib to /usr/lib
RUN wget "http://lovenserver:8081/service/local/artifact/maven/redirect?g=com.loven.diwo&a=lpsolve-lib&v=LATEST&r=snapshots&p=tgz" -O lpsolve-lib-1.0.0-SNAPSHOT.tgz --content-disposition

RUN tar --strip-components=1 -xzf lpsolve-lib-1.0.0-SNAPSHOT.tgz -C /usr/lib
