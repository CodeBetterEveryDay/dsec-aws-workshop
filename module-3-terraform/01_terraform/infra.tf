# DSEC AWS Workshop

# ================================================================================
# 1. VARIABLES
# ================================================================================

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "workshop"
}

# ================================================================================
# 2. PROVIDERS
# ================================================================================

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

# ================================================================================
# 3. RESOURCES
# ================================================================================

resource "aws_instance" "nginx" {
  ami           = "ami-0181f8d9b6f098ec4"
  instance_type = "t1.micro"
  key_name        = "${var.key_name}"

  connection {
    user        = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo service nginx start"
    ]
  }
}

# ================================================================================
# 4. OUTPUT
# ================================================================================

output "aws_instance_public_dns" {
    value = "${aws_instance.nginx.public_dns}"
}
