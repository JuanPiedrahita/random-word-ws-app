resource "aws_lambda_permission" "lambda_functions_api_permissions" {
  for_each = local.api_resources

  statement_id  = "AllowAPIAccess"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_functions[each.key].function_name
  principal     = "apigateway.amazonaws.com"
  # source_arn    = "${aws_apigatewayv2_api.ws_api.execution_arn}/${var.api_stage_name}/*/*"
}
