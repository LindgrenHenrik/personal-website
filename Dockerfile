# Stage 1: Build the Hugo site
FROM alpine:latest AS build

# Install Hugo
RUN apk add --update hugo

# Set working directory for Hugo
WORKDIR /opt/HugoApp

# Copy your Hugo site source code
COPY . .

# Run Hugo to generate the static site in /public
RUN hugo

# Stage 2: Serve the site with NGINX
FROM nginx:1.25-alpine

# Set the NGINX working directory
WORKDIR /usr/share/nginx/html

# Copy the generated static site into NGINX's serving directory
COPY --from=build /opt/HugoApp/public .

# Expose port 80 for serving
EXPOSE 80/tcp
