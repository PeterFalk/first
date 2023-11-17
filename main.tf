provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
   ami		= "ami-051fd28403c0dd170"
   instance_type = "t2.micro"

   tags = {
      Name = "first terraform example"
   }
}

