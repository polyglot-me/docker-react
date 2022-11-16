#This is a multi step container. In first step generating build and in second step running the nginx to run the app
#tagging with a stage
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx

# Copying the build folder from base image to the nginx default path
COPY --from=builder /app/build /usr/share/nginx/html

