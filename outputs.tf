output "ssm_parametrs" {
  value     = aws_ssm_parameter.parameters.*
  sensitive = true
}