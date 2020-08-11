# rtl_433

This folder creates Docker containers that build and contain the [rtl_433](https://github.com/merbanan/rtl_433) application.

## Building

The Dockerfile this container uses is based on an arm32v6 base image, meaning an arm32v6 capable host is required (e.g. the *Raspberry Pi 1*).

The rtl_433 source code is referenced via a Git submodule at rtl_433/rtl_433. Ensure this submodule is cloned before building the Docker container.

The Docker container can be built by running the following command from this folder:

```sh
docker build -t rtl_433:latest .
```

## Usage

Since rtl_433 is configured as the entrypoint of the container, any rtl_433 switches can be passed when running the container.

The container can be started with the following command:

```sh
docker run -d --privileged --restart=unless-stopped --name SOME_CONTAINER_NAME rtl_433 RTL_433_SWITCHES
```

- `CONTAINER_NAME` should be set to a unique name for the container instance (e.g. *rtl_433*)
- `--privileged` is required so the container can access USB on the Pi
- `--restart=unless-stopped` is recommended ensures the container restarts if the Pi (or Docker) is rebooted
- `RTL_433_SWITCHES` is optional and can be any switch(es) that can be passed to rtl_433
