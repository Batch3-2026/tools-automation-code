resource "aws_instance" "tool" {
  ami           = data.aws_ami.rhel9.image_id
  instance_type = var.instance_type
  key_pair = var.key_pair

  # Reads the script relative to the configuration folder
  user_data_base64 = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.name
  }
}

  tags = {
    Name = "${var.name}"
  }
}