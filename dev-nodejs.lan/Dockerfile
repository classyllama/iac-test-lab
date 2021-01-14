FROM heroku/heroku:20

RUN useradd --create-home --home-dir /app --shell /bin/bash web-app \
  && chown -R web-app:web-app /app \
  || echo "web-app user already exists"

WORKDIR /app
USER web-app

COPY package*.json ./
RUN npm ci

CMD npx nodemon
