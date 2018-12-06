FROM centos

# Run as root on RHEL, CentOS, CloudLinux or Fedora:
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash - 

# Install as Root
RUN yum install -y nodejs

RUN groupadd -g 998 go \
   && useradd -m -u 998 -g go go
USER go

# Create app directory
WORKDIR /usr/local/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

USER root
RUN npm install
# If you are building your code for production
# RUN npm install --only=production
USER go

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
