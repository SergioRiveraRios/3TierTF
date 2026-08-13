<<<<<<< HEAD
resource "aws_alb_target_group" "WebTierTG" {
  name     = "WebTierTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws-vpc}" 
}

resource "aws_alb" "WebTierALB" {
  name               = "WebTierALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ "${var.ALB_security_group}" ]
  subnets            = ["${var.ALB_Subnet1}","${var.ALB_Subnet2}"]
  enable_deletion_protection = true
}

resource "aws_lb_listener" "WebTierTG" {
  load_balancer_arn = aws_alb.WebTierALB.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.WebTierTG.arn
  }
}
resource "aws_launch_template" "WebTier" {
    name = "WebTierLaunchTemplate"
    depends_on = [ var.ami_webtier ]
    image_id = var.ami_webtier
    instance_type = "t2.micro"
    vpc_security_group_ids = [ var.web-tier-security-group ]
}   
#testttt
#test2

resource "aws_autoscaling_group" "WebTier" {
    name = "WebTierASG"
    max_size = 2
    min_size = 1
    vpc_zone_identifier = [ "${var.ALB_Subnet1}","${var.ALB_Subnet2}" ]
    target_group_arns = aws_alb_target_group.WebTierTG.load_balancer_arns
    launch_template {
        name = aws_launch_template.WebTier.name
    }

}

=======
resource "aws_alb_target_group" "WebTierTG" {
  name     = "WebTierTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws-vpc}" 
}

resource "aws_alb" "WebTierALB" {
  name               = "WebTierALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ "${var.ALB_security_group}" ]
  subnets            = ["${var.ALB_Subnet1}","${var.ALB_Subnet2}"]
  enable_deletion_protection = true
}
#test 
#test2
#test3
resource "aws_lb_listener" "WebTierTG" {
  load_balancer_arn = aws_alb.WebTierALB.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.WebTierTG.arn
  }
}
resource "aws_launch_template" "WebTier" {
    name = "WebTierLaunchTemplate"
    depends_on = [ var.ami_webtier ]
    image_id = var.ami_webtier
    instance_type = "t2.micro"
    vpc_security_group_ids = [ var.web-tier-security-group ]
}   
#testttt
#test2
#more test

resource "aws_autoscaling_group" "WebTier" {
    name = "WebTierASG"
    max_size = 2
    min_size = 1
    vpc_zone_identifier = [ "${var.ALB_Subnet1}","${var.ALB_Subnet2}" ]
    target_group_arns = aws_alb_target_group.WebTierTG.load_balancer_arns
    launch_template {
        name = aws_launch_template.WebTier.name
    }

}

>>>>>>> 2baf8ea9c370eee199e2cb2f6151060728c65f11
