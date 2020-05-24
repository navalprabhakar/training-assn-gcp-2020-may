FROM openjdk:8-jre-alpine
ADD target/np-service-order-*.jar app.jar
EXPOSE 9092
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
