FROM resin/rpi-raspbian:wheezy
MAINTAINER oliverw@squareup.com

RUN apt-get update \
  && apt-get install -y \
    python \
    python-dev \
    python-pip \
    python-greenlet \
    python-gevent \
    --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && pip install -U pip wheel setuptools

ADD build /build
RUN chmod +x /build

ADD start /start
RUN chmod +x /start
