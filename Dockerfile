FROM node:20-slim
WORKDIR /app
COPY . .
CMD ["echo", "Hello from image"]
