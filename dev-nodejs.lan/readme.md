# NodeJS Development Environment

Uses Docker & Docker Compose to spin up a containerized NodeJS application. Should be used in combination w/ Heroku container registry to utilize identical containers for both development & production.

### Install System Dependencies

- Docker
- Docker Compose

#### Manual Install

https://docs.docker.com/docker-for-mac/install/

#### Install Using Brew

    brew install --cask docker

Open Dcoker Desktop app

    open /Applications/Docker.app

Enter user's password to grant Docker Desktop the ability to install networking components

### Instructions:

#### To Run:

1. Install any additional dependencies for the project using

        npm install

2. Build/Rebuild application container which rebuilds the Dockerfile and re-installs node_modules/ inside the container container

        docker-compose build --no-cache

3. Spin up containers and start development

        docker-compose up

4. Application automatically restarts when code is edited
5. Application should be visible on http://localhost
6. Return to step 1 if additional dependencies are needed (CTRL+C first)

#### To Setup:

1. Chose specific versions of Docker images to keep development consistant (in docker-compose.yml & Dockerfile)
2. Rename '.env copy' to .env and make edits
3. Edit package.json file for specific project

#### To Deploy (WIP):

1. We will need to ensure that the use of a volume in docker-compose doesn't interfere w/ the deployment of the image to Heroku
2. `heroku container:push app`

### Considerations:

- This uses the image `node:lts-alpine` which is 10% the size of the regular `node:lts` image (100mb -> 950mb). It doesn't come w/ batteries included so the developer might want to use the full image if this is causing trouble.
- I don't know if running several applicaitons at the same time will work.
- Additional consideration might have to take place for proper treatment of TS
- The postgres & redis containers are accessible through `postgres://db:5432` and `redis://redis:6379` respectively
