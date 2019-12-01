#!/bin/bash
set -e

export AIRFLOW_HOME=/opt/airflow

airflow initdb

airflow webserver -p 8080 -D
echo $?

export AIRFLOW__CORE__LOAD_EXAMPLES
AIRFLOW__CORE__LOAD_EXAMPLES=False

sleep 5

airflow scheduler -D
exec "$@"