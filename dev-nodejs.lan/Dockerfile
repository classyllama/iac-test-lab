FROM node:lts-alpine
WORKDIR /var/app
COPY package*.json ./
RUN npm ci
CMD ["npx", "nodemon"]