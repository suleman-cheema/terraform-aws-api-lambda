locals {
  aws_lambda_functions = [
    {
      function_name    = "funtion_a"
      source_code_path = "${path.module}/files/lambda_a.py"
      entrypoint       = "lambda_a"
      source_code_type = "file"
    },
    {
      function_name    = "funtion_b"
      source_code_path = "${path.module}/files/lambda_b"
      source_code_type = "directory"

    }
  ]
}

module "public_aws_lambda_function" {
  for_each         = { for lambda in local.aws_lambda_functions : lambda.function_name => lambda }
  source           = "../../"
  function_name    = each.key
  entrypoint       = try(each.value.entrypoint, "${each.key}.lambda_handler")
  source_code_path = each.value.source_code_path
  lambda_role_arn  = try(each.value.iam_role_arn, aws_iam_role.iam_for_lambda.arn)
  source_code_type = try(each.value.source_code_type, "file")

  environment_variables = {
    ENDPOINT_URL = "us-east-1.amazonaws.com"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
