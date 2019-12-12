# ACL
## Bootstrap the ACL System
Rule -> Policy -> Token

// Enable ACLs, deny all by default  (defined in agent config, check volume)
`docker-compose up -d`

// create the bootstrap token
`docker exec -it <container-id> consul acl bootstrap`

// any action with token  
`docker exec -it 5dcf consul members -token "04d3d7d5-c03d-93b9-e722-3ae5fb7a5541"`  <--- example


