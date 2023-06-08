resource "aws_instance" "node" {
  ami                    = data.aws_ami.ubu22.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.ansible.key_name

  tags = {
    Name = "docker-node"
  }
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible-key"
  public_key = data.local_file.pub_key.content
}

resource "aws_security_group" "instance" {
  name = "terraform-nodes-instance"

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
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

resource "local_file" "hosts" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      hosts = aws_instance.node.*.public_ip
    }
  )
  filename = "../ansible/inventory"
}