# 1. DockerFile : Spring Boot Properties Docker Example
# 2. OS : CentOS Linux release 7.4.1708 (Core)
# 3. JDK Version : Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
FROM flyceek/centos7-jdk

ENV DOC_ROOT /app_dev
ENV APP_VER=0.0.1
ENV SPRING_PROFILES_ACTIVE docker

#  locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN mkdir -p /app_dev

RUN chmod -R 755 /app_dev

ADD ./target/springboot-properties-docker-${APP_VER}.jar /app_dev/springboot-properties-docker-${APP_VER}.jar

VOLUME /app_dev

EXPOSE 8989

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app_dev/springboot-properties-docker-${APP_VER}.jar"]