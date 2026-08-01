output "contact_api_url" {
  description = "Build-time env CONTACT_API_URL for nuxt generate"
  value       = "${aws_apigatewayv2_api.contact.api_endpoint}/contact"
}

output "ses_from_email" {
  value = aws_ses_email_identity.contact.email
}

output "ses_verification_hint" {
  value = "Open the verification email AWS SES sent to ${var.from_email} after apply"
}

output "site_url" {
  value = "https://${var.site_subdomain}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.site.domain_name
}

output "turnstile_site_key" {
  description = "Public Turnstile site key for Nuxt build (TURNSTILE_SITE_KEY)"
  value       = var.turnstile_site_key
}
