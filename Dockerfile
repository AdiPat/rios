# Use OpenJDK as base image
FROM openjdk:21-jdk-alpine

# Set working directory
WORKDIR /app

# Copy built JAR file into the container
COPY target/my-api-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
