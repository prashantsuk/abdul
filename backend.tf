terraform {
  backend "s3" {
    bucket = "abdulbucketrandam" # Replace with your actual S3 bucket name
    key    = "ec2/terraform.tfstate"
    region = "us-west-2"
  }
}
