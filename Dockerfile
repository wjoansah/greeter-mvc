FROM openjdk:21-jdk-slim

LABEL authors="wjoansah"

RUN groupadd --system app && useradd --system app -g app
USER app

EXPOSE 3001

COPY target/*.war app.war

ENTRYPOINT ["java", "-jar", "app.war"]