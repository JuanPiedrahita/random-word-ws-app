resource "aws_lambda_function" "lambda_functions" {
  for_each = local.api_resources

  function_name = each.value.name
  role          = aws_iam_role.lambda_roles[each.key].arn
  description   = each.value.description

  // code reference
  filename         = data.archive_file.lambda_zip_files[each.key].output_path
  source_code_hash = data.archive_file.lambda_zip_files[each.key].output_base64sha256

  memory_size = each.value.memory_size
  handler     = each.value.handler
  runtime     = each.value.runtime
  timeout     = each.value.timeout

  publish = false

  environment {
    variables = each.value.environment_variables
  }

  tags = merge(local.tags, {
    Name = each.value.name
  })
}

