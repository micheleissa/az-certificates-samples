```
# run the following command to check how many messages are in the queue
az servicebus queue show \
    --resource-group <rg-name> \
    --name <queue-name> \
    --query messageCount \
    --namespace-name <namespace-name>
```
```
# run the following command to check how many messages are in the topic
az servicebus topic subscription show \
    --resource-group <rg-name> \
    --namespace-name <namespace-name> \
    --topic-name <topic-name> \
    --name Americas \
    --query messageCount
```

