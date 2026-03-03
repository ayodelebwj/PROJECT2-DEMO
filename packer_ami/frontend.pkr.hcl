#RETRIEVES UBUNTU AMI FROM AWS STORE TO PROVISION AMI TEMPLATE VM
data "amazon-parameterstore" "web_ubuntu_params" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

#CREATES THE INSTANCE NEEDED TO BUILD AMI AND CREATE A TEMPLATE
source "amazon-ebs" "web-vm-source" {
  region        = "us-east-1"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  source_ami    = data.amazon-parameterstore.web_ubuntu_params.value
  ami_name      = "frontend-ami-{{timestamp}}"
}

#BUILDS THE NGINX WEB SERVER AMI TEMPLATE
build {
  name    = "web-build"
  sources = ["source.amazon-ebs.web-vm-source"]

  provisioner "shell" {
    inline_shebang = "/bin/bash -xe"
    inline = [
      #!/bin/bash
      # Update system packages
      "sudo apt update -y",
      "sudo apt install -y snapd",
      "sudo snap install core",
      "sudo snap refresh core", 
      "sudo systemctl start amazon-ssm-agent",
      "sudo systemctl enable amazon-ssm-agent"
    ]
  }
}



