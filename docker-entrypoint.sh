#!/bin/sh

initialize () {
    echo
    echo "swarm-monitor ${VERSION}"
}

set_redirect_url () {
    echo
    echo "Setting redirect url in index.html to 'http://${CHK_URL}/status.json' ..."
    sed -i "s|{URL}|${CHK_URL}|g" /usr/share/nginx/html/index.html
    echo " ... done."
}

start_http () {
    echo
    echo "Starting nginx ..."
    /usr/sbin/nginx > /dev/null 2>&1
    RETVAL=$?

    if [ "$RETVAL" = "0" ]; then
        echo " ... done."
    else
        echo " ... failed!"
    fi
}

show_services () {
    echo
    echo "Starting to monitor the following services:"
    for service in $CHK_SERVICES
    do
        echo " * ${service%%.*}"
    done
}

check_services () {
    case $CHK_MONITOR in
        "prtg")
            output="{ \"prtg\": { \"result\": ["
            for service in $CHK_SERVICES
            do
                expected="${service##*.}"
                service="${service%%.*}"

                check=$(curl -sg --unix-socket /var/run/docker.sock http://$CHK_DOCKER_API_VERSION/tasks?filters={%22service%22:[%22$service%22]} | jq '.[]? | select((.Status.State|index("running")>=0))? | .ID?' | wc -l)

                state="0"
                if [ $check = $expected ]; then
                    state="1"
                fi

                output="$output { \"channel\": \"$service\", \"value\": \"$state\" },"
            done
            output="$output { \"channel\": \"updated\", \"value\": \"$(date +%s)\" } ] } }"          
            ;;

        *)
            output="{ \"Warning\": \"Monitor '$CHK_MONITOR' is unsupported.\" }"
            ;;
    esac

    echo $output | jq '.' > /usr/share/nginx/html/status.json
}

initialize

set_redirect_url

start_http

show_services

echo

while :
do
    check_services

    sleep $CHK_INTERVAL
done