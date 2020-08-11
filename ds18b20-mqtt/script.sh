#!/bin/sh

while true;
do
  TEMPERATURE="$(cat /sys/bus/w1/devices/$1/w1_slave | awk 'END{print}' | awk 'NF>1{print $NF}' | awk '{print substr($0,3)/1000}')";
  echo "$(date): ${TEMPERATURE}";
  echo "Sending to mqtt host: $2...";
  mosquitto_pub -h $2 --id $1 -t ds18b20/$1 -m "${TEMPERATURE}";
  echo "Finished";
  echo "";
  sleep 1;
done;
