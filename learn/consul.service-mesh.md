# Service Mesh

## Register services
`consul services register -http-addr=http://172.17.0.1:8500 ./learn/consul/config/counting.hcl`  

`consul services register -http-addr=http://172.17.0.1:8500 ./learn/consul/config/dashboard.hcl`  

`consul catalog services -http-addr=http://172.17.0.1:8500`

```
consul connect proxy -http-addr=http://172.17.0.1:8500 -sidecar-for counting > counting-proxy.log & consul connect proxy -http-addr=http://172.17.0.1:8500 -sidecar-for dashboard > dashboard-proxy.log &
```
