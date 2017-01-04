#Craete a folder to hold certificates
mkdir -p /etc/pki/tls/certs 

#Kill apt process if running already
kill $(pgrep -f apt)

# Install required packages
apt-get update
apt-get install apt-transport-https -y 

#Install Filebeat
touch /etc/apt/sources.list.d/beats.list 
echo "deb https://packages.elastic.co/beats/apt stable main" > /etc/apt/sources.list.d/beats.list
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
apt-get update
apt-get install filebeat -y
mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat_ORIG.yml
