provider "aws" {
region = var.region
}

data "aws_ami"  "ubuntu" {
most_recent = true
filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}
filter {
name = "virtualization-type"
values = ["hvm"]
}
owners = ["099720109477"]

}

resource "aws_instance" "ansible_master" {
ami = data.aws_ami.ubuntu.id
subnet_id = var.subnet_id[0]
tags = {
    Name="3_grupa_ansible_master_rolands_jankovskis"
}
instance_type = var.instance_type
vpc_security_group_ids = var.vpc_security_group_idsc
key_name = "rolands_jankovskis"
user_data = "${file("./assets/scripts/configure-master.sh")}"
}

resource "aws_instance" "ansible_hosts" {
count = 2
  tags = {
    Name = "3_grupa_ansible_host_${count.index+1}_rolands_jankovskis"
  }
ami = data.aws_ami.ubuntu.id
subnet_id = var.subnet_id[0]
instance_type = var.instance_type
vpc_security_group_ids = var.vpc_security_group_idsc
key_name = "rolands_jankovskis"
user_data = "${file("./assets/scripts/configure-host${count.index+1}.sh")}"
}