# pi-thermals-mqtt

pi-thermals-mqtt is a Docker container that reads the system (CPU & GPU) temperatures of a Raspberry Pi and sends the readings to an MQTT broker.

## Building

The Dockerfile this container uses is based on an arm32v6 base image, meaning an arm32v6 capable host is required (e.g. the *Raspberry Pi 1*).

The Docker container can be built by running the following command from this folder:

```sh
docker build -t pi-thermals-mqtt:latest .
```

## Usage

The container can be started with the following command:

```sh
docker run -d --restart=unless-stopped --name SOME_CONTAINER_NAME -v /sys/class/thermal/thermal_zone0/temp:/sys/class/thermal/thermal_zone0/temp:ro --device /dev/vchiq pi-thermals-mqtt MQTT_HOST
```

- `CONTAINER_NAME` should be set to a unique name for the container instance (e.g. *pi-thermals-mqtt*)
- `MQTT_HOST` must be set to the MQTT host to send temperature readings to
- `--restart=unless-stopped` is recommended to ensure the container restarts if the host (or Docker) is rebooted
- `-v /sys/class/thermal/thermal_zone0/temp:/sys/class/thermal/thermal_zone0/temp:ro` is required to allow the container to read the CPU temperature
- `--device /dev/vchiq` is required to read the GPU temperature
