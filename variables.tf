variable "namespace" {
  type = "string"
  description = "The namespace for the Lambda function"
}

variable "environment" {
  type = "string"
  description = "The environment (stage) for the Lambda function"
}

variable "name" {
  type = "string"
  description = "A name for you Lambda Function"
}

variable "tags" {
  type = "map"
  description = "describe your variable"
  default = {}
}

variable "source_code_hash" {
  type = "string"
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key."
}

variable "dead_letter_config" {
  type = "map"
  description = "Nested block to configure the function's dead letter queue."
  default = {}
}

variable "filename" {
  type = "string"
  description = "The path to the function's deployment package within the local filesystem."
}

variable "handler" {
  type = "string"
  description = "The function entrypoint in your code."
}

variable "environment_variables" {
  type = "map"
  description = "A map that defines environment variables for the Lambda function."
  default = {}
}

variable "memory_size" {
  type = "string"
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default = "128"
}

variable "runtime" {
  type = "string"
  description = "The runtime environment for the Lambda function you are uploading. (nodejs, nodejs4.3, nodejs6.10, java8, python2.7, python3.6, dotnetcore1.0, nodejs4.3-edge)"
}

variable "timeout" {
  type = "string"
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  default = "3"
}

variable "publish" {
  type = "string"
  description = "Whether to publish creation/change as new Lambda Function Version."
  default = false
}

variable "execution_policies_count" {
  type = "string"
  description = "Workaround for list of resources count"
  default = "0"
}

variable "execution_policies" {
  type = "list"
  description = "The list of ARNs of the policies you want to apply to the Lambda execution role."
  default = []
}

variable "vpc_subnet_ids" {
  type = "list"
  description = "A list of subnet IDs associated with the Lambda function."
  default = []
}

variable "vpc_security_group_ids" {
  type = "list"
  description = "A list of security group IDs associated with the Lambda function."
  default = []
}

variable "logs_policy" {
  description = "The name of the policy for the logs, if is set, then the logs policy will be created"
  default = false
}

variable "alias_name" {
  type = "string"
  description = "Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+), when false no alias is created"
  default = ""
}

variable "alias_description" {
  type = "string"
  description = "Description of the alias."
  default = ""
}

variable "alias_version" {
  type = "string"
  description = "Lambda function version for which you are creating the alias."
  default = ""
}

variable "es_arn" {
  type = "string"
  description = "The event source ARN - can either be a Kinesis or DynamoDB stream. When false, no event stream is created"
  default = ""
}

variable "es_enabled" {
  description = "Determines if the mapping will be enabled on creation. Defaults to true"
  default = true
}

variable "es_batch_size" {
  description = "The largest number of records that Lambda will retrieve from your event source."
  default = 100
}

variable "es_starting_position" {
  description = "The position in the stream where AWS Lambda should start reading."
  default = false
}
