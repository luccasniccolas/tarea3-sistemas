# Utilizamos una imagen base de Ubuntu
FROM ubuntu:20.04

# Instalación de herramientas básicas
RUN apt-get update && \
    apt-get install -y nano vim wget curl unzip

# Instalación de Java OpenJDK 8 (necesario para Hadoop)
RUN apt-get install -y openjdk-8-jdk

# Descargar e instalar Hadoop 3.4.0
RUN wget -O hadoop.tar.gz https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz && \
    tar -xzf hadoop.tar.gz -C /opt && \
    rm hadoop.tar.gz

# Descargar e instalar Pig
RUN wget -O pig.tar.gz https://downloads.apache.org/pig/latest/pig-0.17.0.tar.gz && \
    tar -xzf pig.tar.gz -C /opt && \
    rm pig.tar.gz

# Descargar e instalar Hive 3.1.3
RUN wget -O hive.tar.gz https://dlcdn.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz && \
    tar -xzf hive.tar.gz -C /opt && \
    rm hive.tar.gz

# Copiar el archivo CSV al contenedor
COPY merced_trace-1_13378400607429273214.branch_trace.467769.csv.gz /opt

# Configurar variables de entorno para Hadoop y Hive
ENV HADOOP_HOME=/opt/hadoop-3.4.0
ENV PIG_HOME=/opt/pig-0.17.0
ENV HIVE_HOME=/opt/apache-hive-3.1.3-bin
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PIG_HOME/bin:$HIVE_HOME/bin

# Configurar variables de entorno para Java (necesario para Hadoop)
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Ejemplo de CMD para mantener el contenedor en ejecución
CMD ["tail", "-f", "/dev/null"]
