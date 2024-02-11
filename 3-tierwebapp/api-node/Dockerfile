# Use the official Node.js Docker image with tag 19.6-alpine as the base image
FROM node:19.6-alpine

# Set the working directory inside the container to /usr/src/app
WORKDIR /usr/src/app

# Set the NODE_ENV environment variable to 'production' to define the deployment environment
ENV NODE_ENV production

# Copy package.json and package-lock.json (if it exists) from the host machine into the container's working directory
COPY package*.json ./

# Install dependencies specified in package.json and package-lock.json
# Use a cache volume to speed up npm installation by caching dependencies
# npm ci = clean install, --only=production = install only production dependencies and ignore dev dependencies
RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci --only=production

# Switch the user to 'node' for security reasons
USER node

# Copy the application source code from the host machine's ./src directory into the container's working directory
# The --chown=node:node option ensures that the files are owned by the 'node' user inside the container
COPY --chown=node:node ./src .

# Expose port 3000 to document that the container listens on this port at runtime
# This does not actually publish the port or make it accessible from outside the container
EXPOSE 3000

# Specify the default command to run when the container starts
CMD ["node", "index.js"]

