resource "aws_kms_key" "words_kms_key" {
  description = "KMS for encrypting ${var.app_name} resources"
}

resource "aws_kms_alias" "words_kms_alias" {
  name          = "alias/${local.base_name}"
  target_key_id = aws_kms_key.words_kms_key.key_id
}
