output "node_fqdn" {
  value       = aws_instance.node.*.public_dns
  description = "The domain name of the load balancer"
}