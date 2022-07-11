FROM node:16-alpine as builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install && yarn cache clean

COPY . .

RUN yarn build

FROM nginx:1.23-alpine

COPY --from=builder /app/build /usr/share/nginx/html
