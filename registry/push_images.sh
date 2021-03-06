#!/bin/bash

regex='^([^\/]*)/(.*):(.*)$'
repo="localhost:5000"

for IMAGE in 'ce-registry.usersys.redhat.com/jboss-eap6/eap:6.4'; do 
    if [[ $IMAGE =~ $regex ]]; then
        server=${BASH_REMATCH[1]}
        name=${BASH_REMATCH[2]}
        tag=${BASH_REMATCH[3]}
    fi
    docker pull $IMAGE
    id_str=`docker inspect $IMAGE | grep Id`
    id=${id_str:11:-2}
    docker tag -f $id $repo/$name:$tag
    docker push $repo/$name:$tag
done

