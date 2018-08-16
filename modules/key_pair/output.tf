output "id" {
  description = "ID of key pair"
  value       = "${aws_key_pair.key_pair.id}"
}
