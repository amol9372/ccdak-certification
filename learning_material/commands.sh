### Produce messages to topic
confluent kafka topic produce learn_schema_registry \
  --api-key GD4JAIWZMHZ2CPTA --api-secret mvm1cqdPoE0+0feppCRin4RpZ3vgSsbf3qku1qqadKTRzsnTkzE+jkVhfX5kSN4I \
  --value-format protobuf --schema src/main/proto/purchase.proto \
  --schema-registry-endpoint https://psrc-57o65q.us-west2.gcp.confluent.cloud \
  --schema-registry-api-key FEVIYTA4WJDL4OGY \
  --schema-registry-api-secret JFzNrC/WS+T9GthyXiGjBIBqk6bp/9Z/uWYqxKOoNqH4Dr6GC6u0koeRYIrvwANJ

### Register Schema
confluent schema-registry schema create \
  --subject purchases-value \
  --schema src/main/proto/purchase.proto \
  --type PROTOBUF

### Register Schema Kafka API
jq '. | {schema: tojson}' src/main/avro/purchase.avsc |
  curl -u FEVIYTA4WJDL4OGY:JFzNrC/WS+T9GthyXiGjBIBqk6bp/9Z/uWYqxKOoNqH4Dr6GC6u0koeRYIrvwANJ \
    -X POST https://psrc-57o65q.us-west2.gcp.confluent.cloud/subjects/purchases2-value/versions \
    -H "Content-Type: application/json" \
    -d @-

### Alter Topic Configs (Setting retention to 0)
kafka-configs --bootstrap-server pkc-12576z.us-west2.gcp.confluent.cloud:9092 --alter \
  --entity-type topics \
  --entity-name learn_schema_registry \
  --add-config retention.ms=0 \
  --command-config client.properties
