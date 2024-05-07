variable "users" {
  type    = list(string)
  default = ["MJaga", "JagaM", "Makineni"] 
}

variable "user_path" {
  type    = string
  default = "/users/" 
}

resource "aws_iam_user" "iam_users" {
  for_each = { for idx, name in var.users : name => idx }
  name     = each.key
  path     = var.user_path
}

resource "aws_iam_user_policy_attachment" "attach_role" {
  count      = length(var.users)
  user       = aws_iam_user.iam_users[keys(aws_iam_user.iam_users)[count.index]].name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_policy" "iam_policy" {
  name        = "ec2-full-access-policy"
  description = "Policy for granting EC2 full access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF
}
