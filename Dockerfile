FROM tomcat
MAINTAINER Kiran@mail.com

COPY jb-hello-world-maven-0.2.0.jar /usr/local/tomcat/webapps/
ENV JPDA_ADDRESS 8000
EXPOSE 8000
ENTRYPOINT ["catalina.sh", "jpda","run"]
CMD echo "jsptomcat is launched"
