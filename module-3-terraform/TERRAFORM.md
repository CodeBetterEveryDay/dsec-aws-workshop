# Terraform

## Configure Terraform Variables 

| Name          | Value                 |
|---------------|-----------------------|
| ami           | ami-0181f8d9b6f098ec4 |
| instance_type | t1.micro              |
| region        | eu-west-1             |


## Initialize Terraform

```bash
$ terraform init

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.34"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

# Exercise #1

## Show Terraform Plan


## Apply Terraform Plan


## Validate Created EC2 Instance


## Destroy Created Resources



