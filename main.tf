module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.1"
  namespace  = "${var.namespace}"
  stage      = "${var.environment}"
  name       = "${var.name}"
  tags       = "${var.tags}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role_policy" "logs_policy" {
  count = "${var.logs_policy != false ? 1 : 0}"

  name = "${var.logs_policy}"
  role = "${aws_iam_role.role.id}"

  policy = "${data.aws_iam_policy_document.logs.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Policy: AWSLambdaVPCAccessExecutionRole (arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole)
resource "aws_iam_role_policy_attachment" "network-attachment" {
  role                 = "${aws_iam_role.role.name}"

  policy_arn           = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "custom" {
  # count                 = "${length(var.execution_policies)}"
  count                 = "${var.execution_policies_count}"

  role                  = "${aws_iam_role.role.name}"

  policy_arn            = "${element(var.execution_policies, count.index)}"
}

resource "aws_iam_role" "role" {
  name = "${module.label.id}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_lambda_function" "this" {
  count               = "${var.filename != false ? 1 : 0}"

  filename            = "${var.filename}"

  function_name       = "${module.label.id}"
  role                = "${aws_iam_role.role.arn}"

  handler             = "${var.handler}"
  runtime             = "${var.runtime}"
  source_code_hash    = "${var.source_code_hash}"
  memory_size         = "${var.memory_size}"
  timeout             = "${var.timeout}"

  publish             = "${var.publish}"

  tags                = "${module.label.tags}"

  environment         = {
    variables         = "${var.environment_variables}"
  }

  # dead_letter_config  = "${var.dead_letter_config}"

  vpc_config          = {
    subnet_ids          = ["${var.vpc_subnet_ids}"]
    security_group_ids  = ["${var.vpc_security_group_ids}"]
  }
}

resource "aws_lambda_alias" "alias" {
  count = "${var.alias_name != "" && var.alias_version != "" ? 1 : 0}"

  name = "${var.alias_name}"
  description = "${var.alias_description}"
  function_name = "${aws_lambda_function.this.arn}"
  function_version = "${var.alias_version}"
}

resource "aws_lambda_event_source_mapping" "event_source" {
  count = "${var.es_arn != "" ? 1 : 0}"

  event_source_arn  = "${var.es_arn}"
  function_name     = "${aws_lambda_function.this.arn}"

  enabled           = "${var.es_enabled}"

  batch_size        = "${var.es_batch_size}"
  starting_position = "${var.es_starting_position}"
}
