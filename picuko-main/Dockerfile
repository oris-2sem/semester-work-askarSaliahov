FROM openjdk:17-alpine
COPY /build/libs/picuko-0.0.1-SNAPSHOT.jar /usr/local/lib/picuko.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/picuko.jar"]