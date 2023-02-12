output "state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}


output "state_locking_table" {
  value = aws_dynamodb_table.state_locking.name
}
