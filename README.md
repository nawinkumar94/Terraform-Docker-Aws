## **Two tier architecture in aws using Terraform**

## **About Terraform**

Terraform is a tool used to Build,Configure and Version up the Infrastructure efficiently.

Terraform uses the configuration files to build and manage the Infrastructure

## **Features of Terraform:**

1.Infrastructure as Code

2.Execution Planning

3.Resource Graph

4.Changes by Automation

## **About Project**

1.Created a VPC and all its sub components

2.Created a Load Balancer and Target Group

3.Lauched two ec2 instances as webservers with nginx installed and dockerized

4.Load Balancer redirects traffic to each webservers

5.Created two ec2 instances as db servers that contains mysql installed and dockerized

6.Cloudwatch Log Group created for storing the log streams in vpc with vpc flow logs

## **System requirements**

This version of packages and files was last tested on:

Virtual Box - Ubuntu 20.04 and Ubuntu WSL


## **Infrastructure**

AWS Cloud

## **Usage**

1.To Intialize the terraform configuration
  terraform init

2.To Format the Terraform Config files
  terraform fmt

3.To Validate the Terraform Config files
  terraform validate

4.To Get the Plan of Terraform Config files
  terraform plan -out output.terraform

5.To Execute the Terraform Config
  terraform apply "output.terraform"

6.To Destroy or bring down the infrastructure
  terraform destroy

## **Project Insider**

Module: 1.application

Module: 2.configuration

## **Test Infrastructure:**

1.Get the Loadbalancer DNS of Application instance

2.Launch It

## **Environment Setup for Terraform Using Vagrant and VirtualBox:**

## **About Vagrant**
Vagrant provides easy to configure, reproducible, and portable virtual machines And it uses various technologies like VirtualBox,VMware and AWS as providers.

## **Vagrant Download and Setup**
1.Download the Vagrant package for windows

https://www.vagrantup.com/downloads

2.Run and Install the package

3.Navigate to Workspace and run the below command for Setting up. vagrant init

4.Check the output "A Vagrantfile has been placed in this directory. You are now ready to vagrant up your first virtual environment!"

5.Open the Vagrantfile and remove unnecessary contents

6.Configure the Vagrantfile for Ubuntu Base Image Box: generic/ubuntu2004 Hostname: devbox

7.Customize the Virtual Box and VM resources

## **About VirtualBox**
VirtualBox is a powerful virtualization product which has high performance and open source. VirtualBox Download and Setup

1.Download and Install the Oracle VirtualBox https://www.virtualbox.org/

2.Check and Enable Virtualization in Windows Bios

3.Run below command in workspace. vagrant up

4.Open VirtualBox and DevBox should be up and running

5.SSH in to virtual environment "ssh vagrant@hostname -p port -i private_key_file"


## **Terraform Installation in Dev Box[Ubuntu Image]**
1.Execute the provision.sh script with chmod 700 permission. sudo ./provision.sh

2.Check and confirm Terraform Installation. terraform --version
