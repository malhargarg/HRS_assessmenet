resource "aws_key_pair" "devopskey" {
  key_name   = "devopskey"
  public_key = file(var.PUB_KEY_PATH)
}