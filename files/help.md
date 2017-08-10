% nodejs(1)
% Rado Pitonak \<rpitonak@redhat.com\>
% DATE 07.04.2017

# NAME
nodejs - source to image builder of Node.js applications.

# DESCRIPTION
Image for building Node.js application as reproducible Docker image using source to image. The Image is based on the Base Runtime.

# USAGE

To pull the nodejs container run:

    # docker pull modularitycontainers/nodejs:{{ node_version }}

To build your Node.js application use run:


    # s2i build <SOURCE-REPOSITORY> modularitycontainers/nodejs:{{ node_version }} <NAME-OF-APP>


To run your application in docker container:


    # docker -d run -p 8080:8080 <NAME-OF-APP>

By default container is running in production mode with exposed port 8080. To change behavior see Enviroment variables section below.

# ENVIRONMENT VARIABLES
NODE_ENV=runtime_mode
       	     Node.js runtime mode (default: "production")

DEV_MODE=mode
             When set to "true", `nodemon` will be used to automatically reload the server while you work (default: "false"). Setting `DEV_MODE` to "true" will change the `NODE_ENV` default to "development" (if not explicitly set).

NPM_RUN=value  
            Select an alternate / custom runtime mode, defined in your `package.json` file's [`scripts`](https://docs.npmjs.com/misc/scripts) section (default: npm run "start"). These user-defined run-scripts are unavailable while `DEV_MODE` is in use.

HTTP_PROXY=url
            Use an npm proxy during assembly

HTTPS_PROXY=url
            Use an npm proxy during assembly

NPM_MIRROR=registry
            Use a custom NPM registry mirror to download packages during the build process

# DEVELOPMENT
This image supports development mode. This mode can be switched on and off with the environment variable `DEV_MODE`. `DEV_MODE` can either be set to `true` or `false`.
The debug port can be specified with the environment variable `DEBUG_PORT`. `DEBUG_PORT` is only valid if `DEV_MODE=true`.
By default, `DEV_MODE` is set to `false`, and `DEBUG_PORT` is set to `5858`, however the `DEBUG_PORT` is only relevant if `DEV_MODE=true`.

# HOT DEPLOY
As part of development mode, this image supports hot deploy. If development mode is enabled, any souce code that is changed in the running container will be immediately reflected in the running nodejs application

To change your source code in a running container, use Docker's exec (https://docs.docker.com/engine/reference/commandline/exec/) command:

    # docker exec -it <CONTAINER_ID> /bin/bash

After you enter into the running container, your current directory is set to /opt/app-root/, where the source code is located.    

# EXAMPLE

To run your application in development mode run:

    # docker run --env DEV_MODE=true -p 8080:8080 <NAME-OF-APP>

To run the container in production mode, run:

    # docker run --env DEV_MODE=false <NAME-OF-APP>

To run the container in development mode with a debug port of 5454, run

    # docker run --env DEV_MODE=true DEBUG_PORT=5454 <NAME-OF-APP>

To build your application with using of npm proxy.

    # s2i build ./test/test-app modularitycontainers/nodejs:{{ node_version }} my-app --env HTTP_PROXY=url

# SECURITY IMPLICATIONS
-d

     Runs continuously as a daemon process in the background

-p 8080:8080

     Opens  container  port  8080  and  maps it to the same port on the Host.
