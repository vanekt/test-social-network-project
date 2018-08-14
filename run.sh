#!/bin/bash

set -e

function start_app {
    docker-compose up -d
}

function stop_all {
    opts=""
    if [[ "$1" == "--volumes" ]]; then
	    opts="-v"
    fi
    docker-compose down ${opts}
}

function start_logs {
    docker-compose logs -f --tail=300 ${@:1}
}

case "$1" in
    "up" )
	    start_app
    ;;

    "down" )
        stop_all ${@:2}
    ;;

    "logs" )
        start_logs ${@:2}
    ;;

    * )
        docker-compose ${@:1}
    ;;
esac
