FROM nginx

# Install certbot
RUN apt-get -y update
RUN apt-get -y install python3-pip
RUN pip3 install certbot
RUN pip3 install certbot-nginx

# Prepare folder to store certificates
RUN mkdir -p /etc/ssl/nginx
