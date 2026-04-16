FROM python:3.12-slim

RUN apt-get update && apt-get install -y supervisor

WORKDIR /app

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000 8001

CMD ["supervisord", "-n"]
