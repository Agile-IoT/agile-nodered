FROM resin/raspberry-pi3-node:7.8.0-20170426
#FROM resin/nuc-node:7

COPY secure-nodered /opt/secure-nodered
WORKDIR /opt/secure-nodered
RUN cp /opt/secure-nodered/conf/agile-node-red-security-conf.js /opt/secure-nodered/conf/node-red-security-conf.js
RUN npm install

# install npm Q
RUN npm install q

COPY agile-sdk agile-sdk
WORKDIR agile-sdk
RUN npm install && npm link
WORKDIR ..

COPY node-red-contrib-security-nodes  node-red-contrib-security-nodes
WORKDIR node-red-contrib-security-nodes
RUN npm install && npm link agile-sdk && npm link
WORKDIR ..

ARG NODE=agile-node-red-nodes
COPY $NODE $NODE
RUN npm install $NODE

# adding Xively support
ARG NODE=node-red-contrib-agile-xively 
COPY $NODE $NODE
RUN npm install $NODE

# adding FIWARE support
ARG NODE=node-red-contrib-agile-fiware
COPY $NODE $NODE
RUN npm install $NODE

ARG NODE=node-red-contrib-agile-solid
COPY $NODE $NODE
RUN npm install $NODE

ARG NODE=node-red-contrib-agile-owncloud
COPY $NODE $NODE
RUN npm install $NODE

ARG NODE=node-red-contrib-agile-googledrive
COPY $NODE $NODE
RUN npm install $NODE

ARG NODE=node-red-contrib-thingspeak42
COPY $NODE $NODE
RUN npm install $NODE

#All these are now included as dependencies in the secure-nodered
#RUN npm install node-red-dashboard
#RUN npm install  node-red-contrib-graphs
#RUN npm install  node-red-contrib-influxdb
#RUN npm install  node-red-contrib-resinio

RUN npm link node-red-contrib-security-nodes

#RUN npm link agile-node-red-nodes
#RUN npm link node-red-contrib-agile-xively
#RUN npm link node-red-contrib-agile-fiware

EXPOSE 1880

CMD mkdir -p .nodered/node_modules && node index
