variable "public_key_path" {
  default = "~/.ssh/dl1.pub"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "dl1"
}
