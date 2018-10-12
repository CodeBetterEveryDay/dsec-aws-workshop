# ================================================================================
# 1. VARIABLES
# ================================================================================

variable "ami_ubuntu" {
    default = "ami-0181f8d9b6f098ec4"
}

variable "instance_type" {
    default = "t1.micro"
}

variable "region" {
    default = "eu-west-1"
}
variable "shared_credentials_file"{
    default = "~/.aws/credentials"
}
variable "profile" {
    default = "terraform"
}

variable "key_name" {
    default = "terraform"
}
variable "private_key_path" {
  default = "~/.aws/terraform.pem"
}

# ================================================================================
# 2. PROVIDERS
# ================================================================================

# YOUR CODE GOES HERE:
# TODO: Add missing variables to the "aws" provider
# Hint: see previous exercises
provider "aws" {
  region     = "${var.region}"
  # your code here...
}

# ================================================================================
# 3. RESOURCES
# ================================================================================

resource "aws_instance" "webserver" {
  # TODO
  # Your changes goes here: move ami and instance type to base.tfvars
  ami           = "<YOUR CODE GOES HERE>"
  instance_type = "<YOUR CODE GOES HERE>"
  key_name      = "${var.key_name}"

  connection {
    user        = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo service nginx start",
      "echo '<html><head><title>WebSrv1</title></head><body>Data Science Engineering - WebServer 1</p></body></html>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }

  tags {
    Name = "WEBSRV-1",
    Team = "DataEngineering",
    Role = "WebServer",
  }
}

# ================================================================================
# 4. OUTPUT
# ================================================================================

output "aws_instance_public_dns" {
    value = "${aws_instance.webserver.public_dns}"
}
