resource "aws_cloudwatch_event_rule" "break_glass_tf_backend_role" {
  name = "${var.prefix}-break-glass-tf-backend-role"
  description = "This rule will get triggered if tf-backend-role is assumed"
  event_pattern = <<PATTERN
{
	"detail-type": [
		"AWS API Call via CloudTrail"
	],
	"detail": {
		"eventName": [
			"AssumeRole"
		],
		"eventSource": [
			"sts.amazonaws.com"
		],
		"requestParameters": {
			"roleArn": [
				"${var.tf_backend_role_arn}"
			]
		}
	}
}
PATTERN
}

resource "aws_cloudwatch_event_target" "break_glass_tf_backend_role" {
  rule = aws_cloudwatch_event_rule.break_glass_tf_backend_role.name
  arn = aws_lambda_function.break_glass_alerts.arn
  input_transformer {
    input_paths = {
      "sourceIPAddress" = "$.detail.sourceIPAddress"
      "roleSessionName" = "$.detail.requestParameters.roleSessionName"
      "userAgent" = "$.detail."
    }
  }
}