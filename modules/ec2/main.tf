
resource "aws_instance" "main" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = var.subnet_id[0]
  key_name                    = "ssh-november"
  tags = {
    Name = var.ec2_instance_name
  }
}


resource "aws_security_group" "sg" {
  name        = "tf_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TCP"
    from_port   = 3333
    to_port     = 3333
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}