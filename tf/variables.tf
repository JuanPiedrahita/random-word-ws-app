variable "app_name" {
  type        = string
  default     = "random-word-ws"
  description = "App name"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS Region"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "App environment"
}

variable "api_stage_name" {
  type        = string
  default     = "prod"
  description = "Api GW Stage name"
}

variable "log_retention_days" {
  type        = number
  default     = 1
  description = "Lambda cloudwatch logs retention in days"
}

variable "words_table_name" {
  type        = string
  default     = "words-table"
  description = "Lambda cloudwatch logs retention in days"
}
