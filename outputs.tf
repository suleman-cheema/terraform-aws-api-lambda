output "invoke_arn" {
  description = "ARN to be used for invoking Lambda Function"
  value       = aws_lambda_function.this.invoke_arn
}

output "function_name" {
  description = "Name of the lambda Function"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN identifying Lambda Function"
  value       = aws_lambda_function.this.arn
}
