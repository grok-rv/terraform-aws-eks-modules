#########################################################
#-------Author: Ramu Reddy ---------------------
#-------terraform storage module for s3 and dynamodb table-----
#########################################################

# -------------------------------------------------------------------
# create a s3 bucket for remote backend s3 storage
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "tl-eks-terraform-tfstate" {
  bucket = "tl-eks-dev-terraformstate"
  region = "us-west-2"
  acl    = "private"

  ####--------- Enable versioning on the bucket for state files------------

  versioning {
    enabled = true
  }

  # Enable server side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# -----------------------------------------------------------------------------------
# create a dynamodb table for locking state
# ---------------------------------------------------------------------------------

resource "aws_dynamodb_table" "tl-eks-terraform_locks" {
  name         = "tl-eks-dev-terraformstate"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

}
