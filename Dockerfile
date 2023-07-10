FROM node:16.16.0-alpine3.16 AS base
WORKDIR /workspace
COPY package*.json .
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]

# Build
FROM base AS build
COPY . /workspace
WORKDIR /workspace
ARG API_URL
RUN npm install && npm run build

# Deploy nginx
FROM nginx:latest AS production
COPY --from=build /workspace/.nuxt /var/www
COPY nginx.conf /etc/nginx/conf.d/default.conf