FROM modularitycontainers/boltron-preview:latest
# Description
# Environment:
#  * $HOME_APP_ROOT - Root directory of application
#  * $NPM_RUN - Select an alternate / custom runtime mode, defined in your package.json file's scripts section (default: npm run "start").
#               These user-defined run-scripts are unavailable while DEV_MODE is in use.
# Exposed ports:
# * 8080 - Unprivileged port used by nodejs application
# Additional packages
#  * findutils are needed to help fix permissions.

LABEL MAINTAINER Rado Pitonak <rpitonak@redhat.com>

RUN dnf install -y --nodocs nodejs-f26 && \
    dnf install -y --rpm --nodocs findutils tar && \
    dnf clean all

ENV NAME=nodejs \
    VERSION=0 \
    RELEASE=1 \
    ARCH=x86_64

LABEL summary="Javascript runtime." \
       name="$FGC/$NAME" \
       version="$VERSION" \
       release="$RELEASE.$DISTTAG" \
       architecture="$ARCH" \
       description="Node.js is a platform built on V8 JavaScript Engine for easily building fast, scalable network applications." \
       vendor="Fedora Project" \
       com.redhat.component="$NAME" \
       usage="s2i build <SOURCE-REPOSITORY> nodejs:6 <APP-NAME>" \
       org.fedoraproject.component="nodejs" \
       authoritative-source-url="registry.fedoraproject.org" \
       io.k8s.description="Node.js is a platform built on V8 JavaScript Engine for easily building fast, scalable network applications." \
       io.k8s.display-name="Node.js 6.10.1" \
       io.openshift.tags="nodejs, js, JavaScript" \
       io.openshift.expose-services="8080:https" \
       io.openshift.s2i.scripts-url="image:///usr/local/s2i"

# Copy s2i scripts
COPY ./.s2i/bin/ /usr/local/s2i

# Add help file
COPY root /

# set enviroment variables
# add path to npm binaries to PATH enviroment variable
ENV HOME_APP_ROOT=/opt/app-root \
    NPM_RUN=start \
    PATH=/opt/app-root/node_modules/.bin/:/opt/app-root/.npm-global/bin/:$PATH

# create home directory and system user with UID 1001 GID 0 and default name
# set user home directory to $HOME_APP_ROOT
RUN mkdir -p ${HOME_APP_ROOT}

# EXPOSE instruction exposes port from container to host.
# Specify it during `docker run` as parameter: "-p <host_port>:<container_port>"
EXPOSE 8080

# drop the root user and make content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root && \
    find ${HOME_APP_ROOT} -type d -exec chmod g+ws {} \;

# Default user for image
USER 1001

WORKDIR ${HOME_APP_ROOT}

# Command which will start service during command `docker run`
CMD /usr/local/s2i/usage
