provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "mlops_key" {
  key_name   = "mlops-key-final"
  public_key = file("~/.ssh/mlops_key_new.pub")
}

resource "aws_security_group" "mlops_sg" {
  name        = "mlops-sg"
  description = "Allow SSH and app access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mlops_server" {
  ami                         = "ami-0c1ac8a41498c1a9c"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.mlops_key.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name = "mlops-ubuntu-server"
  }

  depends_on = [aws_security_group.mlops_sg]

  # ✅ FIXED SSH CONFIG
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/mlops_key_new")   # ✅ FIXED
    host        = self.public_ip
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "../setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "chmod +x /home/ubuntu/setup.sh",
      "bash /home/ubuntu/setup.sh"
    ]
  }
}

output "ec2_public_ip" {
  value = aws_instance.mlops_server.public_ip
}