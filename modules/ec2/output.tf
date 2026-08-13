output "ami_webtier" {
  value = aws_ami_from_instance.WebTier.id
}
