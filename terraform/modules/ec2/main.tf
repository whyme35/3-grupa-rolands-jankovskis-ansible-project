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

 provisioner "remote-exec" {
    inline = [
      "sudo echo \"${file("./assets/secrets/public-key.pub")}\" >> .ssh/authorized_keys",
    ]

  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.aws_private_key}")
      host        = self.public_dns
    }
  }

}

# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("./assets/templates/hosts.tpl",
    {
      servers =  aws_instance.ansible_hosts.*.public_dns
      webservers = aws_instance.ansible_hosts[0].*.public_dns
      database = aws_instance.ansible_hosts[1].*.public_dns
    }
  )
  filename = "./assets/inventory/hosts.cfg"
}
resource "aws_instance" "ansible_master" {
depends_on = [local_file.hosts_cfg]
ami = data.aws_ami.ubuntu.id
subnet_id = var.subnet_id[0]
tags = {
    Name="3_grupa_ansible_master_rolands_jankovskis"
}
instance_type = var.instance_type
vpc_security_group_ids = var.vpc_security_group_idsc
key_name = "rolands_jankovskis"
user_data = "${file("./assets/scripts/configure-master.sh")}"



provisioner "file" {
source = "./assets/secrets/secret-key.pem"
destination = "/home/ubuntu/.ssh/id_rsa"

  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.aws_private_key}")
      host        = self.public_dns
    }
}
provisioner "file" {
source = "./assets/inventory/hosts.cfg"
destination = "/tmp/hosts"

  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.aws_private_key}")
      host        = self.public_dns
    }

}
 provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ~/.ssh/id_rsa",
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt update -y",
      "sudo apt install ansible -y",
      "sudo mv /etc/ansible/hosts /etc/ansible/hosts.bak",
      "sudo mv /tmp/hosts /etc/ansible/hosts",
      "mkdir ~/ansible-codes",
    ]

  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.aws_private_key}")
      host        = self.public_dns
    }
  }
}