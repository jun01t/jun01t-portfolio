variable "aws_region" {
  type        = string
  description = "AWS region for contact API, SES, and S3 origin"
  default     = "ap-northeast-1"
}

variable "project_name" {
  type        = string
  description = "Name prefix for resources"
  default     = "jun01t-portfolio"
}

variable "to_email" {
  type        = string
  description = "Inbox that receives contact form messages"
  default     = "tmdjnch0901@gmail.com"
}

variable "from_email" {
  type        = string
  description = "Verified SES identity used as From"
  default     = "tmdjnch0901@gmail.com"
}

variable "allowed_origins" {
  type        = list(string)
  description = "CORS allowed origins for the contact API"
  default = [
    "https://jun01t-portfolio.jun01t.com",
  ]
}

variable "site_subdomain" {
  type        = string
  description = "Public site hostname served by CloudFront"
  default     = "jun01t-portfolio.jun01t.com"
}

variable "route53_zone_name" {
  type        = string
  description = "Hosted zone name that owns the site subdomain"
  default     = "jun01t.com"
}

variable "turnstile_site_key" {
  type        = string
  description = "Cloudflare Turnstile site key (public)"
  default     = ""
}

variable "turnstile_secret_key" {
  type        = string
  description = "Cloudflare Turnstile secret key (private)"
  sensitive   = true
  default     = ""
}

variable "api_throttle_rate_limit" {
  type        = number
  description = "API Gateway steady-state requests per second for /contact"
  default     = 5
}

variable "api_throttle_burst_limit" {
  type        = number
  description = "API Gateway burst limit for /contact"
  default     = 10
}

variable "lambda_reserved_concurrency" {
  type        = number
  description = "Max concurrent Lambda executions for the contact function"
  default     = 5
}

variable "monthly_budget_usd" {
  type        = number
  description = "Account monthly cost budget (USD) that emails alerts"
  default     = 5
}

variable "budget_alert_email" {
  type        = string
  description = "Email for AWS Budgets alerts"
  default     = "tmdjnch0901@gmail.com"
}
