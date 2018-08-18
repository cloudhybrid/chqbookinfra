variable "name" {
  default = ""
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description', 'cidr_block', 'security_group_id'])"
  type        = "map"

  default = {
    http-rule  = [80, 80, "tcp", "HTTP"]
    ssh-rule   = [22, 22, "tcp", "SSH"]
    https-rule = [443, 443, "tcp", "HTTPS"]
    kafka-rule = [9095, 9095, "tcp", "Kafka_Port"]
    zookeeper-rule = [2181, 2181, "tcp", "Zookeeper_Port"]
    _          = ["", "", ""]
  }
}
