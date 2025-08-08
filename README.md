# 🚀 Automated Web Application Deployment Using Terraform and AWS CI/CD Stack

## 📌 Project Overview

This project demonstrates an automated deployment pipeline for a Dockerized web application using:

- **Terraform** for provisioning AWS infrastructure
- **AWS CodePipeline, CodeBuild, and CodeDeploy** for CI/CD
- **SRE principles** like **idempotency, rollback**, and **observability**

The application is deployed to a high-availability EC2 Auto Scaling Group, with traffic routed via an Application Load Balancer (ALB).

---

## 🎯 Objectives

- Automate infrastructure provisioning using Terraform
- Build and deploy a Dockerized web application
- Enable end-to-end CI/CD pipeline with GitHub trigger
- Implement observability using CloudWatch
- Apply Site Reliability Engineering (SRE) practices

---

## 📁 Folder Structure

```
ci-cd-assignment/
├── app/                        # Flask application source
│   ├── Dockerfile
│   └── app.py / index.html
│
├── scripts/                    # CodeDeploy lifecycle hooks and deployment scripts
│   ├── after_install.sh
│   ├── before_install.sh
│   ├── start_server.sh
│   ├── validate_server.sh
│   └── appspec.yml
│
├── terraform/
│   ├── cicd/                   # CI/CD setup via CodePipeline/Build/Deploy
│   │   ├── codebuild.tf
│   │   ├── codedeploy.tf
│   │   └── codepipeline.tf
|   |   └── iam.tf
│   │   └── variables.tf
│   ├── deploy/                 # Deployment-related scripts
│   │   └── scripts/
        └── start_server.sh
│   ├── infrastructure/        # Core infrastructure configuration
│   │   ├── cloudwatch.tf
│   │   ├── ec2_asg_alb.tf
│   │   ├── iam.tf
│   │   ├── s3_ecr.tf
│   │   ├── terraform.tfvars
│   │   ├── tfplan
│   │   ├── variables.tf
│   │   └── vpc.tf
│
├── buildspec.yml              # CodeBuild specification
├── README.md                  # Project documentation
```

---

## 🛠️ Tools & Technologies

| Tool             | Purpose                             |
|------------------|-------------------------------------|
| Terraform        | Infrastructure as Code              |
| AWS CodePipeline | CI/CD orchestration                 |
| AWS CodeBuild    | Build Docker image, run Terraform   |
| AWS CodeDeploy   | Deployment via EC2 + ALB            |
| Amazon EC2       | Hosting application                 |
| ALB + ASG        | High Availability & Load Balancing  |
| ECR              | Docker image registry               |
| S3               | Pipeline artifact storage           |
| IAM              | Secure role-based access            |
| CloudWatch       | Logs and alarms for observability   |

---

## ✅ Prerequisites

- AWS Account with IAM access
- GitHub repository containing this code
- Personal Access Token (PAT) stored in AWS Secrets Manager or SSM
- Terraform CLI installed locally or via CodeBuild
- Basic knowledge of Docker, Git, and AWS services

---

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/mohammed-saifuddin/ci-cd-assignment.git
cd ci-cd-assignment
```

### 2. Store GitHub Token

If integrating GitHub in Terraform for CodePipeline:

```bash
aws ssm put-parameter --name "github-token" --value "<YOUR_TOKEN>" --type "SecureString"
```

### 3. Terraform Provisioning

```bash
cd terraform/infrastructure
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

Resources Provisioned:
- VPC, Subnets, NAT Gateway
- IAM Roles and Policies
- EC2 Auto Scaling Group and ALB
- ECR and S3 Bucket
- CloudWatch Alarms

### 4. Trigger Deployment

- Push to GitHub or upload artifact to S3
- CodePipeline will automatically build and deploy the app

---

## 🔁 CI/CD Pipeline Overview

| Stage   | Tool        | Task Description                          |
|---------|-------------|--------------------------------------------|
| Source  | GitHub/S3   | Trigger on push or upload                  |
| Build   | CodeBuild   | Build Docker image, push to ECR, run Terraform |
| Deploy  | CodeDeploy  | Deploy updated image to EC2 via ALB        |

### Deployment Scripts in `scripts/`:

| Script Name         | Purpose                                  |
|---------------------|------------------------------------------|
| `before_install.sh` | Stop existing app, clean up environment  |
| `after_install.sh`  | Install Docker, pull ECR image           |
| `start_server.sh`   | Start containerized app                  |
| `validate_server.sh`| Health check for the new deployment      |
| `appspec.yml`       | CodeDeploy lifecycle hook specification  |

---

## 🔙 Rollback Strategy

- Automatic rollback on failed health checks by CodeDeploy
- Manual rollback: revert commit and re-push to GitHub

---

## 🧪 Deployment Verification

- Use the ALB DNS output by Terraform
- Visit `http://<alb-dns-name>` to see the running app

---

## 📊 Observability

- CloudWatch Logs from CodeBuild and EC2
- CloudWatch Alarms for EC2 CPU, ALB errors

---

## ✨ Bonus

- ✅ Blue/Green or Canary deployments via CodeDeploy
- ✅ Notifications on pipeline failure via Lambda/EventBridge
- ✅ Cost estimation with `terraform plan -detailed-exitcode`

---

## 🧠 SRE Principles Applied

| Principle      | Implementation                                                  |
|----------------|------------------------------------------------------------------|
| Idempotency    | Terraform ensures safe re-runs                                  |
| Observability  | CloudWatch Logs & Alarms                                        |
| Automation     | Full CI/CD flow is automated                                    |
| Rollback       | CodeDeploy handles failures automatically                       |

---
