# Zip is built by scripts/pack-lambda.sh (or apply-infra.sh) before apply.
# Avoids hashicorp/archive walking iCloud-backed node_modules (hangs / OOM).
locals {
  contact_lambda_zip = "${path.module}/build/contact-lambda.zip"
}

resource "aws_iam_role" "contact_lambda" {
  name = "${var.project_name}-contact-lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "contact_lambda_basic" {
  role       = aws_iam_role.contact_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "contact_lambda_ses" {
  name = "${var.project_name}-contact-ses-send"
  role = aws_iam_role.contact_lambda.id

  # Least privilege: only verified From (/ To) identities, not Resource "*"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ses:SendEmail", "ses:SendRawEmail"]
      Resource = concat(
        [aws_ses_email_identity.contact.arn],
        aws_ses_email_identity.inbox[*].arn,
      )
    }]
  })
}

resource "aws_lambda_function" "contact" {
  function_name = "${var.project_name}-contact"
  role          = aws_iam_role.contact_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs22.x"
  timeout       = 15
  memory_size   = 128

  # Caps parallel abuse / runaway concurrency cost
  reserved_concurrent_executions = var.lambda_reserved_concurrency

  filename         = local.contact_lambda_zip
  source_code_hash = fileexists(local.contact_lambda_zip) ? filebase64sha256(local.contact_lambda_zip) : ""

  environment {
    variables = {
      TO_EMAIL             = var.to_email
      FROM_EMAIL           = var.from_email
      ALLOWED_ORIGINS      = join(",", var.allowed_origins)
      TURNSTILE_SECRET_KEY = var.turnstile_secret_key
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.contact_lambda_basic,
    aws_iam_role_policy.contact_lambda_ses,
    aws_ses_email_identity.contact,
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.contact_lambda_zip)
      error_message = "Missing infra/contact/build/contact-lambda.zip. From the repo root run: bash scripts/pack-lambda.sh"
    }
  }
}

resource "aws_cloudwatch_log_group" "contact_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.contact.function_name}"
  retention_in_days = 14
}
