resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

data "aws_iam_policy_document" "github_oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:ayodelebwj/PROJECT2-DEMO:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-role"

  assume_role_policy = data.aws_iam_policy_document.github_oidc.json
}

resource "aws_iam_policy" "github_ssm_policy" {
  name = "github-ssm-deploy-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
           {
        Effect = "Allow"
        Action = [
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:DescribeRegions"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:ListCommandInvocations",
          "ssm:StartSession",
          "ssm:DescribeInstanceInformation",
          "ssm:DescribeSessions",
          "ssm:GetConnectionStatus"
        ]
        Resource = "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:HeadBucket"
        ],
        "Resource": [
          "arn:aws:s3:::techbleat744",
          "arn:aws:s3:::techbleat744/*"
          ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_ssm" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_ssm_policy.arn

}




