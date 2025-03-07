#필요프로그램 설치
FROM openjdk:17-jdk-alpine as stage1

#파일 복사
WORKDIR /app
COPY gradle gradle
COPY src src
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
#빌드
RUN chmod 777 gradlew
RUN ./gradlew bootJar

#두번째 스테이지
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=stage1 /app/build/libs/*.jar app.jar


#실행 : CMD 또는 ENTRYPOINT를 통해 컨테이너를 배열형태의 명령어로 실행
ENTRYPOINT [ "java", "-jar", "app.jar" ]

#docker run --name my-spring -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:mariadb://host.docker.internal:3306/order_system my-spring:v1.0
