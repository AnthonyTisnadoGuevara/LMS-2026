
# LMS-2026 - Infraestructura AWS
# Laboratorio 09 - Entorno dev

resource "aws_cognito_user_pool" "lms" {
  name = "lab09-lms-2026-users-dev"

  username_attributes = ["email"]

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = {
    Name = "lab09-lms-2026-users-dev"
  }
}

resource "aws_cognito_user_pool_client" "lms" {
  name         = "lab09-lms-2026-client-dev"
  user_pool_id = aws_cognito_user_pool.lms.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}
