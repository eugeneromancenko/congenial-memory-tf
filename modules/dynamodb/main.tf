resource "aws_dynamodb_table" "this" {
  name           = "timestamps"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "timestamp"

  attribute {
    name = "timestamp"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }
}