resource "aws_ses_email_identity" "contact" {
  email = var.from_email
}

# When From and To differ, verify both addresses (sandbox-friendly).
resource "aws_ses_email_identity" "inbox" {
  count = var.to_email != var.from_email ? 1 : 0
  email = var.to_email
}
