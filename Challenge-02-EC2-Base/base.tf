# DSEC AWS Workshop

# ================================================================================
# 1. VARIABLES
# ================================================================================

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

provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.profile}"
}

# ================================================================================
# 3. RESOURCES
# ================================================================================

resource "aws_instance" "base" {
  ami           = "ami-0181f8d9b6f098ec4"
  instance_type = "t1.micro"
  key_name        = "${var.key_name}"

  # YOUR CODE GOES HERE - uncomment and add tags.
  #tags {
  #  Team = "SysSecInfra",
  #  ...
  #  ...
  #}
}

# ================================================================================
# 4. OUTPUT
# ================================================================================

output "aws_instance_public_dns" {
    value = "${aws_instance.base.public_dns}"
}

output "aws_instance_public_ip" {
  value = "${aws_instance.base.public_ip}"
}
