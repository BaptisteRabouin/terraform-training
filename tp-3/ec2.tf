provider "aws" {
  region     = "us-east-1"
  access_key = "PUT ACCESS KEY"
  secret_key = "PUT SECRET KEY"
}
data "aws_ami" "app_ami" {
    most_recent = true
    owners = [ "amazon" ]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm"]
    }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  key_name      = "devops-baptiste"
  tags = var.aws_common_tag
  security_groups = [ "$(aws_security_group.allow_http_https.id)" ]
}

resource "aws_security_group" "allow_http_https" {
  name = "baptiste-sg"
  description = "Allow http and http inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "myec2" {
  instance = "$(aws_instance.web.id)"
  domain   = "vpc"
}
