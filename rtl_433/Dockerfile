## Create build envrionment / build rtl_433
FROM arm32v6/alpine:3.10.3 AS build

# Install packages required to build rtl_433
RUN apk add \
    cmake \
    make \
    gcc \
    musl-dev
RUN apk add librtlsdr-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Copy rtl_433 src to container and create required folders
WORKDIR /rtl_433
COPY rtl_433 ./
RUN mkdir build
WORKDIR /rtl_433/build
RUN mkdir out

# Configure and build rtl_433
RUN cmake -DCMAKE_INSTALL_PREFIX=/rtl_433/build/out ..
RUN make
RUN make install

################################

## Create runtime envrionment and copy rtl_433 into it
FROM arm32v6/alpine:3.10.3

# Install rtl-sdr runtime packages required to run rtl_433
RUN apk add librtlsdr --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted 

# Copy output from build container to runtime container
WORKDIR /rtl_433
COPY --from=build /rtl_433/build/out .

# Configure rtl_433 as entrypoint of the container
ENTRYPOINT ["bin/rtl_433"]
