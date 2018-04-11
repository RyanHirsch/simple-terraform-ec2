data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-zesty-17.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  associate_public_ip_address = true
  depends_on                  = ["aws_internet_gateway.gw"]

  subnet_id = "${aws_subnet.main.id}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_htc.id}",
  ]

  key_name = "${aws_key_pair.personal.key_name}"

  user_data = <<HEREDOC
  #!/bin/bash
  curl -fsSL get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker ubuntu
HEREDOC

  tags {
    Name = "${local.prefix}-free"
  }
}
