#FROM resin/amd64-debian:jessie
FROM resin/rpi-raspbian:jessie

#RUN apt-get clean && apt-get update && apt-get install -y \
#  npm \
#  nodejs-legacy  \
#  build-essential

# node-red
# RUN sudo npm install -g --unsafe-perm node-red

RUN apt-get clean && apt-get update && apt-get install -y \
  nodered

RUN apt-get clean && apt-get update && apt-get install -y \
  npm 

#upgrade npm to the newest version, otherwise we get build errors in node-red-contrib-graphs
RUN npm -g install npm

# install npm Q
RUN sudo npm install -g q

EXPOSE 1880

COPY . /root/agile-node-red-node

RUN npm install -g /root/agile-node-red-node

RUN apt-get clean && apt-get update && apt-get install -y \
  curl 

RUN npm install -g node-red-dashboard

RUN apt-get clean && apt-get update && apt-get install -y \
  build-essential

RUN npm install -g node-red-contrib-graphs

RUN npm install -g node-red-contrib-influxdb

CMD node-red