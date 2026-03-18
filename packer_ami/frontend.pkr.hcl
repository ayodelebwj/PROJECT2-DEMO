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

  tags = {
  Project     = "frontend"
  }
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
      "sudo snap install amazon-ssm-agent --classic",
      "sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service",
      "sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service",
      "sudo apt -y install nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo touch /var/www/html/health",
      "echo OK | sudo tee /var/www/html/health",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart nginx",
      "sudo apt -y install git",
      "sudo chown ubuntu:ubuntu /home/ubuntu",
      "git clone https://github.com/techbleat/class25-26-project2.git",
      "sudo cp class25-26-project2/login.html /var/www/html/login.html",
      "sudo cp class25-26-project2/home.html /var/www/html/home.html"
    ]
  }
}

