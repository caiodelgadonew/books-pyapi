resource "aws_dynamodb_table" "state_locking" {
  hash_key = "LockID"
  name     = var.state_bucket
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
