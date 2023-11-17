provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
   ami		= "ami-051fd28403c0dd170"
   instance_type = "t2.micro"
   vpc_security_group_ids = [aws_security_group.instance.id]

   user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
  
  user_data_replace_on_change = true

   tags = {
      Name = "terraform-example"
   }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080
  
}

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "The public address of the web server"
  
}

