docker-djangocms
================

docker container with djangocms and uwsgi

Installs a vanilla djangocms to /opt/djangocms and exposes it via uwsgi on port 80.

Build with

    docker build -t djangocms .

And run with

    docker run -it -p 80:80 djangocms
