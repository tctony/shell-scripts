#! /bin/sh

_get_pid () {
    cat /var/run/emacs.pid 2>/dev/null 
}

_print_status() {
    if [ -z "$1" ]; then
        echo "Emacs is not running."
    else
        echo "Emacs is running with pid $1."
    fi
}

_start() {
    pid=`_get_pid`
    if [[ ! -z "$pid" ]]; then
        _print_status $pid
        exit 0
    fi
    echo "Starting emacs daemon..."
    pushd ~ > /dev/null
    emacs --daemon
    popd > /dev/null
    echo "Emacs started."
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
    emacsclient --eval "(kill-emacs)"
    echo "Emacs stopped."
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
        echo "Usage: ctlemacs [start|status|stop|restart]"
        exit -1
    ;;
esac
