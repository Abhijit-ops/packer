packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "amiid" {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-20240228"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = var.owner
} 

locals {
  instance_type = "t2.micro"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = local.instance_type
  region        = "ap-south-1"
  source_ami    = data.amazon-ami.amiid.id
  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "file" {
  source = "${path.root}/scripts/build.sh"
  destination = "/tmp/build.sh"
  }
  provisioner "shell" {
    inline = ["sh /tmp/build.sh"]
  }
  provisioner "breakpoint" {
    disable = false
    note    = "this is a breakpoint"
  }

}
