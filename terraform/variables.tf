variable "ssh_port" {
  description = "ssh access"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "The port, server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "php_port" {
  description = "The php-fpm port"
  type        = number
  default     = 9000
}
variable "nodes_count" {
  type    = number
  default = 3
}

variable "key_pair" {
  type    = string
  default = "ansible"
}