#!/bin/bash
# first check the first argument, defaulting to 0
INTFS=${1:-0}

# next check if the CLAB_INTFS is configured (containerlab's metadata var)
INTFS=${CLAB_INTFS:INTFS}

int_calc () 
{
    index=0
    for i in $(ls -1v /sys/class/net/ | grep 'eth\|ens\|eno' | grep -v eth0); do
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