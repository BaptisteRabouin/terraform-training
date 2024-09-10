provider "aws" {
  region     = "us-east-1"
  access_key = "PUT ACCESS KEY"
  secret_key = "PUT SECRET KEY"
}

resource "aws_instance" "myec2" {
  ami           = "ami-00543d76373f96fe7"
  instance_type = "t2.micro"
  key_name      = "devops-baptiste"
  tags = {
  Name = "ec2-baptiste" }
}
