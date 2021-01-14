#!/usr/bin/env bash

# docker-compose build --no-cache


# This currently runs automatically in the Heroku build Pipeline before a Heroku release is completed

# Run a couple sanity checks in the runtime environment before a release is deployed

# syntax check for entry points
echo "check app.js"
node --check app.js && echo -e "[ok]\n"

echo "Linting application"
npx -q eslint .
