FROM debian:latest

USER prometheus:prometheus

ARG conf=/etc/prometheus
ARG data=/data/prometheus

# Executables
COPY --chown prometheus:prometheus $conf/promtool
COPY --chown prometheus:prometheus $conf/prometheus
# Config files
COPY --chown prometheus:prometheus $conf/consoles/
COPY --chown prometheus:prometheus $conf/console_libraries/
COPY --chown prometheus:prometheus $conf/prometheus.yml
# Data
COPY --chown prometheus:prometheus $data/

# Run Prometheus service
CMD $conf/prometheus \
    --config.file=$conf/prometheus.yml \
    --storage.tsdb.path=$data/ \
    --web.console.templates=$conf/consoles/ \
    --web.console.libraries=$conf/console_libraries/ \
    --web.listen-address=0.0.0.0:9090 \
    --web.enable-admin-api \
    --web.external-url=https://localhost:1001
