# Assignment 5 — Deploy a Highly Available Two-Tier Application on AWS (VPC + ALB + ASG + Multi-AZ RDS)

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will design and deploy a highly available two-tier web application on AWS: highly available networking across two Availability Zones, an Application Load Balancer, an Auto Scaling Group for the web tier, and a private Multi-AZ RDS database. You must prove high availability with real failure tests.

---

# Task 1 — Create HA Networking (VPC + 4 Subnets + IGW + NAT + Route Tables)

## Goal

Build a VPC (10.0.0.0/16) with two public and two private subnets across two Availability Zones, an Internet Gateway, a NAT Gateway, and the matching public/private route tables.

### Evidence

#### Screenshot 1 — VPC details showing CIDR 10.0.0.0/16

![Screenshot 1 — VPC details showing CIDR 10.0.0.0/16](screenshots/01-VPC-details-showing-CIDR-ass5.png)


---

#### Screenshot 2 — Subnets list showing four subnets and their Availability Zones

![Screenshot 2 — Four subnets across Availability Zones](screenshots/02-Subnets-list-showing-four-subnets-and-AZs-ass5.png)


---

#### Screenshot 3 — Public route table showing the Internet Gateway route and both public-subnet associations

![Screenshot 3 — Public route table with IGW and subnet associations](screenshots/03-Public-route-table-IGW-and-subnet-associations-ass5.png)

---

#### Screenshot 4 — Private route table showing the NAT Gateway route and both private-subnet associations

![Screenshot 4 — Private route table with NAT Gateway and subnet associations](screenshots/04-Private-route-table-NAT-and-subnet-associations-ass5.png)

---

#### Screenshot 5 — NAT Gateway status showing Available and the Elastic IP

![Screenshot 5 — NAT Gateway available with Elastic IP](screenshots/05-NAT-gateway-available-and-EIP-ass5.png)

---

# Task 2 — Create Security Groups (ALB, EC2, RDS) with Least Privilege

## Goal

Create `ha-alb-sg` (HTTP public), `ha-web-sg` (HTTP only from `ha-alb-sg`, SSH from your IP), and `ha-db-sg` (database port only from `ha-web-sg`).

### Evidence

#### Screenshot 6 — ALB Security Group inbound rules

![Screenshot 6 — ALB Security Group inbound rules](screenshots/06-ALB-security-group-inbound-rules-ass5.png)

---

#### Screenshot 7 — EC2 Security Group inbound rules showing the ALB Security Group reference and SSH from your IP

![Screenshot 7 — EC2 Security Group inbound rules](screenshots/07-EC2-security-group-inbound-rules-ass5.png)

---

#### Screenshot 8 — RDS Security Group inbound rule showing the database port allowed only from the EC2 Security Group

![Screenshot 8 — RDS Security Group inbound rule](screenshots/08-RDS-security-group-inbound-rule-ass5.png)

---

# Task 3 — Deploy Database Tier (RDS Multi-AZ in Private Subnets)

## Goal

Launch a private, Multi-AZ RDS database (MySQL or PostgreSQL) using the private DB Subnet Group and `ha-db-sg`.

### Evidence

#### Screenshot 9 — RDS summary showing Multi-AZ = Yes and Publicly accessible = No

![Screenshot 9 — RDS Multi-AZ and no public access](screenshots/09-RDS-summary-Multi-AZ-and-no-public-access-ass5.png)

---

#### Screenshot 10 — RDS connectivity section showing the DB Subnet Group and Security Group

![Screenshot 10 — RDS connectivity and security configuration](screenshots/10-RDS-connectivity-subnet-group-security-group-ass5.png)

---

# Task 4 — Build a Launch Template (User Data Installs App + Connects to DB)

## Goal

Create a Launch Template whose user data installs the web-server runtime, deploys the application, configures the database connection, and starts the required services.

### Evidence

#### Screenshot 11 — Launch Template details showing that user data exists, including a visible snippet

![Screenshot 11 — Launch Template user data](screenshots/11-Launch-template-user-data-snippet-ass5.png)

---

#### Screenshot 12 — A running instance created from the template showing that the application responds on port 80 through a local test or browser using its public IP

![Screenshot 12 — Application responding on port 80](screenshots/12-Launch-template-instance-application-port-80-ass5.png)

---

# Task 5 — Create an Application Load Balancer (ALB) Across 2 Public Subnets

## Goal

Create an internet-facing ALB across both public subnets with an HTTP listener and a healthy instance target group.

### Evidence

#### Screenshot 13 — ALB details showing two public subnets in two Availability Zones

![Screenshot 13 — ALB across two public subnets and Availability Zones](screenshots/13-ALB-details-two-public-subnets-two-AZs-ass5.png)

---

#### Screenshot 14 — Target group showing at least one healthy target

![Screenshot 14 — Target group with healthy target](screenshots/14-Target-group-healthy-target-ass5.png)

---

# Task 6 — Create Auto Scaling Group (ASG) in 2 Public Subnets

## Goal

Create an Auto Scaling Group from the Launch Template across both public subnets, with desired capacity 2, minimum 2, and maximum 4, registered to the ALB target group.

### Evidence

#### Screenshot 15 — Auto Scaling Group showing desired, minimum, and maximum capacity and the selected subnet Availability Zones

![Screenshot 15 — Auto Scaling Group capacity and Availability Zones](screenshots/15-Auto-scaling-group-capacity-and-AZs-ass5.png)

---

#### Screenshot 16 — EC2 instances list showing two running instances in different Availability Zones

![Screenshot 16 — Two running EC2 instances in different Availability Zones](screenshots/16-EC2-two-running-instances-different-AZs-ass5.png)

---

# Task 7 — Configure App to Use RDS + Validate Read/Write

## Goal

Confirm the application communicates with the RDS database through the ALB DNS name with at least one read and one write operation.

### Evidence

#### Screenshot 17 — Browser showing the application loaded through the ALB DNS name with the URL visible

![Screenshot 16 — Two running EC2 instances in different Availability Zones](screenshots/16-EC2-two-running-instances-different-AZs-ass5.png)

---

#### Screenshot 18 — Proof of a database write through a UI message or database query output

![Screenshot 18 — Database write proof](screenshots/18-Database-write-proof-ass5.png)

---

# Task 8 — High Availability Tests (Must Do Both)

## Goal

Test A: terminate one web instance and confirm the Auto Scaling Group replaces it automatically without interrupting the ALB.

Test B: simulate an Availability Zone impact (stop, detach, or reduce desired capacity in one AZ) and confirm the application stays available.

### Evidence

#### Screenshot 19 — EC2 showing the terminated instance and the newly launched instance; timestamps are helpful

![Screenshot 19 — ASG instance replacement after termination](screenshots/19-ASG-instance-replacement-after-termination-ass5.png)

---

#### Screenshot 20 — Target group showing healthy targets after replacement

![Screenshot 20 — Healthy targets after instance replacement](screenshots/20-Target-group-healthy-after-replacement-ass5.png)

---

#### Screenshot 21 — Evidence that an instance was removed, detached, placed in Standby, or stopped in one Availability Zone

![Screenshot 21 — Instance removed from one Availability Zone](screenshots/21-Instance-removed-from-one-AZ-ass5.png)

---

#### Screenshot 22 — Browser showing that the ALB DNS endpoint still works during the change

![Screenshot 22 — ALB application available during AZ test](screenshots/22-ALB-application-available-during-AZ-test-ass5.png)

---

# Task 9 — Architecture and Test-Results Summary

## Goal

Summarize the VPC/subnet layout, the ALB and Auto Scaling Group setup, the private Multi-AZ RDS setup, and the results of both high-availability tests.

### Evidence

#### Screenshot 23 — A simple architecture diagram, which may be hand-drawn, or an AWS console overview showing the components

![Screenshot 23 — AWS highly available two-tier architecture](screenshots/23-AWS-HA-two-tier-architecture-diagram-ass5.png)
---

### Notes

Summarize the VPC and subnets across the two Availability Zones.

The application was deployed in an AWS VPC with CIDR block `10.0.0.0/16`. The VPC was configured across two Availability Zones in the `us-east-1` region, using two public subnets and two private subnets. The public subnets provide internet-facing access for the Application Load Balancer and web tier, while the private subnets are used for internal resources. An Internet Gateway provides internet connectivity for the public subnets, while a NAT Gateway provides outbound internet access for resources in the private subnets.

Summarize the ALB and Auto Scaling Group setup.

An internet-facing Application Load Balancer was deployed across two public subnets in different Availability Zones. The ALB forwards HTTP traffic on port 80 to the web target group. An Auto Scaling Group was configured using the `HA-WEB-Launch-Template`, with a desired capacity of 2, minimum capacity of 2, and maximum capacity of 4. The web instances are distributed across two Availability Zones to improve application availability and allow the ASG to replace failed instances automatically.

Summarize the private Multi-AZ RDS setup.

The database tier uses Amazon RDS for MySQL in the private database subnet group. The database is not publicly accessible and uses the `ha-db-sg` security group. Database access on port 3306 is restricted to the web-tier security group, preventing direct public access to the database. The RDS subnet group uses private subnets across the Availability Zones to support the highly available database architecture.

Summarize the results of both high-availability tests.

Two high-availability tests were performed. First, one web-tier EC2 instance was terminated and the Auto Scaling Group automatically launched a replacement instance, restoring the desired capacity. The target group subsequently showed healthy targets.

Second, an instance in one Availability Zone was removed/stopped to simulate an Availability Zone impact. The remaining web infrastructure continued serving traffic through the Application Load Balancer, and the application remained accessible through the ALB DNS endpoint. These tests demonstrated the application's ability to continue operating when individual web-tier resources or one Availability Zone are affected.

---

# LinkedIn Post (Required)

## Goal

Publish a LinkedIn post about the high-availability build, including the ALB URL (or a redacted screenshot), three to five lines on what you built and how you tested high availability, and one proof screenshot.

## Evidence

#### LinkedIn Post URL

https://www.linkedin.com/posts/nji-ariane-ruth-494805172_built-a-highly-available-two-tier-application-activity-7506001954574106624-E2nV?utm_source=share&utm_medium=member_desktop&rcm=ACoAACkN5HAB_6uWL_--MIEwRhEZ_BLCaqDxIoo

---

#### Screenshot of LinkedIn post

![Screenshot 24 — LinkedIn post for Assignment 5](screenshots/24-LinkedIn-post-ass5.png)

---

# Submission Instructions

- Add all required screenshots in your submission
- Do not expose passwords, connection strings, private keys, or account IDs

---

# Completion Checklist

- [x] Task 1: VPC, four subnets, IGW, NAT Gateway, and route tables created (Screenshots 1–5)
- [x] Task 2: Least-privilege ALB, EC2, and RDS security groups created (Screenshots 6–8)
- [x] Task 3: Private Multi-AZ RDS created (Screenshots 9–10)
- [x] Task 4: Self-configuring Launch Template created and tested (Screenshots 11–12)
- [x] Task 5: ALB created across both public subnets (Screenshots 13–14)
- [x] Task 6: Auto Scaling Group running two instances across two AZs (Screenshots 15–16)
- [x] Task 7: Application verified through the ALB with a database read and write (Screenshots 17–18)
- [x] Task 8: Both high-availability tests completed (Screenshots 19–22)
- [x] Task 9: Architecture and test-results summary completed (Screenshot 23 & Notes)
- [x] LinkedIn post published and URL submitted
- [x] No sensitive data exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme  
- 🎓 University: https://university.pravinmishra.com?utm_source=github&utm_medium=readme  
- 💬 Discord Community: https://discord.pravinmishra.com?utm_source=github&utm_medium=readme  
- 📝 Blog: https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*