
data "aws_iam_policy_document" "ssm" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ssm" {
    name        = "ssm-role"
    description = "Enables SSM into EC2 resources"
    assume_role_policy = data.aws_iam_policy_document.ssm.json
}

resource "aws_iam_instance_profile" "ssm_iam_profile" {
    name = "ssm_profile"
    role = aws_iam_role.ssm.name
}


resource "aws_iam_role_policy_attachment" "ssm" {
role       = aws_iam_role.ssm.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
