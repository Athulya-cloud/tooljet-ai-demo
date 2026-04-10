FROM node:18-slim
WORKDIR /app
COPY server.js .
EXPOSE 8000
CMD ["node", "server.js"]
