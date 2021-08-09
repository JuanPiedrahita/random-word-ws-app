output "words_table_name" {
  value       = aws_dynamodb_table.words_dynamodb_table.name
  sensitive   = false
  description = "DynamoDB Words Table Name"
}

output "api_wss_uri" {
  value       = aws_apigatewayv2_stage.ws_api_stage.invoke_url
  sensitive   = false
  description = "The WSS Protocol URI to connect to API"
}
