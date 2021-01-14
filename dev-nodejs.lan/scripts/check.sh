#!/usr/bin/env bash

# This currently runs automatically in the BitBucket Pipeline before a Heroku deployment is kicked off

# List current files
# ls -la

echo "Checking for invalid contents in repo"
# Throw an error if node_modules is found in git repo
# https://devcenter.heroku.com/articles/troubleshooting-node-deploys#don-t-check-in-generated-directories
( (git ls-files | grep -q node_modules) && echo 'node_modules should not exist in repo' && exit 1 || exit 0 )

# Throw an error if node_modules is found in current directory
# [[ ! -d  node_modules ]] || (echo 'node_modules should not exist in directory' && exit 1)

# syntax check for entry points
echo "check app.js"
node --check app.js && echo -e "[ok]\n"

# Lint
echo "Linting application"
npx -q eslint .

# Auditing for Vulnerabilities
npm audit --audit-level=moderate

# Checking for outdated packages
npm outdated
