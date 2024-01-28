resource "aws_instance" "kaiburr_project" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t3.xlarge"
  key_name               = "Ohio_1"
  vpc_security_group_ids = [aws_security_group.kaiburr-sg.id]

  tags = {
    Name = "kaiburr-ci-cd"
  }

  root_block_device {
    volume_size = 30
  }
}

resource "aws_security_group" "kaiburr-sg" {
  name        = "kaiburr-sg"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 443, 27017 ] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kaiburr-sg"
  }
}
