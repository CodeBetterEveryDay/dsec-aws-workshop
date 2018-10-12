# CHALLENGE 2

## Exercise 0 - Validate AWS CLI configuration

Make sure you have following files in your `~/.aws/` dir:
```bash
config
credentials
terraform.pem
```
config:
```bash
[profile terraform]
region = eu-west-1
```
credentials:
```bash
[terraform]
aws_access_key_id = <YOUR-AWS-KEY>
aws_secret_access_key = <YOUR-SECRET-AWS-KEY>
```

## Exercise 1 - Provision EC2 Instance

Initialize Terraform environment (download plugins):
```bash
$ terraform init
```

Create terraform plan:
```bash
$ terraform plan
```

Apply plan - provision resources in AWS.
```bash
$ terraform apply
```

## Exercise 2 - Update EC2 Instance

- Add following tags to the running instance
```bash
Team = "DataScience"
BillingDepartment = "IE-DUB-OFFICE"
```

Terraform code to add to the resource:
```bash
tags {
    Team = "SysSecInfra",
    ...
    ...
}
```

- Run terraform plan, terraform apply and verify tags are added to the running EC2 instance.

