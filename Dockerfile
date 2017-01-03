FROM epahomov/docker-zeppelin:latest

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

RUN apt-get update
RUN apt-get install -y maven

RUN git clone  --branch develop https://github.com/epahomov/Hive-JSON-Serde.git /serde
WORKDIR /serde
RUN mvn -Pcdh5 clean install
RUN cp ./json-serde/target/json-serde*SNAPSHOT.jar ./json-serde.jar
RUN cp ./json/target/json*SNAPSHOT.jar ./json.jar
RUN cp ./json-serde-cdh5-shim/target/json-serde*SNAPSHOT.jar json-serde-shim.jar

RUN echo "spark.jars /serde/json-serde.jar,/serde/json.jar,json-serde-shim.jar" >> /spark/conf/spark-defaults.conf