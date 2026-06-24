resource "aws_iam_role" "iam_role" {
  name = "${var.name}-role"

  # Terraform's "jsonencode" function converts a - Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.name}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}-role"
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  count     = length(var.policy_name)
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
}