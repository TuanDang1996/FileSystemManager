variable "public_key" {
  type = string
  default  = ""
}

resource "aws_key_pair" "key_pair" {
  key_name   = "TEST"
  public_key = var.public_key
}
