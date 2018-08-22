#!/bin/bash

set -e

function start_app {
    docker-compose -f docker-compose.production.yml up -d
}

function stop_all {
    opts=""
    if [[ "$1" == "--volumes" ]]; then
	    opts="-v"
    fi
    docker-compose -f docker-compose.production.yml down ${opts}
}

function start_logs {
    docker-compose -f docker-compose.production.yml logs -f --tail=300 ${@:1}
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
        docker-compose -f docker-compose.production.yml ${@:1}
    ;;
esac
