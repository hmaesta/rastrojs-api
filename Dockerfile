FROM node:14-alpine as build

WORKDIR /app

ADD package.json .

RUN yarn install

ADD . .

RUN yarn build

FROM node:14-alpine

WORKDIR /app

COPY --from=build /app/dist /app/package.json /app/yarn.lock /app/

ENV NODE_ENV=production

RUN yarn install --prod

USER node

EXPOSE 8080

CMD [ "node", "app.js" ]