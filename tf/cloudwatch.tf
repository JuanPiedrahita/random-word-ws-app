resource "aws_cloudwatch_log_group" "log_groups" {
  for_each = local.api_resources

  name              = "/aws/lambda/${aws_lambda_function.lambda_functions[each.key].function_name}"
  retention_in_days = each.value.log_retention_days
}
