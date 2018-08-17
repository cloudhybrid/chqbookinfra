variable "target_group_name" {
  default     = ""
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = "80"
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks."
  default     = "HTTP"
}

variable "vpc_id" {
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "health_check_interval" {
  description = "Interval in seconds on which the health check against backend hosts is tried."
  default     = 10
}

variable "health_check_path" {
  description = "The URL the ELB should use for health checks."
  default     = "/yash"
}

variable "health_check_port" {
  description = "The port used by the health check if different from the traffic-port."
  default     = "traffic-port"
}

variable "health_check_timeout" {
  description = "Seconds to leave a health check waiting before terminating it and calling the check unhealthy."
  default     = 5
}

variable "health_check_matcher" {
  description = "The HTTP codes that are a success when checking TG health."
  default     = "200-299"
}

variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group."
  default     = "instance"
}
