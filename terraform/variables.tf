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

variable backend_server_ami {
    description = "The AMI ID for the backend server"
    type        = string
}

variable backend_server_instance_type {
    description = "The instance type for the backend server"
    type        = string
}


variable backend_server_key_name {
    description = "The key name for the backend server"
    type        = string
}

variable backend_server_tags_Name {
    description = "The tag name for the backend server"
    type        = string
}

variable backend_server_tags_Role {
    description = "The tag role for the backend server"
    type        = string
}

variable frontend_server_ami {
    description = "The AMI ID for the frontend server"
    type        = string
}

variable frontend_server_instance_type {
    description = "The instance type for the frontend server"
    type        = string
}

variable frontend_server_key_name {
    description = "The key name for the frontend server"
    type        = string
}

variable frontend_server_tags_Name {
    description = "The tag name for the frontend server"
    type        = string
}

variable frontend_server_tags_Role {
    description = "The tag role for the frontend server"
    type        = string
}

variable backend_s3_bucket {
    description = "The name of the S3 bucket for backend Terraform state"
    type        = string
}

variable backend_s3_key {
    description = "The key for the S3 bucket to store Terraform state"
    type        = string
}

variable backend_s3_region {
    description = "The region of the S3 bucket for backend Terraform state"
    type        = string
}

variable db_identifier {
    description = "The identifier for the RDS database instance"
    type        = string
}

variable db_engine {
    description = "The database engine to use for the RDS instance"
    type        = string
}

variable db_engine_version {
    description = "The version of the database engine for the RDS instance"
    type        = string
}

variable db_instance_class {
    description = "The instance class for the RDS database instance"
    type        = string
}

variable db_allocated_storage {
    description = "The allocated storage (in GB) for the RDS database instance"
    type        = number
}

variable db_storage_type {
    description = "The storage type for the RDS database instance"
    type        = string
}

variable db_name {
    description = "The name of the database to create in the RDS instance"
    type        = string
}

variable db_username {
    description = "The master username for the RDS database instance"
    type        = string
}

variable db_password {
    description = "The master password for the RDS database instance"
    type        = string
    sensitive   = true
}

variable db_port {
    description = "The port number on which the RDS database instance will listen"
    type        = number
}

variable db_tags_Name {
    description = "The tag name for the RDS database instance"
    type        = string
}

variable db_tags_Environment {
    description = "The tag environment for the RDS database instance"
    type        = string
}
 