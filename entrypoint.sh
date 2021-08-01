#!/bin/bash

# Sets script to fail if any command fails.
set -e


run_app() {
	echo Starting app.
	$PENTAHOSERVER_HOME/start-pentaho.sh
	touch $PENTAHOSERVER_HOME/tomcat/logs/pentaho.log
	tail -f $PENTAHOSERVER_HOME/tomcat/logs/pentaho.log
}

print_usage() {
echo "

Usage:	$0 COMMAND

Pentaho Server Container

Options:
  help		        Print this help
  run			Run Pentaho Server
"
}

case "$1" in
    help)
        print_usage
        ;;
    run)
       run_app
        ;;
    *)
        exec "$@"
esac
