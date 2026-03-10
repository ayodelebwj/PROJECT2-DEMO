# Create VPC Interface Endpoints
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = data.aws_vpc.myvpc.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [var.private_subnet_id, var.private_subnet_2_id]  
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = data.aws_vpc.myvpc.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [var.private_subnet_id, var.private_subnet_2_id]
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = data.aws_vpc.myvpc.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [var.private_subnet_id, var.private_subnet_2_id]
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}

# Optional: S3 gateway endpoint for artifacts
#resource "aws_vpc_endpoint" "s3" {
 # vpc_id            = data.aws_vpc.myvpc.id
 # service_name      = "com.amazonaws.us-east-1.s3"
  #vpc_endpoint_type = "Gateway"
 # route_table_ids   = ["rtb-11111111", "rtb-22222222"]
#}