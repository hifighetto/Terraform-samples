resource "aws_iam_role" "hifighetto_lambda_function01" {
  name = "hifighett-lambda-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com",
                    "s3.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_lambda_function" "hifighetto_lambda_function01" {
  function_name    = "hifighetto-lambda-function01"
  role             = aws_iam_role.hifighetto_lambda_function01.arn
  filename         = "hello_world.zip"
  source_code_hash = filebase64sha256("hello_world.zip")
  handler          = "index.py"
  runtime          = "python3.8"

  lifecycle {
    ignore_changes = [
      source_code_hash,
      handler,
      last_modified
    ]
  }
}