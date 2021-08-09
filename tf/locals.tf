locals {
  base_name  = var.app_name
  aws_region = var.aws_region

  tags = {
    app         = var.app_name
    environment = var.environment
    deployment  = "terraform"
  }

  api_resources = {
    on_connect = {
      route_key      = "$connect"
      operation_name = "Onconnect"
      // Lambda parameters
      name                  = "${local.base_name}-on-connect"
      log_retention_days    = var.log_retention_days
      description           = "On connect resources"
      handler               = "app.handler"
      runtime               = "nodejs12.x"
      timeout               = 3
      memory_size           = 256
      environment_variables = { TABLE_NAME = aws_dynamodb_table.words_dynamodb_table.name }
      source_dir            = "../src/on-connect"
      output_path           = "../src/on-connect.zip"
    }
    on_disconnect = {
      route_key      = "$disconnect"
      operation_name = "Disconnect"
      // Lambda parameters
      name                  = "${local.base_name}-on-disconnect"
      log_retention_days    = var.log_retention_days
      description           = "On disconnect resources"
      handler               = "app.handler"
      runtime               = "nodejs12.x"
      timeout               = 3
      memory_size           = 256
      environment_variables = { TABLE_NAME = aws_dynamodb_table.words_dynamodb_table.name }
      source_dir            = "../src/on-disconnect"
      output_path           = "../src/on-disconnect.zip"
    }
    get_random_word = {
      route_key      = "getrandomword"
      operation_name = "GetRandomWord"
      // Lambda parameters
      name                  = "${local.base_name}-get-random-word"
      log_retention_days    = var.log_retention_days
      description           = "Get Random Word resources"
      handler               = "app.handler"
      runtime               = "nodejs12.x"
      timeout               = 3
      memory_size           = 256
      environment_variables = { TABLE_NAME = aws_dynamodb_table.words_dynamodb_table.name }
      source_dir            = "../src/get-random-word"
      output_path           = "../src/get-random-word.zip"
    }
  }
}
