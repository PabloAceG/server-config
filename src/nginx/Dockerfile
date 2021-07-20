FROM nginx

USER nginx:nginx

ARG conf=/etc/nginx
ARG daem=$conf/conf.d
ARG cert=/etc/ssl
ARG cProm=$cert/prometheus
ARG cGraf=$cert/grafana

# Config files
COPY --chown=nginx:nginx $conf/nginx.conf $conf/
COPY --chown=nginx:nginx $daem/ $daem/
# Certificates
COPY $cProm/* $cProm/
COPY $cGraf/* $cGraf/
