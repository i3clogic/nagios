#!/bin/bash

RET_OK=0
RET_WARN=1
RET_CRIT=2
RET_UNKNOWN=3

user="$1"
warn="$2"
crit="$3"

id=`id -u $user`
if [ $? -ne 0 ]
then
echo "UNKNOWN: USAGE ./check_threads.sh   "
fi
count=`ps auxH | grep $user | wc -l`
if [ $? -ne 0 ]
then
echo "UNKNOWN: USAGE ./check_threads.sh   "
fi
if [ $count -lt $warn ]
then
echo "THREADS OK: $count processes/threads with UID = $id ($user)"
exit $RET_OK
elif [ $count -lt $crit ]
then
echo "WARNING - $count threads processes/threads with UID = $id ($user)"
exit $RET_WARN
else
echo "CRITICAL - $count threads processes/threads with UID = $id ($user)"
exit $RET_CRIT
fi

