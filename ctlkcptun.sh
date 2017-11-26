#!/bin/sh

KCPTUN_SEVER=$KCPTUN_SERVER
KCPTUN_PORT=$KCPTUN_PORT
KCPTUN_TARGET_IP=$KCPTUN_TARGET_IP
KCPTUN_TARGET_PORT=$KCPTUN_TARGET_PORT

_get_pid () {
    cat /var/run/kcptun.pid 2>/dev/null
}

_print_status() {
    if [ -z "$1" ]; then
        echo "kcptun is not running."
    else
        echo "kcptun is running with pid $1."
    fi
}

_start() {
    pid=`_get_pid`
    if [[ ! -z "$pid" ]]; then
        _print_status $pid
        exit 0
    fi
    echo "Starting kcptun server..."
    $KCPTUN_SERVER -l ":$KCPTUN_PORT" -t "$KCPTUN_TARGET_IP:$KCPTUN_TARGET_PORT" -mode fast2
    echo $! > /var/run/kcptun.pid
    echo "kcptun started."
}

_status() {
    _print_status `_get_pid`
}

_stop() {
    pid=`_get_pid`
    if [ -z "$pid" ]; then
        _print_status
        exit 0
    fi
    kill -9 `cat /var/run/kcptun.pid`
    echo '' > /var/run/kcptun.pid
    echo "kcptun stopped."
}

case $1 in
    start)
        _start
    ;;

    status)
        _status
    ;;

    stop)
        _stop
    ;;

    restart)
        _stop && sleep 1 && _start
    ;;

    *)
        _status
        echo "Usage: ctlkcptun [start|status|stop|restart]"
        exit -1
    ;;
esac
