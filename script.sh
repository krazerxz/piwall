#!/bin/bash

#### CONFIG ####
NUMBER_OF_PI=4
START_IP=3
#IP_Base=192.168.1.
################

END_IP=$(($START_IP + $NUMBER_OF_PI - 1))

pi_loop (){
  for i in $(eval echo "{$START_IP..$END_IP}")
  do
    echo "CONNECTING TO 192.168.1."$i
    echo "ssh 192.168.1.$i $1"
    #ssh 192.168.1.$i $1
  done
}

case "$1" in
  start)
    echo 'STARTING PIWALL'
    pi_loop "pwomxplayer --config=wall udp://239.0.1.23:1234?buffer_size=1200000B &"
    ;;
  stop)
    echo 'STOPPING PIWALL'
    pi_loop "pkill pwomxplayer.bin"
    ;;
  update-config)
    echo 'UPDATING WALL CONFIG'
    pi_loop "cp .piwall /home/pi" # Check
    ;;
  *)
  echo "Usage: $0 {start|stop|update-config}" >&2
  exit 1
  ;;
esac
