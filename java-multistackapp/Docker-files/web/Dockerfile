# Use the official Nginx base image from Docker Hub
FROM nginx

# Remove the default Nginx configuration file
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file to the conf.d directory
COPY nginx.conf /etc/nginx/conf.d/

