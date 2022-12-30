FROM tomcat:8.0-alpine

LABEL maintainer=”kiran.ug123@gmail.com.com”

ADD jb-hello-world-maven-0.2.0-shaded.jar /usr/local/tomcat/webapps/

CMD [“catalina.sh”, “run”]
