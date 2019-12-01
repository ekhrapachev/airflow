FROM python:3.7-slim

ARG AIRFLOW_USER_HOME=/opt/airflow
ARG USER=airflow

ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}

RUN apt-get update && apt-get install -y \
    build-essential \
    unixodbc-dev \
    procps \
    && useradd -ms /bin/bash -d ${AIRFLOW_USER_HOME} ${USER} \
    && pip install --upgrade pip

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

ADD /script ${AIRFLOW_USER_HOME}/script

RUN chown -R ${USER}:${USER} ${AIRFLOW_USER_HOME}\
     && chmod 755 -R ${AIRFLOW_USER_HOME}

EXPOSE 8080

USER ${USER}
WORKDIR ${AIRFLOW_USER_HOME}
# ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/bin/bash" ]