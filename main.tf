terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.87.0"
    }
  }
}

locals {
  entrypoint = var.entrypoint != "" ? var.entrypoint : "${var.function_name}.lambda_handler"
}

data "archive_file" "source_code_file" {
  count       = var.source_code_type == "file" ? 1 : 0
  type        = "zip"
  output_path = "${var.function_name}.zip"
  source_file = var.source_code_path
}

data "archive_file" "source_code_dir" {
  count       = var.source_code_type == "directory" ? 1 : 0
  type        = "zip"
  output_path = "${var.function_name}.zip"
  source_dir  = var.source_code_path
  excludes    = var.exclude_dirs_files
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = "${var.function_name}.zip"
  source_code_hash = try(
    data.archive_file.source_code_file[0].output_base64sha256,
    data.archive_file.source_code_dir[0].output_base64sha256
  )

  description = var.description
  role        = var.lambda_role_arn
  handler     = local.entrypoint
  runtime     = var.runtime
  layers      = var.layers
  timeout     = var.timeout
  memory_size = var.memory_size

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }
  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }
}
