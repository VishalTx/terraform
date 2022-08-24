provider "aws" {
    region= "us-east-1"
    access_key = "AKIAYM7BDXB6FNA5LRWI"
    secret_key = "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"

}

resource "aws_instance" "terraform_ins2" {
    ami = "ami-08d4ac5b634553e16"
    instance_type = "t2.micro"
    key_name = "TF_key"
}
resource "aws_key_pair" "TF-key" {
    key_name = "TF_key"
    public_key = tls_private_key.rsa.public_key_openssh
  
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "TF_key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tfkey"
  
}
resource "aws_iam_role" "terra_role" {
  name = "tf"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

}
