# springboot-properties-docker
This example shows how to use springboot properties in docker or docker-compose

In spring boot, variable processing priority is given according to the position of the property variable. 


##### The rest url that validates the propertis variable looks like this:

```shell
http://localhost:8080/dynamicvalue
---
curl -GET http://localhost:8080/dynamicvalue
```

## How to use

1.maven build package jar
```shell
mvn clean package -DskipTest
```

2.CASE[1]: Run application and check variable 'dynamic.value' in application.properties[1]

```shell
java -jar ./target/springboot-properties-docker-0.0.1.jar

```
* result : helloworld

3.CASE[2]:Add the dynamic.value variable to the OS environment variable and run this application.[2]
```shell
> env dynamic.value=this_is_os_variable bash
> java -jar ./target/springboot-properties-docker-0.0.1.jar 
```
* result : this_is_os_variable

4.CASE[3]:Add a variable to the command line when jar file excution
```shell
> java -jar ./target/springboot-properties-docker-0.0.1.jar --dynamic.value=commandline_variable 
```

* result : commandline_variable

## In Docker image Configuration
In this Dockerfile, 
This image extends centos7 and jdk1.8 and container has its own environment.
It would be enough to declare what you want to override as environment properties and Spring Boot will fetch them, since environment variables take precedence over the yml files.

##### 1.Docker build app 
 
```shell
> docker build -t test/test . 
```

##### 2.Docker run app in command

```shell
> docker run -rm -p8080:8080 -e dynamic.value=this_is_docker_os_variable test/test 
```
* result : this_is_docker_os_variable

##### 3.Docker-compose sample
```shell
> docker-compose -f ./docker-compose.yml up 


---
# after test
> docker-compose stop
> docker-cmpose rm
```
* result : this_is_docker_os_variable

Here you have an example of how I launch a simple app environment with docker compose. As you see, I declare the 'dynamic.value' property here as an environment variable, so it overrides whatever you've got inside jar application.properties file.
```yaml
    environment:
      dynamic.value : this_is_docker_os_variable
```




### The priority rank according to the properties position is as follows.
```text
1. 'Spring-boot-dev-tools.properties' file in the user's home directory
2. @TestPropertySource
3. The properties attribute of the @SpringBootTest annotation
4. Command line arguments                           <-------[3]
5. Properties in SPRING_APPLICATION_JSON (environment variable or system property)
6. ServletConfig Parameters
7. ServletContext parameter
8. java:comp/env JNDI attribute
9. System.getProperties () Java System Properties
10. OS environment variables                        <-------[2]
11. RandomValuePropertySource
12. Application properties for a specific profile outside the JAR
13. Application properties for a specific profile in the JAR
14. Application properties outside the JAR
15. Application properties in the JAR                <------[1]
16. @PropertySource
17. Default property (SpringApplication.setDefaultProperties)
```
