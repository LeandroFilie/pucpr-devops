FROM node:20 AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build --prod

FROM nginx:alpine
COPY --from=build /app/dist/login-page /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
