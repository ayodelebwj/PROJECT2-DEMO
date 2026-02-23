resource "aws_iam_role" "github_actions_role_arn" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::<380029909039>:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:ayodelebwj/PROJECT2-DEMO:*"
          }
        }
      }
    ]
  })
}


resource "aws_iam_policy" "github_actions_ec2_policy" {
  name        = "github-actions-ec2-policy"
  description = "Allow GitHub Actions to manage EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "arn:aws:ec2:us-east-1:380029909039:instance/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ec2_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_ec2_policy.arn
}
