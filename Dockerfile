FROM node:9.5.0

# Create new user
RUN useradd -ms /bin/bash playola

# install heroku command line
# Install app dependencies


USER playola
WORKDIR /home/playola

USER root
RUN chown -R playola /usr/local
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 \
  && echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list \
  && apt-get update && apt-get -q -y install \
    nodejs\
    npm \
    git \
    mongodb-org \
    build-essential


USER playola

COPY package.json /home/playola/

RUN npm install -g npm@5.6.0
RUN npm install -g node-gyp
RUN npm install -g gulp-cli && \
                npm install -g gulp && \
                npm install -g env-cmd && \
                npm install -g nodemon
RUN npm install

# Bundle app source
# (removing for -v instead)
# COPY . /usr/src/app          

EXPOSE 9000
EXPOSE 3000
EXPOSE 8080