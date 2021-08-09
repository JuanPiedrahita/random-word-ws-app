data "aws_iam_policy_document" "lambda_assume_role_policies" {
  for_each = local.api_resources

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_role_policies" {
  for_each = local.api_resources

  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.aws_region}:*:log-group:/aws/lambda/${each.value.name}:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

data "archive_file" "lambda_zip_files" {
  for_each = local.api_resources

  type        = "zip"
  output_path = each.value.output_path
  source_dir  = each.value.source_dir
}

# Get Random Word Permissions
data "aws_iam_policy_document" "get_random_word_lambda_policy" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]

    resources = [
      aws_dynamodb_table.words_dynamodb_table.arn
    ]
  }

  statement {
    actions = [
      "kms:Decrypt",
    ]

    resources = [
      aws_kms_key.words_kms_key.arn
    ]
  }
}
