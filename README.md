# Terraform AWS Lambda Module

This Terraform module creates an AWS Lambda function using a specified source file or directory.

## Features
- Supports both **file-based** and **directory-based** Lambda source code.
- Configurable **runtime**, **memory size**, **timeout**, and **IAM role**.
- Option to provide **environment variables** and **Lambda layers**.
- Supports **VPC configuration** for private Lambda execution.

## Usage

```hcl
module "lambda_function" {
  source            = "suleman-cheema/terraform-aws-lambda"
  function_name     = "my_lambda_function"
  source_code_path  = "./src/lambda_function.py"
  source_code_type  = "file"
  entrypoint        = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  memory_size      = 256
  timeout          = 15
  lambda_role_arn  = "arn:aws:iam::123456789012:role/lambda-execution-role"
  environment_variables = {
    ENV   = "production"
    DEBUG = "false"
  }
}
```

## Inputs

| Name                     | Description                                                                                      | Type            | Default         |
|--------------------------|--------------------------------------------------------------------------------------------------|-----------------|-----------------|
| function_name            | A unique name for your Lambda Function                                                          | `string`        | -               |
| source_code_path         | Lambda Function Source Code path                                                                | `string`        | -               |
| source_code_type         | Whether the source code is a file or directory (`file` or `directory`)                          | `string`        | `file`          |
| exclude_dirs_files       | Files or directories to exclude when packaging the source directory                             | `list(string)`  | `[]`            |
| entrypoint               | Lambda Function entry point (handler)                                                           | `string`        | `""`            |
| runtime                 | Runtime for the Lambda Function                                                                 | `string`        | `python3.12`    |
| layers                  | List of Lambda Layer ARNs to attach                                                             | `list(string)`  | `null`          |
| environment_variables    | Environment variables as key-value pairs                                                        | `map(string)`   | `{}`            |
| vpc_subnet_ids          | List of VPC subnet IDs for Lambda execution                                                     | `list(string)`  | `null`          |
| vpc_security_group_ids   | List of VPC security group IDs                                                                  | `list(string)`  | `null`          |
| description             | Description of the Lambda Function                                                              | `string`        | `""`            |
| lambda_role_arn         | IAM Role ARN attached to the Lambda Function                                                     | `string`        | `""`            |
| timeouts                | Maximum timeout settings for create, update, delete operations                                  | `map(string)`   | `{}`            |
| timeout                 | Maximum execution time (seconds)                                                                | `number`        | `10`            |
| memory_size             | Memory allocated to the Lambda Function (MB)                                                    | `number`        | `128`           |

## Outputs

| Name          | Description                                 |
|--------------|---------------------------------------------|
| function_arn | ARN of the created Lambda Function         |
| function_id  | Unique ID of the Lambda Function           |
| function_name| Name of the Lambda Function                |

## License
This module is open-source and provided under the MIT License.
