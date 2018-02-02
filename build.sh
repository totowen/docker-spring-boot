#!/bin/bash

source /etc/profile

MYIMAGE=springboot/docker-spring-boot-test

# uncomment if you need push
#docker login -u totowen -p s12152839

# stop all container
/usr/bin/docker kill $(docker ps -aq)

# remove all container
/usr/bin/docker rm $(docker ps -aq)

# remove old images
/usr/bin/docker images | grep springboot/docker-spring-boot-test | awk '{print $3}' | xargs docker rmi

# build jar and image
mvn package -e -X docker:build -DskipTest

# running container
/usr/bin/docker run -dp 8080:80 --name springboot-test ${MYIMAGE}

# push image
#docker push ${MYIMAGE}
