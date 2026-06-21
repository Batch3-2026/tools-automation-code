# This a Data Source to read the details from AWS directly
data "aws_ami" "rhel9" {
  most_recent      = true
  owners           = ["self"] # provide here your account ID of AWS

  filter {
    name   = "name"
    values = ["RHEL-9"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}