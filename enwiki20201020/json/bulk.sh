#!/bin/sh

if [ -z "$1" ]
then
    echo "Usage: ./bulk_ingest.sh <index_name> [num_files]"
    echo "       ./bulk_ingest.sh <index_name>"
    echo "        |---- Ingests all .ndjson files in the current directory"
    echo "Options:"
    echo "  <index_name>: Name of the Elasticsearch index to ingest data into"
    echo "  <num_files>: Number of .ndjson files to ingest."
    echo "               Default: ingest all files in the current directory"
    exit 1
fi

if [ "$2" ]
then
  limit=$2
else
  limit=$(ls -1q *.ndjson | wc -l)
fi

echo "Indexing up to $limit files for index $1"

i=1
for file in *.ndjson
do
  if [ "$i" -gt "$limit" ]
  then
    break
  fi
  curl -XPOST "https://9200-protonalpha-elasticproj-29z4lx9fai3.ws-eu95.gitpod.io/$1/_bulk" \
  -H "Content-Type: application/json" \
  --data-binary "@$file" > ingest.log
  #sleep 10s
  i=$((i+1))
done
