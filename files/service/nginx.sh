#!/bin/sh
 
NGINX_BASE_DIR="/opt/logstash"
NGINX_DAEMON="${NGINX_BASE_DIR}/embedded/sbin/nginx"
NGINX_CONF="${NGINX_BASE_DIR}/etc/nginx.conf"
 
__launch_signal( ) {
 
  ${NGINX_DAEMON} -c ${NGINX_CONF} -s ${1} &>/dev/null
}
 
__checkconfig( ) {
 
  ${NGINX_DAEMON} -c ${NGINX_CONF} -t &>/dev/null
}
 
__start( ) {
 
  [ -r ${NGINX_CONF} ] || exit 1 
 
  __checkconfig && ${NGINX_DAEMON} -c ${NGINX_CONF} &>/dev/null || return ${?}
}
 
__stop( ) {
 
  __launch_signal stop
}
 
__reload( ) {
 
  __checkconfig && __launch_signal reload || return ${?}  
}
 
__restart( ) {
 
  __stop && sleep 2 && __start
}

__status( ) {
  if [ ! -f ${NGINX_PID} ]; then
        echo "nginx: stopped"
        exit 1
  fi
  PID=`cat /opt/logstash/tmp/nginx.pid` && RUN=`ps -p $PID`
  if [ $? -eq 0 ]; then
        echo "nginx: running"
  else
        echo "nginx: stopped"
  fi
}

 
__show_usage( ) {
 
  echo "Usage: ${0} {start|stop|restart|reload|status}"
  exit 3
}
 
##
# :: main ::
case "${1}" in
  start|stop|restart|reload|status)
    [ -x ${NGINX_DAEMON} ] || exit 2
    __${1}
    ;;
  *)
    __show_usage
    ;;
esac