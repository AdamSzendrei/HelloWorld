FROM openjdk:17-jdk-slim
COPY target/*.jar /helloworld.jar
EXPOSE 4000
CMD ["java", "-jar", "/helloworld.jar"]