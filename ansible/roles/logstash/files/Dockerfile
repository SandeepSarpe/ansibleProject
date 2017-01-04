FROM nimmis/ubuntu:14.04
MAINTAINER Sandeep Sarpe <sandeep.sarpe@synerzip.com>

#ARG logstashserverip
#ARG logstashserverhostname
#ARG logstashservernginxpass

# Install Oracle JDK instead of OpenJDK
RUN echo 'Installing JDK-8............'
RUN apt-get remove -y --auto-remove openjdk* && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install -y oracle-java8-installer oracle-java8-set-default && \
    rm -r /var/cache/oracle-jdk*

# Install Elasticsearch
RUN echo 'Installing Elasticsearch............'
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apt-get update
RUN apt-get -y install elasticsearch
# Configure Elasticsearch
RUN echo 'Cofiguring Elasticsearch............'
#RUN  sed -i "/# network.host: /a \ network.host: localhost" /etc/elasticsearch/elasticsearch.yml
RUN sudo service elasticsearch restart
RUN update-rc.d elasticsearch defaults 95 10

#Install Kibana
RUN echo 'Installing Kibana............'
RUN echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | tee -a /etc/apt/sources.list.d/kibana-4.4.x.list
RUN apt-get update
RUN apt-get -y install kibana
# Configure Kibana
RUN echo 'Cofiguring Kibana............'
RUN sed -i '/# server.host: /a server.host: "localhost"' /opt/kibana/config/kibana.yml
RUN update-rc.d kibana defaults 96 9
RUN service kibana start

# Install NGINX
RUN echo 'Installing NGINX............'
RUN apt-get install -y nginx apache2-utils
#Configure NGINX
RUN echo 'Cofiguring NGINX............'
RUN htpasswd -c -b /etc/nginx/htpasswd.users $(whoami) LOGSTASHSERVERNGINXPASS_VAL ## hardcoded password

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O /home/master.zip https://github.com/SandeepSarpe/logstashserver/archive/master.zip
RUN apt-get -y install unzip
RUN unzip /home/master.zip -d /home
RUN cp /home/logstashserver-master/nginx/conf/default /etc/nginx/sites-available/

#RUN sed -i "s/example.com/LOGSTASHSERVERHOSTNAME_VAL/g" /etc/nginx/sites-available/default ## hardcoded logstash server hostname
RUN sed -i "s/example.com/LOGSTASHSERVERIP_VAL/g" /etc/nginx/sites-available/default ## hardcoded logstash server hostname
RUN service nginx restart
RUN update-rc.d nginx defaults

# Install Logstash
RUN echo 'Installing Logstash............'
RUN echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | tee /etc/apt/sources.list.d/logstash-2.2.x.list
RUN apt-get update
RUN apt-get install -y logstash
# Generate SSL Certificates
RUN mkdir -p /etc/pki/tls/certs
RUN mkdir /etc/pki/tls/private
RUN sed -i "/v3_ca /a subjectAltName = IP:LOGSTASHSERVERIP_VAL" /etc/ssl/openssl.cnf ## hardcoded logstash server IP
RUN cd /etc/pki/tls && openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
#Configure logstash
RUN echo 'Cofiguring Logstash............'
RUN cp /home/logstashserver-master/logstash/conf/*.conf /etc/logstash/conf.d/
RUN service logstash configtest
RUN service logstash restart
RUN update-rc.d logstash defaults 96 9

# Load Kibana Dashboard
RUN cd ~ && curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip
RUN apt-get -y install unzip
RUN unzip beats-dashboards-*.zip
#RUN service elasticsearch start
#RUN service kibana start
#RUN service nginx start
#RUN service logstash start
#RUN cd beats-dashboards-*
#RUN curl http://localhost:9200
#RUN ./load.sh

# Load filebeat index template in elasticsearch
#RUN cd ~ && curl -O https://gist.githubusercontent.#com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json
#RUN curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json

# Copy SSL certficates to client
#RUN apt-get install -y ssh && apt-get install -y sshpass
#RUN sshpass -p 'vagrant' scp -o StrictHostKeyChecking=no /etc/pki/tls/certs/logstash-forwarder.crt vagrant@10.0.#15.73:/tmp ## hardcoded client server IP and user and password
#RUN scp /etc/pki/tls/certs/logstash-forwarder.crt vagrant@10.0.15.73:/tmp ## hardcoded client server IP and user #and password


#ADD start_services.sh /home/start_services.sh
#RUN chmod 777 /home/start_services.sh
#RUN cd /home && ./start_services.sh
#CMD ["start_services.sh"]






