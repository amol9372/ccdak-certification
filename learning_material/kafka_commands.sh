## Add SCRAM-SHA-256 user 'alice' with password 'alice-secret'
kafka-configs --bootstrap-server localhost:9092,localhost:9094,localhost:9096 \
  --alter \
  --add-config 'SCRAM-SHA-256=[password=alice-secret]' \
  --entity-type users \
  --entity-name alice \
  --command-config client.properties

## Describe all users to verify 'alice' has been added
kafka-configs --bootstrap-server localhost:9092 \
  --command-config client.properties \
  --describe \
  --entity-type users

## List all ACLs to verify no ACLs exist initially
kafka-acls --bootstrap-server localhost:9092 --command-config client.properties --list

