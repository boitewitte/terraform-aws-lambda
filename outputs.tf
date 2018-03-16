output "arn" {
  # The Amazon Resource Name (ARN) identifying your Lambda Function.
  value = "${element(concat(aws_lambda_function.this.*.arn, list("")), 0)}"
}

output "qualified_arn" {
  # The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true).
  value = "${element(concat(aws_lambda_function.this.*.qualified_arn, list("")), 0)}"
}

output "invoke_arn" {
  # The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri
  value = "${element(concat(aws_lambda_function.this.*.qualified_arn, list("")), 0)}"
}

output "version" {
  # Latest published version of your Lambda Function.
  value = "${element(concat(aws_lambda_function.this.*.version, list("")), 0)}"
}

# output "kms_key_arn" {
#   # (Optional) The ARN for the KMS encryption key.
#   value = "${element(concat(aws_lambda_function.this.*.kms_key_arn, list("")), 0)}"
# }

output "source_code_hash" {
  # Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters.
  value = "${element(concat(aws_lambda_function.this.*.source_code_hash, list("")), 0)}"
}

output "alias_arn" {
  # The Amazon Resource Name (ARN) identifying your Lambda function alias.
  value = "${var.alias_name != "" && var.alias_version != "" ? element(concat(aws_lambda_alias.alias.*.arn, list("")), 0) : ""}"
}

# output "es_arn" {
#   # The Amazon Resource Name (ARN) identifying your Lambda function alias.
#   value = "${aws_lambda_alias.alias.arn}"
# }

output "es_function_arn" {
  # The the ARN of the Lambda function the event source mapping is sending events to. (Note: this is a computed value that differs from function_name above.)
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.function_arn, list("")), 0) : ""}"
}

output "es_last_modified" {
  # The date this resource was last modified.
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.last_modified, list("")), 0) : ""}"
}

output "es_last_processing_result" {
  # The result of the last AWS Lambda invocation of your Lambda function.
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.last_processing_result, list("")), 0) : ""}"
}

output "es_state" {
  #  The state of the event source mapping.
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.state, list("")), 0) : ""}"
}

output "es_state_transition_reason" {
  # The reason the event source mapping is in its current state.
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.state_transition_reason, list("")), 0) : ""}"
}

output "es_uuid" {
  # The UUID of the created event source mapping.
  value = "${var.es_arn != "" ? element(concat(aws_lambda_event_source_mapping.event_source.*.uuid, list("")), 0) : ""}"
}

