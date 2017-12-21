FROM node:carbon-alpine
ENV NODE_ENV production

WORKDIR /usr/src/app
COPY ["package.json", "yarn.lock", "./"]
RUN yarn --production && mv node_modules ../
COPY ./src/. .

RUN addgroup -g 901 -S system && adduser -u 902 -S -g system app
USER app
EXPOSE 8080
CMD node --experimental-modules server.js