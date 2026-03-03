#RETRIEVES UBUNTU AMI FROM AWS STORE TO PROVISION AMI TEMPLATE VM
data "amazon-parameterstore" "python_ubuntu_params" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

#CREATES THE INSTANCE NEEDED TO BUILD AMI AND CREATE A TEMPLATE
source "amazon-ebs" "backend_vm_source" {
  region        = "us-east-1"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  source_ami    = data.amazon-parameterstore.python_ubuntu_params.value
  ami_name      = "backend-ami-{{timestamp}}"
}


#BUILDS THE PYTHON SERVER AMI TEMPLATE
build {
  name    = "backend_build"
  sources = ["source.amazon-ebs.backend_vm_source"]

  provisioner "shell" {
    inline_shebang = "/bin/bash -xe"
    inline = [
      "sudo apt update -y",
      "sudo snap install amazon-ssm-agent --classic",
      "sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service",
      "sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service"
    ]
  }
}

