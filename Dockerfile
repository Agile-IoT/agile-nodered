FROM resin/raspberrypi3-node:7.2.1

# node-red
RUN sudo npm install -g node-red
#RUN apt-get clean && apt-get update && apt-get install -y \
#  nodered

# install npm Q
RUN sudo npm install -g q

EXPOSE 1880

RUN npm install -g node-red-dashboard

RUN npm install -g node-red-contrib-graphs

RUN npm install -g node-red-contrib-influxdb

RUN npm install -g node-red-contrib-resinio

#COPY agile-node-red-nodes /opt/agile-node-red-nodes

#WORKDIR /opt/agile-node-red-nodes

#RUN npm install -g 


COPY secure-nodered /opt/secure-nodered



COPY node-red-contrib-idm-token-node  /opt/node-red-idm-token-node

#RUN npm install -g git+https://github.com/Agile-IoT/node-red-contrib-idm-token-node.git

WORKDIR /opt/node-red-idm-token-node

RUN npm install -g

WORKDIR /opt/secure-nodered

RUN npm link node-red

RUN cp /opt/secure-nodered/conf/agile-node-red-security-conf.js /opt/secure-nodered/conf/node-red-security-conf.js

RUN npm install

CMD node index
