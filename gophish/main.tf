resource "aws_security_group" "default" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "Allow all egress traffic"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "SSH"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "Http 80"
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "Default gophish port."
      from_port        = 3333
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3333
    }
  ]
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "gophish"
  public_key = file("id_rsa.pub")
}


resource "aws_instance" "ec2_instance" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type

  key_name = aws_key_pair.ssh-key.key_name
  tags = {
    Name = "Gophish Server"
  }

  vpc_security_group_ids = [aws_security_group.default.id]
  user_data_base64       = "IyEvYmluL2Jhc2gKIyMgVXBkYXRuZyB0aGUgc3lzdGVtCnN1ZG8gYXB0IHVwZGF0ZSAmJiBzdWRvIGFwdCB1cGdyYWRlIC15CnN1ZG8gYXB0IGluc3RhbGwgdW56aXAgLXkKI0NoYW5naW5nIGRpcmVjdG9yeSB0byBvcHQuCmNkIC9vcHQKCiNEb3dubG9hZGluZyBsYXRlc3QgZ29waGlzaCByZWxlYXNlLiAKI09mZmljaWFsIHJlbGVhc2Ugd2VicGFnZSBhdCBodHRwczovL2dpdGh1Yi5jb20vZ29waGlzaC9nb3BoaXNoL3JlbGVhc2VzLwpzdWRvIHdnZXQgaHR0cHM6Ly9naXRodWIuY29tL2dvcGhpc2gvZ29waGlzaC9yZWxlYXNlcy9kb3dubG9hZC92MC4xMi4xL2dvcGhpc2gtdjAuMTIuMS1saW51eC02NGJpdC56aXAKCiNVbnppcCB0aGUgZG93bmxvYWQKc3VkbyB1bnppcCBnb3BoaXNoLXYwLjEyLjEtbGludXgtNjRiaXQuemlwCgojQWRkIGxvb3BiYWNrIGNvbmZpZ3VyYXRpb24gdG8gY29uZmlnLmpzb24Kc3VkbyBzZWQgLWkgJ3MvMTI3XC4wXC4wXC4xLzBcLjBcLjBcLjAvZycgY29uZmlnLmpzb24KCiNBc3NpZ25pbmcgZXhlY3V0YWJsZSBwZXJtaXNzaW9ucyBhbmQgZXhlY3V0aW5nIGJpbmFyeQpzdWRvIGNobW9kICt4IC4vZ29waGlzaCAKc3VkbyAuL2dvcGhpc2ggJgoKI1VwZGF0aW5nIHBhc3N3b3JkIGZpbGUsIHdoZW4gYWNjZXNzaW5nIHVzaW5nIHRoZSBkZWZhdWx0IHBhc3N3b3JkIGl0IHdpbGwgYXNrIGZvciBhIHBhc3N3b3JkIHJlc2V0LiBJbnB1dCB5b3VyIHBhc3N3b3JkIHRocm91Z2ggZ29waGlzaCBhdXRoZW50aWNhdGlvbiBkYXNoYm9hcmQuCnN1ZG8gYXB0IGluc3RhbGwgLXkgc3FsaXRlIHx8IHN1ZG8gYXB0LWdldCBpbnN0YWxsIC15IHNxbGl0ZTMgbGlic3FsaXRlMy1kZXYKc3VkbyBzcWxpdGUzIGdvcGhpc2guZGIgJ3VwZGF0ZSB1c2VycyBzZXQgaGFzaD0iJDJhJDEwJElZa1BwMC5Rc004MWxZWVByUXg2Vy5VNm9RR3c3d01wb3pyS2hLQUhVQlZMNG1rbS9FdkFTIiB3aGVyZSB1c2VybmFtZT0iYWRtaW4iOyc="
}

output "server_ip" {
  value = aws_instance.ec2_instance.public_ip
}
