# Dockerfile for a basic static HTML site

FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
