provider "aws"{

access_key = "${var.AWS_ACCESS_KEY}"
secret_key = "${var.AWS_SECRET_KEY}"
region = "${var.AWS_REGION}"

}

resource "aws_instance" "jenkins" {
    ami = "${var.AMI}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.terraformSG.name}"]
    tags ={ Name = "jenkins"}

 }

 resource "aws_instance" "tomcat-server" {
    ami = "${var.AMI}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.terraformSG.name}"]
    tags ={ Name = "tomcat-server"}
 }

resource "aws_instance" "kops" {
    ami = "${var.AMI}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.terraformSG.name}"]
    tags ={ Name = "kops"}


 }

resource "aws_instance" "docker" {
    ami = "${var.AMI}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.terraformSG.name}"]
    tags ={ Name = "docker"}

}

resource "aws_instance" "nexus" {
    ami = "${var.AMI}"
    instance_type = "t2.medium"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.terraformSG.name}"]
    tags ={ Name = "nexus"}

}


