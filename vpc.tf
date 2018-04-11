resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Main"
  }
}

resource "aws_security_group" "allow_htc" {
  name        = "allow_htc"
  description = "Allow all inbound traffic from an htc address"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "216.114.96.0/19",
      "65.87.32.0/19",
    ]
  }
}
