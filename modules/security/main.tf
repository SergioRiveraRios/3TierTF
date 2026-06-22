resource "aws_security_group" "aws-loadbalancer-internet" {
  name = var.aws-loadbalancer-Internet 
  vpc_id = "${var.aws-vpc}" 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["187.204.158.172/32"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws-webtier-sg" {
    name = var.aws-webtier-name
    vpc_id = "${var.aws-vpc}" 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["187.204.158.172/32"]
        security_groups = [aws_security_group.aws-loadbalancer-internet.id]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "aws-loadbalancer-internal" {
    name = var.aws-loadbalancer-Internal
    vpc_id = "${var.aws-vpc}" 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.aws-webtier-sg.id]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "aws-apptier-sg" {
    name = var.aws-apptier-name
    vpc_id = "${var.aws-vpc}" 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["187.204.158.172/32"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.aws-loadbalancer-internal.id]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "aws-db-tier" {
    name = var.aws-dbtier-name
    vpc_id = "${var.aws-vpc}" 
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.aws-apptier-sg.id ]
    }
}