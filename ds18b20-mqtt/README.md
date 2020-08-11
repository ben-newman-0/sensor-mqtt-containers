# ds18b20-mqtt

ds18b20-mqtt is a Docker container that reads temperature from a 1-Wire DS18B20 temperature sensor and sends the reading to an MQTT broker.

## Building

The Dockerfile this container uses is based on an arm32v6 base image, meaning an arm32v6 capable host is required (e.g. the *Raspberry Pi 1*).

The Docker container can be built by running the following command from this folder:

```sh
docker build -t ds18b20-mqtt:latest .
```

## Usage

The script the container uses takes the serial number of the temperature sensor to read from. Serial numbers of available 1-Wire devices can be found by running the following command on the Pi:

```sh
ls /sys/bus/w1/devices/
```

The container can be started with the following command:

```sh
docker run -d --privileged --restart=unless-stopped --name SOME_CONTAINER_NAME ds18b20-mqtt SERIAL_NUMBER MQTT_HOST
```

- `CONTAINER_NAME` should be set to a unique name for the container instance (e.g. *ds18b20-outdoors*)
- `SERIAL_NUMBER` must be set to the serial number of the DS18B20 temperature sensor to read from (e.g. *28-051760c6b1ff*)
- `MQTT_HOST` must be set to the MQTT host to send temperature readings to
- `--privileged` is required so the container can access the 1-Wire bus on the Pi
- `--restart=unless-stopped` is recommended ensures the container restarts if the Pi (or Docker) is rebooted
