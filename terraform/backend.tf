terraform {
  backend "s3" {
    bucket         = "techbleat744"
    key            = "env/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
