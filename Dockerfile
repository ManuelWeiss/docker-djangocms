FROM ubuntu:14.04
MAINTAINER Manuel Weiss "mweiss@moonfruit.com"

# see http://docs.docker.com/articles/dockerfile_best-practices/

RUN apt-get update && apt-get install -y \
        python-pip \
        python-pil \
        python-django \
        python-psycopg2 \
        uwsgi \
        uwsgi-plugin-python

RUN mkdir -p /opt/djangocms
WORKDIR /opt/djangocms

COPY requirements.txt /opt/djangocms/
RUN pip install -r requirements.txt

RUN djangocms \
  --i18n=yes \
  --use-tz=yes \
  --timezone=Europe/London \
  --reversion=yes \
  --permissions=yes \
  --languages=en \
  --django-version=stable \
  --bootstrap=yes \
  --starting-page=no \
  --db="sqlite:////opt/djangocms/default.db" \
  --parent-dir . \
  --cms-version=stable \
  --no-input \
    default

EXPOSE 80

CMD ["uwsgi", "--master", "--http-socket=:80", "--plugin=python", "--module=default.wsgi"]

