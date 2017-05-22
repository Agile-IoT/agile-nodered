FROM resin/raspberry-pi3-node:7.8.0-20170426

# node-red
RUN sudo npm install -g node-red@0.16.2
#RUN apt-get clean && apt-get update && apt-get install -y \
#  nodered

# install npm Q
RUN sudo npm install -g q

EXPOSE 1880

RUN npm install -g node-red-dashboard

RUN npm install -g node-red-contrib-graphs

RUN npm install -g node-red-contrib-influxdb

RUN npm install -g node-red-contrib-resinio

COPY agile-node-red-nodes /opt/agile-node-red-nodes

WORKDIR /opt/agile-node-red-nodes

RUN npm install -g

COPY secure-nodered /opt/secure-nodered

COPY node-red-contrib-security-nodes  /opt/node-red-contrib-security-nodes

WORKDIR /opt/node-red-contrib-security-nodes

RUN npm install -g

WORKDIR /opt/secure-nodered

RUN npm link node-red

RUN cp /opt/secure-nodered/conf/agile-node-red-security-conf.js /opt/secure-nodered/conf/node-red-security-conf.js

RUN npm install

# adding Xively support
COPY node-red-contrib-agile-xively node-red-contrib-agile-xively
RUN npm install -g node-red-contrib-agile-xively

CMD node index
