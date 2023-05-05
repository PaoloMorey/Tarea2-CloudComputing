FROM ubuntu:20.04

ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
   python2.7 \
   wget \
   openjdk-8-jdk \
   tzdata

ENV SPARK_VERSION=1.5.2 \
HADOOP_VERSION=2.6

RUN DOWNLOAD_URL_SPARK="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    && wget --no-verbose -O apache-spark.tgz  "${DOWNLOAD_URL_SPARK}"\
    && mkdir -p /home/spark \
    && tar -xf apache-spark.tgz -C /home/spark --strip-components=1 \
    && rm apache-spark.tgz

ENV PYSPARK_PYTHON=/usr/bin/python2.7

COPY WordCount.py /tmp

CMD ["/home/spark/bin/spark-submit", "tmp/WordCount.py"]
