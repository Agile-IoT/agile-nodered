FROM resin/raspberry-pi3-node:7.8.0-20170426
#FROM resin/nuc-node:7

#RUN apt-get clean && apt-get update && apt-get install -y \
#  nodered

# install npm Q
RUN sudo npm install -g q

EXPOSE 1880

COPY agile-sdk agile-sdk
WORKDIR agile-sdk
RUN npm install && npm link
WORKDIR /

COPY node-red-contrib-security-nodes  node-red-contrib-security-nodes
WORKDIR node-red-contrib-security-nodes
RUN npm install && npm link agile-sdk && npm link
WORKDIR /

COPY agile-node-red-nodes agile-node-red-nodes
RUN npm install -g agile-node-red-nodes

# adding Xively support
COPY node-red-contrib-agile-xively node-red-contrib-agile-xively
RUN npm install -g node-red-contrib-agile-xively

# adding FIWARE support
COPY node-red-contrib-agile-fiware node-red-contrib-agile-fiware
RUN npm install -g node-red-contrib-agile-fiware

COPY secure-nodered /opt/secure-nodered
WORKDIR /opt/secure-nodered
RUN cp /opt/secure-nodered/conf/agile-node-red-security-conf.js /opt/secure-nodered/conf/node-red-security-conf.js
RUN npm install

#All these are now included as dependencies in the secure-nodered
#RUN npm install node-red-dashboard
#RUN npm install  node-red-contrib-graphs
#RUN npm install  node-red-contrib-influxdb
#RUN npm install  node-red-contrib-resinio

RUN npm link agile-node-red-nodes
RUN npm link node-red-contrib-security-nodes
RUN npm link node-red-contrib-agile-xively
RUN npm link node-red-contrib-agile-fiware

CMD node index
