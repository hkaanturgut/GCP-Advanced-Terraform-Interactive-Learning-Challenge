# GCP-Advanced-Terraform-Interactive-Learning-Challenge


## Introduction
Welcome to my GCP Advanced Terraform Interactive Learning Challenge repository. Inspired by Erol Kavas's initiative, which can be explored at <a href="https://www.linkedin.com/pulse/advanced-terraform-interactive-learning-challenge-erol-kavas-aujxc/?trackingId=87jgxLkuTk%2BTJ0t7uL4O0g%3D%3D" target="_blank">Advanced Terraform Interactive Learning Challenge by Erol Kavas</a> 

## Challenge Overview
#### The challenge focuses on three core objectives:

- Deploy a robust web application infrastructure using Terraform, leveraging GCP services for a comprehensive and functional architecture.
  
- Implement security best practices through GCP's security features, including VPCs, security groups, and IAM roles, to protect the application from unauthorized access.
  
- Ensure scalability and high availability by utilizing auto-scaling for web servers and employing managed database services, ensuring the application can handle load changes and maintain uptime.
  
Key steps involve preparing the environment, building a secure network foundation, configuring the web and database tiers with security and scalability in mind, and setting up auto-scaling to dynamically adjust resources.

This challenge is not just about deploying infrastructure; it's about mastering real-world cloud architecture principles to create resilient, efficient, and secure applications on GCP.

### Prerequisites
- Terraform installation
- GCP account set up

## Architecture Diagram
![GCP CHALLANGE DIAGRAM](https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/de1c3716-dae5-4f26-b221-e40b9a1b0a5e)

### Note: I utilized MODULE approach which is best practice to follow reuseable, more secure and compliant code base. Please see the values for the modules in the .tfvars file.

## Project/Terraform Configuration Guide

### Project Creation: 
You can either create your project from GCP UI or with the following Terraform code:
https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/ac4db429020ded18577ea7e45fc53fdff3402c91/project-management-terraform/project.tf#L8-L15

### Service Account Creation
It's good to use Service Account for the operations. To create the Service Account :
- Go under IAM & Admin and create a Service account.
- Go to KEY tab and create a new one to use in your Terraform config.
  
 ![Screenshot 2024-02-17 at 9 10 49 PM](https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/b542102d-c149-4c21-a405-64d3937f862e)

### Enable needed APIs (resources to use in the project)
-  Enable services in newly created GCP Project with the following code:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/ac4db429020ded18577ea7e45fc53fdff3402c91/project-management-terraform/project.tf#L17-L24
- See the tfvars file for the values : https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/ac4db429020ded18577ea7e45fc53fdff3402c91/project-management-terraform/project.tfvars#L9-L17

### Create a Bucket to store STATEFILE remotyl and more secure
- Create a bucket with the following code:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/ac4db429020ded18577ea7e45fc53fdff3402c91/project-management-terraform/project.tf#L26-L33

### Provider Configuration
- Once the previous steps are done, you can configure your provider.tf as the following :  <a href="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/main/provider.tf" target="_blank">provider.tf</a>
- Make sure you give the right path for your credentials file in this code snippet:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/ac4db429020ded18577ea7e45fc53fdff3402c91/provider.tf#L18-L19
#### Note: Google-beta provider si needed for couple resources in the project.

## Networking Overview
As stated in the challange, we need a VPC, a private and public subnet. Set up an Internet Gateway for public subnet access and NAT Gateways for private subnet access.

I created a VPC with:
 - 1 public subnet:
    - For internet access to Public Subnet, I used Firewall with HTTP and HTTPS traffic allowed.
   https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/bd583804afb0497b8bacc9e044b80cda62873a56/project.tfvars#L19-L27

 - 1 private subnet:
    - NAT Gateway for the private subnet, I used compute_router and compute_router_nat
      https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/bd583804afb0497b8bacc9e044b80cda62873a56/project.tfvars#L29-L62
