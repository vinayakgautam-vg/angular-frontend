# Stage 1: Build an Angular Docker Image
FROM node:12.22.6  as build
WORKDIR /app
COPY package*.json /app/
RUN npm install
RUN npm i -g @angular/cli
RUN npm install yarn
RUN yarn --version
RUN yarn install
COPY . /app

RUN ng build --prod --outputPath=./dist/out 
# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx
COPY --from=build /app/dist/out/ /usr/share/nginx/html
COPY /nginx-custom.conf /etc/nginx/conf.d/default.conf
