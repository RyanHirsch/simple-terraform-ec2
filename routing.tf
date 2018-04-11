resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

resource "aws_main_route_table_association" "main_route" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.inbound.id}"
}

resource "aws_route_table" "inbound" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "main"
  }
}
