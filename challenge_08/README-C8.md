# NETWORKING

## New Concepts:

- Running EC2 Instances in multiple Subnets
- Updating Tags
- Destroying selected resources
- Updating Web Page served by NGINX
- Provisioning a Load Balancer
- Adding subnet to the VPC
- Adding subnet and a WebServer to the Load Balancer


## Action Items

### Initialize Terraform
```bash
$ terraform initialize
```

### Provision Infrastructure
```base-c8-start.tf```

```bash
$ terraform plan -var-file=<> -out base.plan
$ terraform apply "base.plan"
```

### Add EC2 Instance
```base-c8-update1.tf```

- Follow TODO list inside the ```base-c8-update1.tf```
- Open ```base-c8-update1.tf.ignore```
- Add second EC2 instance
- Update tags: Name = "DSEC-WEBSRV-2", Team = "QA"
- Update Served Web Page. Web page should show: "DSEC Meetup - WEBSERVER 2"

Create terraform plan:
```bash
$ terraform plan -var-file=<x.tfvars> -var-file=<x.tfvars> -out base.plan
```
Run the plan
```bash
$ terraform apply "base.plan"
``` 
Verify in the web browser that two web servers are accessible.

### Destroy Selected EC2 Instance
Destroy only EC2 instances:
```bash
$ terraform show | grep aws_instance
aws_instance.WEBSRV1:
aws_instance.WEBSRV2:
aws_instance_public_dns1 = ec2-52-215-189-149.eu-west-1.compute.amazonaws.com
aws_instance_public_dns2 = ec2-52-49-251-147.eu-west-1.compute.amazonaws.com
```
Destroy EC2 instances:
```bash
$ terraform destroy -target=aws_instance.WEBSRV1 -target=aws_instance.WEBSRV2 -var-file=<path-to-terraform.tfvars> -var-file=base.tfvars
```
Destroy the rest of infrastructure:
```bash
$ terraform destroy
```

### Add Elastic Load Balancer
```base-c8-update2.tf``` 

- Provision infrastructure using ```base-c8-update2.tf```
- Verify terraform report, identify resources that will change.
- Verify web browser serves pages from 2 servers


```base-c8-update3.tf```
- Follow TODO inside the ```base-c8-update3.tf```
- Add 3rd subnet
- Add 3rd EC2 instance running web server
- Apply updates to the AWS environment
- Verify webpages are served from three web servers (use ELB url)  
- Destroy EC2 instances 
```bash
$ terraform show | grep aws_instance
aws_instance.WEBSRV1:
aws_instance.WEBSRV2:
aws_instance.WEBSRV3:
```
- Destroy the rest of the infrastructure
