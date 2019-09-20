provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}


# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "muneeb-bucket1" {
  bucket = "${var.bucketname1}"
  acl    = "private"
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "muneeb-bucket2" {
  bucket = "${var.bucketname2}"
  acl    = "private"
}
