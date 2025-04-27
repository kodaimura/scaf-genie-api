FROM julia:1.11

WORKDIR /app

RUN apt-get update \
  && apt-get install -y logrotate \
  && rm -rf /var/lib/apt/lists/*