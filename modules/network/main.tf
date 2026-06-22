
resource "aws_vpc" "testvpc" {
    cidr_block = "${var.cidr_block}"
    tags = {
      Name = "${var.vpcname}"
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.testvpc.id
    tags = {
      Name = "igw"
    }
  
}

resource "aws_subnet" "subnets_az1" {
    vpc_id = aws_vpc.testvpc.id
    for_each = var.subnetsAZ1
    availability_zone = "us-east-1a"
    cidr_block = each.value
    tags = {
      Name = each.key
    }
}

resource "aws_subnet" "subnets_az2" {
    vpc_id = aws_vpc.testvpc.id
    for_each = var.subnetsAZ2
    availability_zone = "us-east-1b"
    cidr_block = each.value
    tags = {
      Name = each.key
    }
}
resource "aws_route_table" "internet_igw" {
    vpc_id = aws_vpc.testvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "internet_rt" {
  subnet_id = values(aws_subnet.subnets_az1)[2].id
  route_table_id = aws_route_table.internet_igw.id
}

resource "aws_route_table_association" "internet_rt2" {
  subnet_id = values(aws_subnet.subnets_az2)[2].id
  route_table_id = aws_route_table.internet_igw.id
}

resource "aws_route_table" "nat_az1" {
  vpc_id = aws_vpc.testvpc.id
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_az1.id
    }
}

resource "aws_route_table_association" "nat_az1_rt" {
    subnet_id = values(aws_subnet.subnets_az1)[0].id
    route_table_id = aws_route_table.nat_az1.id
}

resource "aws_route_table" "nat_az2" {
  vpc_id = aws_vpc.testvpc.id
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_az2.id
    }
}

resource "aws_route_table_association" "nat_az2_rt" {
    subnet_id = values(aws_subnet.subnets_az2)[0].id
    route_table_id = aws_route_table.nat_az2.id
    
}

resource "aws_eip" "eip1" {
  domain = "vpc"
}

resource "aws_eip" "eip2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_az1" {
  allocation_id = aws_eip.eip1.id
  subnet_id = values(aws_subnet.subnets_az1)[2].id
}

resource "aws_nat_gateway" "nat_az2" {
  allocation_id = aws_eip.eip2.id
  subnet_id = values(aws_subnet.subnets_az2)[2].id
}

