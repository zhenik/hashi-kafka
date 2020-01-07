#sh consul-template -consul-addr "172.17.0.1:8500" -template "./tpl/zoo.tpl:/etc/nomad.d/jobs/zookeeper/templates/zoo.tpl"
#consul-template -once -consul-addr=${CONSUL_HTTP_ADDR} -template /consul-templates/zookeeper-services.ctpl:$ZOO_CONF_DIR/zoo.cfg.dynamic
sudo consul-template -consul-addr=http://172.17.0.1:8500 -once -template ./templates/zookeeper-services.ctpl:out.txt