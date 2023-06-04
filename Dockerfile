FROM node:16-alpine  AS builder

WORKDIR '/app'
# Set permissions for the '/app' directory

COPY package.json .

RUN npm install
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .

RUN npm run build

FROM nginx

#copies from previous session (node16)
COPY --from=builder /app/build /usr/share/nginx/html

