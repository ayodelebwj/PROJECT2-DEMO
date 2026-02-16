data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

//Step 1 — Create IAM Role (Trust Policy)
resource "aws_iam_role" "ssm_role" {
  name               = "ec2-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

//Step 2 — Attach AmazonSSMManagedInstanceCore
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

//Step 3 — Create Instance Profile
//resource "aws_iam_instance_profile" "ssm_profile" {
 // name = "ec2-ssm-profile"
  //role = aws_iam_role.ssm_role.name
//}

