# Use a base image with Java 21.0.2 pre-installed
FROM openjdk:latest


# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file into the container at specified path
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar /app/spring-petclinic-3.2.0-SNAPSHOT.jar

# Specify the command to run your application
CMD ["java", "-jar", "spring-petclinic-3.2.0-SNAPSHOT.jar"]

