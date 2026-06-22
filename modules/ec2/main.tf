resource "aws_instance" "aws-test" {
    instance_type = "t3.micro"
    subnet_id = "${var.subnet-id}"
    ami = "ami-00e801948462f718a"
    tags = {
        Name = "test"
    }
    vpc_security_group_ids = [ "${var.security-group}" ]
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    
}

resource "aws_instance" "aws-test2" {
    instance_type = "t3.micro"
    subnet_id = "${var.subnet-id2}"
    ami = "ami-00e801948462f718a"
    associate_public_ip_address = true
    tags = {
        Name = "test2"
    }
    vpc_security_group_ids = [ "${var.security-group2}" ]
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    
}
resource "aws_instance" "aws-test3" {
    instance_type = "t3.micro"
    subnet_id = "${var.subnet-id3}"
    ami = "ami-00e801948462f718a"
    tags = {
        Name = "test3"
    }
    vpc_security_group_ids = [ "${var.security-group3}" ]
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    
}

resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}
