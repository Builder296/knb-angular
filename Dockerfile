# Stage 1: Build the Angular application
FROM node:20.9.0-alpine as build
WORKDIR /app
COPY package*.json /app
RUN npm install
COPY . /app
RUN npm run build

# Stage 2: Serve the application from Nginx
FROM nginx:1.16.0-alpine
COPY --from=build /app/dist/knb-angular/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]