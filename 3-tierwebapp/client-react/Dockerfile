# Specify Dockerfile syntax version
# (this is optional, but recommended for clarity)
# syntax=docker/dockerfile:1.5

# Start with the official Node.js image as the build stage
FROM node:19.4-bullseye AS build

# Set the working directory for the build stage
WORKDIR /usr/src/app

# Copy only necessary files for dependency installation to improve caching
COPY package*.json ./

# Speed up dependency installation using cache mounts
RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm install

# Copy the application source code
COPY . .

# Run the build process (e.g., npm run build)
RUN npm run build

# Start a new stage using the nginx-unprivileged image for the deployable image. Also this particular images allows us to execute commnads as nonroot. This is good for security.
FROM nginxinc/nginx-unprivileged:1.23-alpine-perl

# Copy the nginx configuration file
COPY --link nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built application from the build stage to the nginx HTML directory
COPY --link --from=build /usr/src/app/dist/ /usr/share/nginx/html

# Expose port 8080 for the nginx server
EXPOSE 8080

