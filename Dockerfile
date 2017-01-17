FROM ubuntu:xenial
MAINTAINER Roy Xiang <developer@royxiang.me>

RUN apt-get update -y \
    && apt-get install -y curl python3-dev python3-setuptools \
        libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev \
        libwebp-dev tcl8.5-dev tk8.5-dev libmagic-dev ffmpeg \
    && curl -L -o /tmp/EFB-latest.tar.gz \
        $(curl -s https://api.github.com/repos/blueset/ehForwarderBot/releases \
            | grep tarball_url | head -n 1 | cut -d '"' -f 4) \
    && mkdir /opt/ehForwarderBot \
    && tar xzf /tmp/EFB-latest.tar.gz --strip-components=1 -C /opt/ehForwarderBot \
    && pip3 install -r /opt/ehForwarderBot/requirements.txt \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /opt/ehForwarderBot

VOLUME /opt/ehForwarderBot/storage

CMD ["python3", "main.py"]
