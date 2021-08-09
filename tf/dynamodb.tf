
resource "aws_dynamodb_table" "words_dynamodb_table" {
  name         = var.words_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "word"

  attribute {
    name = "word"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.words_kms_key.arn
  }

  tags = merge(local.tags, {
    Name = var.words_table_name
  })

  lifecycle {
    ignore_changes = [ttl]
  }
}
