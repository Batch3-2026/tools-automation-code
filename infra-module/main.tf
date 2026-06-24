resource "aws_security_group" "infra-sg" {

      name        = "${var.name}-sg"
      description = "${var.name}-sg"

      tags = {
        Name = "allow_tls"
      }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.infra-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.infra-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.infra-sg.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.infra-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "tool" {
  ami           = data.aws_ami.rhel9.image_id
  instance_type = var.instance_type
  key_pair      = var.key_pair
  vpc_security_group_ids = [aws_security_group.infra-sg.id]
  iam_instance_profile = [aws_iam_instance_profile.instance_profile.name]

  # Reads the script relative to the configuration folder
  user_data_base64 = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.name
  }
    tags = {
      Name = var.name
    }

}