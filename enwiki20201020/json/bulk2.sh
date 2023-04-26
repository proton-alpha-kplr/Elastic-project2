split -l 1000 part-01.json.ndjson part-01-chunk-
for file in part-01-chunk-*; do curl -XPOST "https://9200-protonalpha-elasticproj-29z4lx9fai3.ws-eu95.gitpod.io/movies-db2/_bulk?pretty" -H "Content-Type: application/json" --data-binary "@$file"; done
