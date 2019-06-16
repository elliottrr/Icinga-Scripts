#!/bin/bash

TIMEOUT=5
PATH=$1
EXIT=0
TEXT="OK: ${PATH} is usable."

/usr/bin/timeout -s KILL ${TIMEOUT} /bin/ls -al ${PATH} 1>/dev/null
XV=$?

#echo "Eval Exit: ${XV}"

if [ ${XV} -ne 0 ] 
then
  EXIT=2
  TEXT="CRITICAL: ${PATH} is not usable: Directory listing failed."
else 
  /usr/bin/timeout -s KILL ${TIMEOUT} /bin/touch ${PATH}/testfile 1>/dev/null 2>/dev/null
  XV=$?
#  if [ ${XV} -ne 0 ] 
#  then
#    EXIT=1
#    TEXT="WARNING: ${PATH} is not writable: Cannot touch file."
#  else
#    /bin/rm ${PATH}/testfile
#  fi
fi



echo ${TEXT}
exit ${EXIT}
