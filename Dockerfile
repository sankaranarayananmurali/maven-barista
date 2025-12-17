# ---------- Build stage ----------
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ---------- Runtime stage ----------
FROM tomcat:10-jdk21

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR as ROOT application
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat listens on 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
