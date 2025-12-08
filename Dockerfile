# Build stage uses maven to pack the web application
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY . /app

RUN mvn clean package -DskipTests

# final stage uses to host the web application using tomcat 10 with jdk 17

FROM tomcat:10-jdk17

# removing the default webpage 
RUN  rm -rf /usr/local/tomcat/webapps/*

#saving the our app.war as Root.war to see the rootpath 
COPY --from=Build /app/target/*.war /usr/local/tomcat/webapps/Root.war

EXPOSE 8089

CMD [ "catalina.sh", "run"]
