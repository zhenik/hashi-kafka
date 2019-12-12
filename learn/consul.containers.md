# Containers

// server
```
docker run \
    -d \
    -p 8500:8500 \
    -p 8600:8600/udp \
    --name=badger \
    consul agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0
```

// members
`docker exec badger consul members`

// client
```
docker run \
   --name=fox \
   consul agent -node=client-1 -join=172.17.0.2
```

// service
```
docker run \
   -p 9001:9001 \
   -d \
   --name=weasel \
   hashicorp/counting-service:0.0.2
```

// register service in consul  
`docker exec fox /bin/sh -c "echo '{\"service\": {\"name\": \"counting\", \"tags\": [\"go\"], \"port\": 9001}}' >> /consul/config/counting.json"`

// reload consul config  
`docker exec fox consul reload`

// discover service via consul dns  
`dig @127.0.0.1 -p 8600 counting.service.consul`