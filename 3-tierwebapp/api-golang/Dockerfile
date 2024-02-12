# Start with the official Golang image as the build stage
FROM golang:1.19-bullseye AS build

# Add a non-root user to enhance security
RUN useradd -u 1001 nonroot

# Set the working directory
WORKDIR /app

# Copy only necessary files for dependency installation to improve caching
COPY go.mod go.sum ./

# Speed up dependency installation using cache mounts
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download

# Copy the application source code
COPY . .

# Compile the healthcheck binary
RUN go build \
    -ldflags="-linkmode external -extldflags -static" \
    -tags netgo \
    -o healthcheck \
    ./healthcheck/healthcheck.go

# Compile the main application binary with static linking
RUN go build \
    -ldflags="-linkmode external -extldflags -static" \
    -tags netgo \
    -o api-golang

# Start a new stage using the 'scratch' image for the deployable image
FROM scratch

# Set the Gin mode environment variable to 'release'
ENV GIN_MODE=release

# Set the working directory
WORKDIR /

# Copy the /etc/passwd file from the build stage to enable non-root user usage
COPY --from=build /etc/passwd /etc/passwd

# Copy the healthcheck binary from the build stage
COPY --from=build /app/healthcheck/healthcheck healthcheck

# Copy the main application binary from the build stage
COPY --from=build /app/api-golang api-golang

# Switch to the non-root user for enhanced security
USER nonroot

# Expose port 8080 for the application
EXPOSE 8080

# Define the command to run the application
CMD ["/api-golang"]

