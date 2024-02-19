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

## Network Foundation
As stated in the challange, we need a VPC, a private and public subnet. Set up an Internet Gateway for public subnet access and NAT Gateways for private subnet access.

#### I created a VPC with:
 - 1 public subnet:
    - For internet access to Public Subnet, I used Firewall with HTTP and HTTPS traffic allowed.
   https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/bd583804afb0497b8bacc9e044b80cda62873a56/project.tfvars#L19-L27

 - 1 private subnet:
    - NAT Gateway for the private subnet, I used compute_router and compute_router_nat
      https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/bd583804afb0497b8bacc9e044b80cda62873a56/project.tfvars#L29-L62
      
<img width="1128" alt="Screenshot 2024-02-18 at 9 48 48 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/2436bbb9-1c8a-459b-9d80-f236afdedf3c">


## Security Measures
As stated in the challange, Use IAM roles for secure CLOUD service interactions without hard-coded credentials.

#### I used IAM Policies to give the necessary permission for the service account:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/project-management-terraform/aim_roles.tf#L1-L32
   - See the tfvars details:
     https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/project-management-terraform/project.tfvars#L19-L36
     
## Web Tier Configuration
As stated in the challange: Deploy web servers within an auto-scaling group, ensuring they can handle load spikes and failures gracefully.- Utilize an Application Load Balancer to distribute traffic evenly across your instances.

#### I used instance templates for a commong instance type:
- Template's NIC resides in the Private Subnet
  - See the module values:
    https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/project.tfvars#L80-L100
    <img width="1223" alt="Screenshot 2024-02-18 at 9 50 11 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/6e97990f-56ef-46f0-a600-49b1c3e98884">


#### I used compute_health_check resource to check the instance health:
- See the module values:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/project.tfvars#L102-L113

#### I used compute_instance_group_manager to create and manage pools of Compute Engines
- See the module:
   https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L50-L60
  <img width="1213" alt="Screenshot 2024-02-18 at 9 51 10 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/105f671f-f294-4155-af4a-8739837da535">


#### I used compute_backend_service to use as a backend of the Application Load Balancer
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L62-L76
  <img width="877" alt="Screenshot 2024-02-18 at 9 52 11 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/e8b988c9-516f-410c-8f0c-c91ef70a4ec8">


#### I used compute_url_map which is a URL Map Load Application Balancer
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L97-L104
  <img width="797" alt="Screenshot 2024-02-18 at 9 53 08 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/cb5ba7ab-e9a7-4895-af7c-2e1318d12c0c">


#### I used compute_target_http_proxy Represents a TargetHttpProxy resource, which is used by one or more global forwarding rule to route incoming HTTP requests to a URL map.
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L106-L113
  <img width="384" alt="Screenshot 2024-02-18 at 9 54 16 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/1df82616-f82e-42d5-a252-593508e583a5">


#### I used compute_global_forwarding_rule : takes a name, the target HTTP proxy, and the range of port numbers this rule will serve for TCP.
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L115-L123
  <img width="310" alt="Screenshot 2024-02-18 at 9 53 50 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/12dd89fe-f369-40b3-95a8-eede3c708734">


## Database Deployment:
As stated in the challange: Provision a managed database in a private subnet, accessible only by your application servers.

#### I used sql_database_instance for managed PostgreSQL 15 type.
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/75ec34b02bcc472233613caaa7978ae7eea4e1ee/database.tf#L1-L18
  <img width="1273" alt="Screenshot 2024-02-18 at 9 54 46 PM" src="https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/02167566-29ed-4be5-8cd2-5dce69ef1688">


## Implement Auto-Scaling
As stated in the challange: Configure auto-scaling policies based on metrics (CPU, memory) to scale your web server fleet up or down automatically.

#### I used compute_instance_autoscaler to auto-scale the instances based on the thresholds
- See the module:
  https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/blob/4b3b7eb47b40799abb5de6e6200bca36aaa55cdd/compute.tf#L78-L95
![Screenshot 2024-02-19 at 8 47 48 AM](https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/a417f4cd-507f-4a1d-b049-09b06e3c71b0)


# Project Process and Reflection

### Understanding the Requirements and Resource Planning
The journey began with a deep dive into understanding the specific requirements of deploying a secure and scalable web application on Google Cloud Platform (GCP). Although I was familiar with GCP, identifying the precise resources and their components necessary for this project posed an initial challenge. This step was crucial to ensure that the architecture would not only meet the challenge's objectives but also adhere to best practices in cloud infrastructure.

### Terraform Resource Code Exploration and Module Development
The next step involved an exhaustive exploration of Terraform's documentation for the required resources. Understanding how each resource needed to be configured and how they interconnect within the cloud environment was both time-consuming and enlightening. This phase was particularly intensive as I decided to write Terraform modules from scratch. The goal here was not just to meet the challenge's immediate needs but to create reusable components that could simplify future infrastructure as code (IaC) projects. Although this approach demanded a significant investment of time, the outcome was a set of modular, flexible, and reusable Terraform modules that could serve as a foundation for various cloud architectures.

### Infrastructure Diagram Creation
Visualizing the architecture was another critical step in the process. Creating an infrastructure diagram took time but was essential for several reasons: it facilitated a better understanding of the overall architecture, helped in identifying potential issues or improvements, and provided a clear reference for both current and future project stakeholders. This diagram serves as a map, guiding the viewer through the complex interconnections of cloud resources that make up the secure and scalable web application.

# Challenges Encountered

### Accidental Deletion of IAM Policies
One of the most significant challenges I encountered was inadvertently locking myself out of the project by deleting the google_project_iam_policy resource. This mistake was particularly frustrating and time-consuming, leading to a substantial setback. 

I was like:

![giphy (2)](https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/e08dc506-c462-4854-9400-625856f75df1)

The issue stemmed from following guidance on <a href="https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_policy" target="_blank">HashiCorp's Terraform Registry</a>, which, while helpful, resulted in an unexpected complication. To resolve this, I had to start from scratch by creating a new project and meticulously reconfiguring IAM policies in alignment with HashiCorp's recommendations. This experience underscored the importance of careful resource management and the potential pitfalls of managing IAM policies through Terraform.


### Enabling GCP Resource APIs
Another challenge specific to GCP was the requirement to enable APIs for each resource before it could be managed through Terraform. This step is distinct from my experiences with Azure and AWS, where resource APIs are generally enabled by default or managed differently. Adapting to GCP's approach required a shift in mindset and an appreciation for the platform's unique operational model. Despite the initial learning curve, this aspect of GCP's infrastructure management ultimately added a valuable perspective to my cloud engineering skillset.

# Reflections
This project was not just about meeting the challenge's technical requirements; it was a journey of growth, learning, and adaptation. The process of building from the ground up, facing and overcoming obstacles, and reflecting on these experiences has deepened my understanding of GCP infrastructure and Terraform's capabilities.

## Thanks for reading!

![giphy](https://github.com/hkaanturgut/GCP-Advanced-Terraform-Interactive-Learning-Challenge/assets/113396342/58ed984e-c089-45e3-8030-97b98a6ead70)

