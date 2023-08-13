provider "aws" {
  region = "ap-southeast-1"
}

variable key_name {
  default = "TEST"
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "sg_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

#Create a new EC2 launch configuration
resource "aws_instance" "web" {
  ami                         = "ami-091a58610910a87a9"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.public_subnet_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "EC2-Private"
  }
}

resource "aws_ebs_volume" "web_volume" {
  availability_zone = "ap-southeast-1a"
  type = "gp2"
  size = 10
  tags = {
    "Name" = "web_volume"
  }
}

resource "aws_volume_attachment" "web_volume_att" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.web_volume.id
  instance_id = aws_instance.web.id
}

resource "aws_eip" "public_ip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}


output "ec2_ip" {
  value = aws_eip.public_ip.public_ip
}