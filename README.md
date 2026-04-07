# 🚀 Zero-Touch Self-Healing MLOps Deployment System

## 📌 Overview
This project demonstrates a fully automated MLOps deployment pipeline using Terraform and Docker on AWS.

The system provisions infrastructure, deploys a containerized application, and ensures high availability through self-healing mechanisms — all with a single command.

---

## ⚙️ Features

- Infrastructure as Code (Terraform)
- Automated EC2 provisioning
- Docker-based deployment
- Self-healing system:
  - Docker restart policy
  - Health check + cron job
- Public API deployment
- Reliable provisioning using Terraform provisioners

---

## 🏗️ Architecture


Local Machine → Terraform → AWS EC2 → Setup Script → Docker → API + Self-Healing


---

## 🚀 How It Works

1. Run:


terraform apply


2. Terraform:
- Creates EC2 instance
- Uploads setup script
- Executes deployment

3. Application runs at:


http://<EC2_PUBLIC_IP>:8000


---

## 🛠️ Tech Stack

- AWS EC2
- Terraform
- Docker
- Bash scripting

---

## 🧠 Key Learnings

- Terraform provisioners & remote execution
- Debugging SSH & infra issues
- OS-level deployment differences
- Building reliable automation pipelines

---

## ⚠️ Challenges Faced

- SSH key issues
- Security group misconfigurations
- Terraform race conditions
- Docker permission issues

## Author
Yuvraj Dixit