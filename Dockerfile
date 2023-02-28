#FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.86/bin/apache-tomcat-8.5.86.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.86/* /usr/local/tomcat/
COPY target/jb-hello-world-maven-0.2.0.jar /usr/local/tomcat/webapps/
EXPOSE 8080

CMD /usr/local/tomcat/bin/catalina.sh run
