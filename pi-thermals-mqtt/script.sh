#!/bin/sh

SERIAL_PI="$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)"
echo "Using MQTT topic rpi/${SERIAL_PI}"

while true;
do
  TEMPERATURE_CPU="$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $0/1000}')";
  TEMPERATURE_GPU="$(/opt/vc/bin/vcgencmd measure_temp | awk '{gsub("temp=", ""); gsub("\047C", ""); print $0}')";
  echo "$(date): CPU: ${TEMPERATURE_CPU} | GPU: ${TEMPERATURE_GPU}";
  echo "Sending to mqtt host: $1...";
  mosquitto_pub -h $1 --id "${SERIAL_PI}" -t "rpi/${SERIAL_PI}" -m "{ \"cpu\": ${TEMPERATURE_CPU}, \"gpu\": ${TEMPERATURE_GPU} }";
  echo "Finished";
  echo "";
  sleep 1;
done;
