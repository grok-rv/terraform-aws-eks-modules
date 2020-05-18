############################################################
#--------------Author: Ramu Reddy ------------------
#--------------terraform output values for storage module-----
###############################################################

# ----------------------------------------------------------------------------------
# output terraform resources for s3 backend bucket and dynamodb table for locking
# ------------------------------------------------------------------------------------------

output "tl-dev-terraformbucket" {
  value       = aws_s3_bucket.tl-eks-terraform-tfstate.arn
  description = "The tl eks terraform state bucket"
}

output "tl-dev-terraform-dynamodb" {
  value       = aws_dynamodb_table.tl-eks-terraform_locks.name
  description = "The tl eks terraform dynamodb table for locking state"
}
