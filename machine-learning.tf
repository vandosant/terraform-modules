resource "aws_instance" "machine-learning" {
  ami = "${var.amis["fastai-part1v2-p2"]}"
  instance_type = "t2.medium"
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
      "cd fastai",
      "git pull",
      "conda env update",
      "apt install unzip",
      "pip install --upgrade pip",
      "pip install kaggle"
    ]
  }
}

output "machine-learning-instance-ip" {
  value = "${aws_instance.machine-learning.public_ip}"
}

