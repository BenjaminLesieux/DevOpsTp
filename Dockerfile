# Extending image
FROM node:16.20.0-alpine3.18
LABEL authors="team 9"

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Versions
RUN npm -v
RUN node -v

# Install app dependencies
COPY ./app/package.json /usr/src/app/
COPY ./app/package-lock.json /usr/src/app/

RUN npm install

# Bundle app source
COPY . /usr/src/app

# Port to listener
EXPOSE 3000

# Environment variables
ENV NODE_ENV production
ENV PORT 3000
ENV PUBLIC_PATH "/"

RUN npm run build

# Main command
CMD [ "npm", "run", "start:server" ]