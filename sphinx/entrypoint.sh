#!/bin/bash
searchd --nodetach "$@"

#if [ "$1" = 'mysqld' -a -z "$wantHelp" -a "$(id -u)" = '0' ]; then
