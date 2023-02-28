# Use the official Tomcat 9 image as the base image
FROM tomcat:9.0

# Set the working directory to the Tomcat webapps directory
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file of your application to the webapps directory

ADD target/jb-hello-world-maven-0.2.0.jar /usr/local/tomcat/webapps/

# Expose port 8080 for Tomcat to listen on
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]

