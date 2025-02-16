# Stage 1: Build the site using Hugo
FROM klakegg/hugo:ext-alpine AS builder
WORKDIR /src
# Copy your site’s source code
COPY . .
# Build the site into the "public" folder
RUN hugo --minify

# Stage 2: Serve the site with NGINX
FROM nginx:alpine
# Remove the default NGINX website
RUN rm -rf /usr/share/nginx/html/*
# Copy the generated site from the builder stage to NGINX's serving directory
COPY --from=builder /src/public /usr/share/nginx/html
# Expose port 80 to the outside world
EXPOSE 80
# Run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
