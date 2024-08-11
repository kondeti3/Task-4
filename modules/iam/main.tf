resource "aws_iam_role" "lambda_role" {
  name = "Lambda-Role-New"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

# Attach AWSLambdaBasicExecutionRole
resource "aws_iam_policy_attachment" "lambda_basic_execution_policy_attachment" {
  name       = "lambda-basic-execution-policy-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Inline policy for S3 access
resource "aws_iam_role_policy" "lambda_s3_policy" {
  name   = "Lambda-S3-Policy"
  role   = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::terraform-state-demobucket1",
          "arn:aws:s3:::terraform-state-demobucket1/*"
        ]
      }
    ]
  })
}
