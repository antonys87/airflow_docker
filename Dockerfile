
FROM ubuntu:latest
MAINTAINER Antony

# Airflow
ENV AIRFLOW_VERSION=1.9.0
ENV AIRFLOW_HOME=/usr/local/airflow

#Add airflow user

RUN useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow

RUN apt-get update \
    && apt-get install -y \
    curl \
    python-pip \
    python-requests \
    apt-utils \
    netcat \
    locales \
    && python -m pip install -U pip \
    && pip install Cython \
    && pip install pytz \
    && pip install pyOpenSSL \
    && pip install ndg-httpsclient \
    && pip install pyasn1 \
    && pip install apache-airflow[crypto,celery,postgres,hive,hdfs,jdbc]==$AIRFLOW_VERSION \
    && pip install celery[redis]==4.0.2 \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

COPY script/entrypoint.sh /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

RUN \
    chown -R airflow: ${AIRFLOW_HOME} \
    && chmod +x /entrypoint.sh

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
