# Multiple Web Servers (EC2 instances)

## Diagram

![img](../img/aws3.png)


- Provision infrastructure using ```base-c5-start.tf```
- Add second aws_instance resource (2nd NGINX server) ```base-c5-update.tf```
- Create plan and apply changes

