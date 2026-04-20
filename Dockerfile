FROM python:3.12-slim

  RUN apt-get update && apt-get install -y supervisor curl && \
      curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
      apt-get install -y nodejs

  WORKDIR /app

  COPY server.js .
  COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

  EXPOSE 8000 8001 8002

  CMD ["supervisord", "-n"]FROM python:3.12-slim

RUN apt-get update && apt-get install -y supervisor

WORKDIR /app

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000 8001

CMD ["supervisord", "-n"]
