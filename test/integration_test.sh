#!/usr/bin/env bash

# required proper python environment
WD="$(pwd)/$(dirname $0)"
# prepare test db
HTTP_CONN='http://localhost:8123/'

echo 'drop database test_target_ck' | curl $HTTP_CONN -d @-
echo 'create database if not exists test_target_ck' | curl $HTTP_CONN -d @-
cat $WD/ddl_stream_1.sql | curl $HTTP_CONN -d @-
cat $WD/ddl_stream_2.sql | curl $HTTP_CONN -d @-

# ingest tap stream_1
# set PYTHONPATH ot repository root

function report() {
  echo 'test_target_ck.stream_1'
  echo 'select * from test_target_ck.stream_1' | curl $HTTP_CONN -d @-
  echo ''
  echo "test_target_ck.stream_2"
  echo 'select * from test_target_ck.stream_2' | curl $HTTP_CONN -d @-
  echo ''
}

echo -e '\n<< before ingestion >>'
report
export PYTHONPATH="$WD/../."
cat $WD/tap_stream_1.jsonl | python $WD/../yw_etl_target_clickhouse/main.py -c $WD/config.json
cat $WD/tap_stream_2.jsonl | python $WD/../yw_etl_target_clickhouse/main.py -c $WD/config.json
echo -e '\n<< after ingestion >>'
report
