variable "ubuntu_ami" {
  description = "Default Ubuntu 22.04 AMI image "
  default     = "ami-0c65adc9a5c1b5d7c"
}

variable "instance_type" {
  description = "Default EC2 instance type "
  default     = "t2.micro"
}

variable "ssh_key_file"{
  description = "Key file name."
  default = "id_rsa.pub"

}