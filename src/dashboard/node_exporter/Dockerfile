FROM debian:latest

USER node_exporter:node_exporter

ARG bin=/usr/local/bin

# Executables
COPY --chown node_exporter:node_exporter $bin/node_exporter

# Run Node Exporter service
CMD $bin/node_exporter
