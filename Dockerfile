FROM hashicorp/terraform:light

RUN mkdir /app

WORKDIR /app

ADD . /app

RUN apk -v --update add --no-cache \
      python \
      py-pip \
      groff \
      less \
      mailcap \
      bash \
      && \
  pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*
