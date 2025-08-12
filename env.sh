#!/bin/bash
# Impala environment configuration
# Lokasi instalasi Impala
export IMPALA_HOME=/opt/impala
export IMPALA_BIN_DIR=$IMPALA_HOME/bin
export JAVA_BIN=$JAVA_HOME/bin/java
export JAVA_HOME=/usr/lib/jvm/java-1.8.0
export PATH=$JAVA_HOME/bin:$PATH

# Fix libjvm.so issue
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$LD_LIBRARY_PATH:/usr/yava/current/hadoop/lib/native

# Set IMPALA_HOME to avoid dirname error
export IMPALA_HOME=/opt/impala

# Avoid unbound CLASSPATH error
export CLASSPATH=${CLASSPATH:-""}

# Lokasi Hadoop & Hive
export HADOOP_HOME=${HADOOP_HOME:-/usr/yava/current/hadoop-client}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$HADOOP_HOME/conf}
export HIVE_HOME=${HIVE_HOME:-/usr/yava/current/hive-server2}
export HIVE_CONF_DIR=${HIVE_CONF_DIR:-$HIVE_HOME/conf}

# Tambahan CLASSPATH
export CLASSPATH=${CLASSPATH}:${HADOOP_CONF_DIR}:${HIVE_CONF_DIR}

# Native libs
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/yava/current/hadoop/lib/native

# Direktori log & PID
export IMPALA_LOG_DIR=/var/log/impala
export IMPALA_PID_DIR=/var/run/impala

# Heap size & JVM GC options
IMPALA_GC_OPTS="-XX:+UseG1GC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps \
-XX:+PrintGCCause -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 \
-XX:GCLogFileSize=10M"

# impalad JVM options
export IMPALAD_JAVA_OPTS="-Xmx4096m -Xms1024m -Xloggc:${IMPALA_LOG_DIR}/impalad-gc-%t.log ${IMPALA_GC_OPTS}"

# catalogd JVM options
export CATALOGD_JAVA_OPTS="-Xmx2048m -Xms512m -Xloggc:${IMPALA_LOG_DIR}/catalogd-gc-%t.log ${IMPALA_GC_OPTS}"

# statestored JVM options
export STATESTORED_JAVA_OPTS="-Xmx1024m -Xms512m -Xloggc:${IMPALA_LOG_DIR}/statestored-gc-%t.log ${IMPALA_GC_OPTS}"

# Admissiond (opsional)
export ADMISSIOND_JAVA_OPTS="-Xmx1024m -Xms512m -Xloggc:${IMPALA_LOG_DIR}/admissiond-gc-%t.log ${IMPALA_GC_OPTS}"

# PID file path
export IMPALAD_PIDFILE=${IMPALA_PID_DIR}/impalad.pid
export CATALOGD_PIDFILE=${IMPALA_PID_DIR}/catalogd.pid
export STATESTORED_PIDFILE=${IMPALA_PID_DIR}/statestored.pid
export ADMISSIOND_PIDFILE=${IMPALA_PID_DIR}/admissiond.pid

# Core dump (opsional)
# ulimit -c unlimited

# Metastore connection (opsional, jika ingin override default)
# export HIVE_METASTORE_URI=thrift://metastore-host:9083
