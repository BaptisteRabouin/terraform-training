variable "instance_type" {
  type = string
  description = "Set AWS Instance type"
  default = "t2.nano"
}

variable "aws_common_tag" {
  type = map
  description = "Set AWS Tag"
  default = {
    Name: "ec2"
  }
}
