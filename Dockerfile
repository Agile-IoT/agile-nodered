#-------------------------------------------------------------------------------
# Copyright (C) 2017 Create-Net / FBK.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# 
# Contributors:
#     Create-Net / FBK - initial API and implementation
#-------------------------------------------------------------------------------
ARG BASEIMAGE_BUILD=resin/raspberry-pi3-node:7.8.0-20170426
FROM $BASEIMAGE_BUILD

COPY secure-nodered /opt/secure-nodered
WORKDIR /opt/secure-nodered
RUN cp /opt/secure-nodered/conf/agile-node-red-security-conf.js /opt/secure-nodered/conf/node-red-security-conf.js
RUN npm install

# install npm Q
RUN npm install q

COPY node-red-contrib-security-nodes  node-red-contrib-security-nodes
WORKDIR node-red-contrib-security-nodes
RUN npm install
WORKDIR ..

ARG AGILE=agile-node-red-nodes
COPY $AGILE $AGILE
RUN npm install $AGILE

# adding Xively support
ARG XIVELY=node-red-contrib-agile-xively 
COPY $XIVELY $XIVELY
RUN npm install $XIVELY

# adding FIWARE support
ARG FIWARE=node-red-contrib-agile-fiware
COPY $FIWARE $FIWARE
RUN npm install $FIWARE

ARG SOLID=node-red-contrib-agile-solid
COPY $SOLID $SOLID
RUN npm install $SOLID

ARG OWNCLOUD=node-red-contrib-agile-owncloud
COPY $OWNCLOUD $OWNCLOUD
RUN npm install $OWNCLOUD

ARG GDRIVE=node-red-contrib-agile-googledrive
COPY $GDRIVE $GDRIVE
RUN npm install $GDRIVE

ARG THINGSPEAK=node-red-contrib-agile-thingspeak
COPY $THINGSPEAK $THINGSPEAK
RUN npm install $THINGSPEAK

# adding Agile-Recommender support
COPY node-red-contrib-agile-recommender node-red-contrib-agile-recommender
RUN npm install node-red-contrib-agile-recommender




RUN npm link node-red-contrib-security-nodes


EXPOSE 1880

CMD mkdir -p .nodered/node_modules && node index
