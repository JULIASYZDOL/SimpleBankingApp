FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils

ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT

RUN mkdir log
COPY public public/
COPY /etc/nginx/nginx.conf /tmp/docker.nginx
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 8080 443
CMD [ "nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf", "-b", "0.0.0.0"]
