# Stage 1: Build stage using Maven
FROM node:14  AS build

# Set the working directory inside the container for the build stage
WORKDIR /build/

#RUN npm install -g @angular/cli -y

# Copy the entire content of the current directory into the Docker image
COPY . .

# Build the Maven project and package it into a WAR file
RUN npm install && npm run build --prod


# Stage 2: Deployment stage using Tomcat
FROM nginx 

# Remove any existing files related to the default ROOT application in Tomcat's webapps directory


#Copy the WAR file from the previous build stage into the Tomcat webapps directory, renaming it to ROOT.war
COPY --from=build /build/dist/client/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

#Expose port 8080 to allow external access to the Tomcat server
EXPOSE 80


