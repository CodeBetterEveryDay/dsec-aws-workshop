# Setup AWS Account

## Configure AWS Account

- Create AWS account
- Create IAM user for the workshop (with cli and console access!)


## Configure your laptop

Install Python3
```bash
$ brew install python3
```
Clone the [workshop repository](https://github.com/CodeBetterEveryDay/dsec-aws-workshop) from GitHub
```bash
$ git clone git@github.com:CodeBetterEveryDay/dsec-aws-workshop.git
$ cd dsec-aws-workshop
```
- Create Python Virtual Environment
```bash
$ python3 -m venv venvaws
```
- Activate Python virtualenv
```bash
$ source awsvenv/bin/activate
(awsvenv) $
```
- Update pip
```bash
(awsvenv) $ pip install -U pip

Collecting pip
  Using cached https://files.pythonhosted.org/packages/c2/d7/90f34cb0d83a6c5631cf71dfe64cc1054598c843a92b400e55675cc2ac37/pip-18.1-py2.py3-none-any.whl
Installing collected packages: pip
  Found existing installation: pip 10.0.1
    Uninstalling pip-10.0.1:
      Successfully uninstalled pip-10.0.1
Successfully installed pip-18.1
```
- Install aws cli ([boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html))
```bash
$ pip install awscli
```
- Verify installation
```bash
(awsvenv) $ aws --version
aws-cli/1.16.32 Python/3.7.0 Darwin/17.7.0 botocore/1.12.22
```

## Configure AWS Account
- Create aws account
- Create a user `terraform` (IAM) with console (WebUI) and ssh access rights (admin privileges)
- Copy user's `aws_access_key` and `aws_secret_key` to your laptop

## Configure aws cli on your laptop
- Create a directory `~./aws/`
- Configure user with profile name `terraform`
```bash
$ aws configure --profile terraform
```


