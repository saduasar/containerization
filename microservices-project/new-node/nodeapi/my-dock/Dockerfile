# Stage 1: Build stage using Maven
FROM node:14  AS build

# Set the working directory inside the container for the build stage
WORKDIR /build/

#RUN npm install -g @angular/cli -y

# Copy the entire content of the current directory into the Docker image
COPY . .

# Build the Maven project and package it into a WAR file
RUN npm install express
RUN npm install 


# Stage 2: Deployment stage using Tomcat
FROM node:14


WORKDIR /app
# Remove any existing files related to the default ROOT application in Tomcat's webapps directory


#Copy the WAR file from the previous build stage into the Tomcat webapps directory, renaming it to ROOT.war
COPY --from=build /build/* .

#Expose port 8080 to allow external access to the Tomcat server
EXPOSE 5000


CMD ["/bin/sh", "-c", "npm start"]
