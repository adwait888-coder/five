
FROM eclipse-temurin:17-jre-jammy


RUN groupadd -r spring && useradd -r -g spring spring
USER spring:spring


WORKDIR /app


COPY --chown=spring:spring build/libs/spring-petclinic-4.0.0-SNAPSHOT.jar app.jar


ENV SPRING_PROFILES_ACTIVE=prod
EXPOSE 8080


ENTRYPOINT ["java", "-Xms256m", "-Xmx512m", "-jar", "app.jar"]