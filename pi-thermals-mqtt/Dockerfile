FROM arm32v6/alpine
RUN apk update && apk add mosquitto-clients raspberrypi
COPY script.sh /
RUN chmod +x /script.sh
ENTRYPOINT ["/script.sh"]
CMD []
