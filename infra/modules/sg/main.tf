provider "aws" {
  region = "ap-southeast-1"
}

variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "SSH variable for bastion host"
  type        = string
}

variable "vpc_id" {
  type = string
}

# Create Security Group for the Web Server
resource "aws_security_group" "webserver-security-group" {
  name        = "Web Server Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443 via ALB and SSH access on Port 22"
  vpc_id      = var.vpc_id
#  vpc_id      = aws_vpc.vpc.id
  ingress {
    description     = "SSH Access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web Server Security Group"
  }
}

output "sg_id" {
  value = aws_security_group.webserver-security-group.id
}