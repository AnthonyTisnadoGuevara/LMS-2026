
data "archive_file" "lms_lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda/lms-function.zip"
}

resource "aws_cloudwatch_log_group" "lms_lambda" {
  name              = "/aws/lambda/lab09-lms-2026-dev"
  retention_in_days = 1
}

resource "aws_iam_role" "lambda_execution" {
  name = "lab09-lms-lambda-execution-dev"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_logs" {
  name = "lab09-lms-lambda-logs-dev"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "${aws_cloudwatch_log_group.lms_lambda.arn}:*"
    }]
  })
}

resource "aws_lambda_function" "lms" {
  function_name    = "lab09-lms-2026-dev"
  filename         = data.archive_file.lms_lambda.output_path
  source_code_hash = data.archive_file.lms_lambda.output_base64sha256

  role    = aws_iam_role.lambda_execution.arn
  handler = "index.handler"
  runtime = "python3.13"

  memory_size = 128
  timeout     = 3

  depends_on = [
    aws_iam_role_policy.lambda_logs,
    aws_cloudwatch_log_group.lms_lambda
  ]
}
