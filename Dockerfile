FROM node:20 AS builder
WORKDIR /opt/website
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build
CMD yarn dev --host --port 3000

FROM node:20-alpine
WORKDIR /opt/website
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production
COPY --from=builder /opt/website/build ./build
EXPOSE 3000
ENTRYPOINT [ "node" ]
CMD [ "build" ]
