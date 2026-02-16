terraform {
  backend "s3" {
    bucket         = "techbleat744"
    key            = "env/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
