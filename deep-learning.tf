provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "deep-learning" {
  ami = "ami-31ecfb26"
  instance_type = "p2.xlarge"
  associate_public_ip_address = "true"
  subnet_id = "subnet-19105044"
  vpc_security_group_ids = ["sg-c42821b2"]
  key_name = "${aws_key_pair.auth.id}"

  connection {
    # The default username for our AMI
    user = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.deep-learning.public_ip} > ip_address.txt",
      "git pull",
      "conda env update"
    ]
  }
}

output "ip" {
  value = "${aws_instance.deep-learning.public_ip}"
}