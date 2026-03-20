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

  tags = {
  Project     = "backend"
  }
}


#BUILDS THE PYTHON SERVER AMI TEMPLATE
build {
  name    = "backend_build"
  sources = ["source.amazon-ebs.backend_vm_source"]

    provisioner "file" {
    source      = "backend-app.service"
    destination = "/tmp/backend-app.service"
  }

    provisioner "file" {
    source      = "requirements.txt"
    destination = "/tmp/requirements.txt"
  }

    provisioner "file" {
    source      = "main.py"
    destination = "/tmp/main.py"
  }

  provisioner "shell" {
    inline_shebang = "/bin/bash -xe"
    inline = [
      "sudo apt update -y",
      "sudo apt install python3.12-venv python3 python3-pip -y",
      "git clone https://github.com/techbleat/class25-26-project2.git",
      "sudo cp /tmp/backend-app.service /etc/systemd/system/backend-app.service",
      "sudo cp /tmp/requirements.txt /home/ubuntu/class25-26-project2/requirements.txt",
      "sudo cp /tmp/main.py /home/ubuntu/class25-26-project2/app/main.py",
      "sudo chown ubuntu:ubuntu /home/ubuntu",
      "cd /home/ubuntu/class25-26-project2/app",
       "python3 -m venv venv",
       "source venv/bin/activate",
       "pip install --upgrade pip",
      "pip install -r /home/ubuntu/class25-26-project2/requirements.txt",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable backend-app.service",
      "sudo systemctl start backend-app.service",
      "sudo snap install amazon-ssm-agent --classic",
      "sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service",
      "sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service"
    ]
  }
}

