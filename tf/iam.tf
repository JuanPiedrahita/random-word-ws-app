resource "aws_iam_role" "lambda_roles" {
  for_each = local.api_resources

  name                  = "${each.value.name}-iam-role"
  assume_role_policy    = data.aws_iam_policy_document.lambda_assume_role_policies[each.key].json
  force_detach_policies = "true"
  tags = merge(local.tags, {
    Name = "${each.value.name}-iam-role"
  })
}

resource "aws_iam_policy" "lambda_role_policies" {
  for_each = local.api_resources

  name   = "${each.value.name}-iam-role-policy"
  policy = data.aws_iam_policy_document.lambda_role_policies[each.key].json
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  for_each = local.api_resources

  role       = aws_iam_role.lambda_roles[each.key].name
  policy_arn = aws_iam_policy.lambda_role_policies[each.key].arn
}

# Get Random Word Permissions
resource "aws_iam_policy" "get_random_word_lambda_policy" {
  name   = "${aws_lambda_function.lambda_functions["get_random_word"].function_name}-get-word-policy"
  policy = data.aws_iam_policy_document.get_random_word_lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "get_random_word_lambda_policy_attachment" {
  role       = aws_iam_role.lambda_roles["get_random_word"].name
  policy_arn = aws_iam_policy.get_random_word_lambda_policy.arn
}
