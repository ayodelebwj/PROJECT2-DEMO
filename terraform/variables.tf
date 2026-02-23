variable policy_arn {
    description = "The ARN of the IAM policy to attach to the SSM role"
    type        = string
}

variable vpc_id {
    description = "The ID of the VPC where resources will be created"
    type        = string
}

variable private_subnet_id {
    description = "The ID of the private subnet for backend instances"
    type        = string
}

variable public_subnet_id {
    description = "The ID of the public subnet for frontend instances"
    type        = string
}

variable frontend_sg_name {
    description = "The name of the security group for frontend instances"
    type        = string
}

variable frontend_sg_tag_name {
    description = "The tag name for the frontend security group"
    type        = string
}

variable backend_sg_name {
    description = "The name of the security group for backend instances"
    type        = string
}

variable backend_sg_from_port {
    description = "The starting port for backend security group ingress"
    type        = number
}

variable backend_sg_to_port {
    description = "The ending port for backend security group ingress"
    type        = number
}

variable backend_sg_tag_Name {
    description = "The tag name for the backend security group"
    type        = string
}

variable thumbprint_list {
    description = "The thumbprint list for the OIDC provider"
    type        = string
}

variable github_actions_ec2_policy_name {
    description = "The name of the IAM policy for GitHub Actions to manage EC2 instances"
    type        = string
}

variable github_actions_ec2_policy_Resource {
    description = "The ARN of the EC2 resources that GitHub Actions can manage"
    type        = string
}
 