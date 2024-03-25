import {
  to = aws_cloudwatch_log_group.lambda
  id = "/aws/lambda/manually-created-lambda"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/manually-created-lambda"
}
