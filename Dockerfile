FROM tomcat:8.0-alpine

LABEL maintainer=”deepak@softwareyoga.com”

ADD jb-hello-world-maven-0.2.0.jar /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [“catalina.sh”, “run”]
