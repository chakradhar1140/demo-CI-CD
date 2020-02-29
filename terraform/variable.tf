variable "AWS_ACCESS_KEY" {
   description = My AWS AccessKey
   default = "enter the access key here"

}

variable "AWS_SECRET_KEY" {
   description = My AWS Secret AccessKey
   default = "enter the secret key here"

}

variable "AMI" {
   description = My CUSTOM AMI
   default = "ami-0520e698dd500b1d1"

}

variable "AWS_REGION" {
   description = Default Region
   default = "us-east-2"

}

variable "key_name" {
   description = My Keypair
   default =  "linuxkp"

}
