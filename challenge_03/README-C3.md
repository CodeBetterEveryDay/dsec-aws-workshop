# Create EC2 Instance Ubuntu

- Create EC2 Instance (Ubuntu) and verify ssh connection with Terraform.
- Update tags
- Install Python3
- Verify ssh connection

```base-c3-start.tf```

Provision infrastructure:
```bash
$ terraform plan -var-file=<.tfvars> -out base.plan
$ terraform apply base.plan
```

Verify EC2 instance in AWS Console.


```base-c3-update1.tf```
Add tags (follow TODO section in the file)


```base-c3-update2.tf```
Install Python3
ssh to the instance (use .pem file)
Verify Python3 is installed
