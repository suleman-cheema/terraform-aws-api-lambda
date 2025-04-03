variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "source_code_path" {
  description = "Lambda Function Source Code path"
  type        = string
}

variable "source_code_type" {
  description = "Is Source code of lambda is file or directory"
  type        = string
  default     = "file"
  validation {
    condition     = can(regex("^(file|directory|)$", var.source_code_type))
    error_message = "Must be file or directory"
  }
}

variable "exclude_dirs_files" {
  description = "Specify files/directories to ignore when reading the source_dir"
  type        = list(string)
  default     = [""]
}

variable "entrypoint" {
  description = "Lambda Function entrypoint(handler) in your code"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.12"
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = null
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description of your Lambda Function"
  type        = string
  default     = ""
}

variable "lambda_role_arn" {
  description = " IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
  default     = ""
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting Lambda Function resources"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Amount of time in seconds the Lambda Function is allowed to run."
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "memory size in MBs, available for the Lambda function during invocation."
  type        = number
  default     = 128
}
