resource "aws_apigatewayv2_api" "ws_api" {
  name                       = "${local.base_name}-api"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
  tags = merge(local.tags, {
    Name = "${local.base_name}-api"
  })
}

resource "aws_apigatewayv2_stage" "ws_api_stage" {
  api_id        = aws_apigatewayv2_api.ws_api.id
  name          = var.api_stage_name
  deployment_id = aws_apigatewayv2_deployment.ws_api_deployment.id

  tags = merge(local.tags, {
    Name = var.api_stage_name
  })

  depends_on = [
    aws_apigatewayv2_route.ws_api_routes,
    aws_apigatewayv2_integration.ws_api_integrations,
    aws_apigatewayv2_integration_response.ws_api_integrations_respoonses,
    aws_apigatewayv2_route_response.ws_api_routes_responses,
  ]
}

resource "aws_apigatewayv2_deployment" "ws_api_deployment" {
  api_id      = aws_apigatewayv2_api.ws_api.id
  description = "${var.api_stage_name} deployment"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_apigatewayv2_route.ws_api_routes,
    aws_apigatewayv2_integration.ws_api_integrations,
    aws_apigatewayv2_integration_response.ws_api_integrations_respoonses,
    aws_apigatewayv2_route_response.ws_api_routes_responses,
  ]
}

#  Routes
resource "aws_apigatewayv2_route" "ws_api_routes" {
  for_each = local.api_resources

  api_id             = aws_apigatewayv2_api.ws_api.id
  route_key          = each.value.route_key
  operation_name     = each.value.operation_name
  api_key_required   = false
  authorization_type = "NONE"
  target             = "integrations/${aws_apigatewayv2_integration.ws_api_integrations[each.key].id}"
}

resource "aws_apigatewayv2_integration" "ws_api_integrations" {
  for_each = local.api_resources

  api_id           = aws_apigatewayv2_api.ws_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.lambda_functions[each.key].invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration_response" "ws_api_integrations_respoonses" {
  for_each = local.api_resources

  api_id                   = aws_apigatewayv2_api.ws_api.id
  integration_id           = aws_apigatewayv2_integration.ws_api_integrations[each.key].id
  integration_response_key = "/200/"
}

resource "aws_apigatewayv2_route_response" "ws_api_routes_responses" {
  for_each = local.api_resources

  api_id             = aws_apigatewayv2_api.ws_api.id
  route_id           = aws_apigatewayv2_route.ws_api_routes[each.key].id
  route_response_key = "$default"
}
