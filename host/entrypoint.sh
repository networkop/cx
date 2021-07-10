#!/bin/bash
INTFS=${1:-1}

int_calc () 
{
    index=0
    for i in $(ls -1v /sys/class/net/ | grep 'eth\|ens\|eno'); do
      let index=index+1
    done
    MYINT=$index
}

int_calc

echo "Waiting for $INTFS interfaces to be connected"
while [ "$MYINT" -lt "$INTFS" ]; do
  echo "Connected $MYINT interfaces out of $INTFS"
  sleep 1
  int_calc
done

echo "Connected all interfaces"
ifreload -a || true 

/usr/sbin/sshd -D