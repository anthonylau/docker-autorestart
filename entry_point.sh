#!/bin/sh

term_handler() {
  exit 143; # 128 + 15 -- SIGTERM
}

trap 'kill ${!}; term_handler' SIGTERM

docker events \
    -f 'type=container' \
    -f 'event=health_status' \
    --format='{{json .}}' \
    | while read -r event;
do
    id=$(echo $event | jq -r 'select((.Action | test("health_status: unhealthy")) and .Actor.Attributes["io.github.anthonylau.docker-autorestart"]) | .id')
    if ! [ -z "$id" ]; then
        name=$(docker inspect $id | jq '.[0].Name')
        echo "Restarting container $name $id"
        docker restart $id
        echo "Restarted container $id"
        sleep 5
    fi
done
