
output "cognito_user_pool_id" {
  description = "ID del User Pool LMS"
  value       = aws_cognito_user_pool.lms.id
}

output "cognito_client_id" {
  description = "ID del cliente Cognito LMS"
  value       = aws_cognito_user_pool_client.lms.id
}

output "lms_api_url" {
  description = "URL de la API del laboratorio LMS"
  value       = "${aws_apigatewayv2_stage.dev.invoke_url}/health"
}

output "lms_lambda_name" {
  description = "Nombre de la funcion Lambda"
  value       = aws_lambda_function.lms.function_name
}
