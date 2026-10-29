
resource "aws_apigatewayv2_api" "lms" {
  name          = "lab09-lms-2026-api-dev"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lms" {
  api_id                 = aws_apigatewayv2_api.lms.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.lms.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "lms" {
  api_id    = aws_apigatewayv2_api.lms.id
  route_key = "GET /health"
  target    = "integrations/${aws_apigatewayv2_integration.lms.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.lms.id
  name        = "dev"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lms.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lms.execution_arn}/*/GET/health"
}
