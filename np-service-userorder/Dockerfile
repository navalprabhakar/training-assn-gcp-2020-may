FROM openjdk:8-jre-alpine
ADD target/np-service-userorder-*.jar app.jar
EXPOSE 9090
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
