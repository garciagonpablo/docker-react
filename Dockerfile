FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
#RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .
RUN npm run build
# /app/build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# ngnix image takles care of the CMD alone