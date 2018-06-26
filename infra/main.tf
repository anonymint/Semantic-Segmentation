provider "aws" {
  profile = "${var.profile_name}"
  region = "${var.aws_region}"
}

data "aws_ami" "dl_ami" {
  most_recent = true
  filter  {
    name = "name"
    values = ["*Deep Learning AMI (Ubuntu)*"]
  }
}

resource "aws_security_group" "deeplearning" {
  tags = {
    Name = "deeplearning-sg"
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8888
    protocol = "tcp"
    to_port = 8888
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "aind_dl_instance" {
  ami = "${data.aws_ami.dl_ami.image_id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  key_name = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.deeplearning.id}"]

  tags {
    Name = "deeplearning-instance"
  }
}

output "deeplearning_instance" {
  value = "${aws_instance.aind_dl_instance.public_ip}"
}

output "deeplearning_ami" {
  value = "${data.aws_ami.dl_ami.image_id}"
}

output "deeplearning_sg" {
  value = "${aws_security_group.deeplearning.name}"
}