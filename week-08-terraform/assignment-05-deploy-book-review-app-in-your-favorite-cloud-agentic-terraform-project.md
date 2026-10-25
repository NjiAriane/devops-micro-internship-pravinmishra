# Capstone Assignment — Deploy the Book Review App Using Terraform and Claude Code Agentic AI

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** NJI MENYONGA ARIANE RUTH 
**Cloud Platform:** AWS (us-east-1) 
**GitHub Repository URL:**https://github.com/NjiAriane/devops-micro-internship-pravinmishra.git 

**Public Application URL / Load-Balancer DNS:**  https://xdr0flp20e.execute-api.us-east-1.amazonaws.com

---

## Purpose

Deploy the Book Review App using Terraform on AWS or Azure in a secure, highly available, production-style three-tier architecture. Use Claude Code, specialized subagents, Terraform MCP, and validation hooks to support the engineering workflow while keeping all infrastructure-changing operations under human control.

---

# Task 0 — Prepare the Project and Agentic AI Environment

## Goal

Prepare the Book Review App project and configure the provided Claude Code Agentic AI starter kit with project context, specialized subagents, Terraform MCP, validation hooks, and safety guardrails.

## Evidence

### Screenshot 1 — Project `CLAUDE.md`

Add a screenshot of the project `CLAUDE.md` showing the three-tier architecture, security boundaries, Terraform requirements, and human-approval rules.

![Screenshot 1 — Project CLAUDE.md](screenshots/Screenshot-01-CLAUDE-md.png)

---

### Screenshot 2 — Terraform Engineer Subagent

Add a screenshot showing the Terraform Engineer subagent configuration.

![Screenshot 2 — Terraform Engineer Subagent](screenshots/Screenshot-02-Terraform-Engineer-Subagent.png)


---

### Screenshot 3 — Architecture and Security Reviewer Subagent

Add a screenshot showing the Architecture and Security Reviewer subagent configuration.

![Screenshot 3 — Architecture Security Reviewer](screenshots/Screenshot-03-Architecture-Security-Reviewer.png)

---

### Screenshot 4 — Terraform MCP Connection

Add a screenshot showing Terraform MCP connected and available.

![Screenshot 4 — Terraform MCP Connection](screenshots/Screenshot-04-Terraform-MCP-Connection.png)


---

### Screenshot 5 — Validation Hooks

Add a screenshot showing the configured Claude Code validation hooks.

![Screenshot 5 — Validation Hooks](screenshots/Screenshot-05-Validation-Hooks.png)

---

# Task 1 — Design the Three-Tier Architecture

## Goal

Design the required secure, highly available three-tier architecture and create an architecture diagram before building the infrastructure.

The diagram must show:

- VPC or VNet
- Availability Zones or equivalent availability locations
- Six subnets
- Internet connectivity
- NAT or outbound design
- Public load balancer
- Web Tier
- Internal load balancer
- Application Tier
- Managed MySQL
- Read replica
- Main traffic flow

## Architecture Diagram

Add the completed architecture diagram here.

---

# Task 2 — Build the Terraform Networking and Security Layers

## Goal

Create the modular Terraform project and implement the network and security layers across the required public and private subnets.

## Evidence

### Screenshot 6 — Modular Terraform Project Structure

Add a screenshot showing the modular Terraform project structure.

![Screenshot 6 — Modular Project Structure](screenshots/Screenshot-06-Modular-Project-Structure.png)

---

### Screenshot 7 — Six-Subnet Architecture

Add a screenshot showing the six-subnet architecture across two availability locations.

![Screenshot 7 — Six Subnet Architecture](screenshots/Screenshot-07-Six-Subnet-Architecture.png)

---

### Screenshot 8 — Public and Private Tier Separation

Add a screenshot showing the public and private tier separation, including routing and security boundaries.

![Screenshot 8 — Public Private Tier Separation](screenshots/Screenshot-08-Public-Private-Tier-Separation.png)

---

# Task 3 — Build the Load-Balancing and Compute Layers

## Goal

Deploy the public and internal load balancers and the Web and Application compute resources required by the Book Review App.

## Evidence

### Screenshot 9 — Web and Application Compute

Add a screenshot showing the Web and Application compute resources in their required subnets.

![Screenshot 9 — Web Application Compute](screenshots/Screenshot-09-Web-Application-Compute.png)

---

### Screenshot 10 — Public Load Balancer

Add a screenshot showing the internet-facing public load balancer.

![Screenshot 10 — Public Load Balancer](screenshots/Screenshot-10-Public-Load-Balancer.png)

---

### Screenshot 11 — Internal Load Balancer

Add a screenshot showing the private internal load balancer.

![Screenshot 11 — Internal Load Balancer](screenshots/Screenshot-11-Internal-Load-Balancer.png)

---

### Screenshot 12 — Healthy Targets

Add a screenshot showing healthy target groups or backend pools.

![Screenshot 12 — Healthy Targets](screenshots/Screenshot-12-Healthy-Targets.png)

---

# Task 4 — Build the Managed MySQL Database Layer

## Goal

Deploy a private, highly available managed MySQL database with a read replica and restrict database connectivity to the Application Tier.

## Evidence

### Screenshot 13 — Managed MySQL Database

Add a screenshot showing the managed MySQL database deployment.

![Screenshot 13 — Managed MySQL Database](screenshots/Screenshot-13-Managed-MySQL-Database.png)

---

### Screenshot 14 — High Availability

Add a screenshot showing the Multi-AZ or high-availability configuration.

![Screenshot 14 — High Availability Multi-AZ](screenshots/Screenshot-14-High-Availability-Multi-AZ.png)

---

### Screenshot 15 — Read Replica

Add a screenshot showing the read replica configuration.

![Screenshot 15 — Read Replica](screenshots/Screenshot-15-Read-Replica.png)

---

### Screenshot 16 — Private Database Access

Add a screenshot showing that the database is private and accepts MySQL traffic only from the Application Tier.

![Screenshot 16 — Private Database Access](screenshots/Screenshot-16-Private-Database-Access.png)

---

# Task 5 — Validate, Review, and Apply the Terraform Configuration

## Goal

Validate the Terraform configuration, review the execution plan using both Agentic AI and human judgment, and apply the infrastructure changes only after all required checks pass.

## Evidence

### Screenshot 17 — Terraform Validation

Add a screenshot showing successful `terraform validate` output.

![Screenshot 17 — Terraform Validate](screenshots/Screenshot-17-Terraform-Validate.png)

---

### Screenshot 18 — Terraform Plan

Add a screenshot showing the Terraform plan output.

![Screenshot 18 — Terraform Plan](screenshots/Screenshot-18-Terraform-Plan.png)

---

### Screenshot 19 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

![Screenshot 19 — Terraform Apply](screenshots/Screenshot-19-Terraform-Apply.png)

---

# Task 6 — Deploy and Configure the Book Review Application

## Goal

Deploy and configure the Book Review App across the Web, Application, and Database tiers and verify the complete application functionality.

## Evidence

### Screenshot 20 — Homepage

Add a screenshot showing the Book Review App homepage through the public endpoint.

![Screenshot 20 — Application Homepage](screenshots/Screenshot-20-Application-Homepage.png)

---

### Screenshot 21 — Login or Authentication

Add a screenshot showing successful login or authentication.

![Screenshot 21 — Login Authentication](screenshots/Screenshot-21-Login-Authentication.png)

---

### Screenshot 22 — Book Data

Add a screenshot showing the book listing or book details.

![Screenshot 22 — Book Data](screenshots/Screenshot-22-Book-Data.png)

---

### Screenshot 23 — Review Functionality

Add a screenshot showing the review functionality working successfully.

![Screenshot 23 — Review Functionality](screenshots/Screenshot-23-Review-Functionality.png)

---

### Screenshot 24 — Backend or API Evidence

Add a screenshot showing that the backend or API is working successfully.

![Screenshot 24 — Backend API Evidence](screenshots/Screenshot-24-Backend-API-Evidence.png)

---

### Screenshot 25 — Database Reads and Writes

Add a screenshot showing successful database reads and writes.

![Screenshot 25 — Database Reads Writes](screenshots/Screenshot-25-Database-Reads-Writes.png)

## Public Application URL

**Public Application URL / DNS:** Add the working public application URL or load-balancer DNS here

---

# Task 7 — Demonstrate the Agentic AI Workflow

## Goal

Demonstrate how Claude Code assisted with Terraform generation, architecture and security review, and evidence-based troubleshooting while infrastructure-changing decisions remained under human control.

You do not need to submit your complete Claude Code conversation history. Include only focused evidence.

## Evidence

### Screenshot 26 — AI-Assisted Terraform Generation

Add a screenshot showing one useful example of AI-assisted Terraform generation or improvement.

![Screenshot 26 — AI Terraform Generation](screenshots/Screenshot-26-AI-Terraform-Generation.png)

---

### Screenshot 27 — Architecture or Security Review

Add a screenshot showing one structured architecture or security review result.

![Screenshot 27 — Architecture Security Review](screenshots/Screenshot-27-Architecture-Security-Review.png)

---

### Screenshot 28 — AI-Assisted Troubleshooting

Add a screenshot showing one AI-assisted troubleshooting interaction based on collected evidence.

![Screenshot 28 — AI-Assisted Troubleshooting](screenshots/Screenshot-28-AI-Assisted-Troubleshooting.png)
---

# Task 8 — Complete the Final Architecture Review

## Goal

Review the completed infrastructure against the original capstone requirements and resolve significant architecture, security, reliability, and cost issues.

Confirm that the final review covers:

- Tier separation
- Availability
- Public exposure
- Routing
- Security rules
- Load balancing
- Database privacy
- Secrets
- Terraform quality
- Module structure
- Reliability
- Obvious cost risks

Use Screenshot 27 as the focused evidence for the structured architecture or security review.

---

# Task 9 — Answer the Reflection Questions

## Goal

Reflect on the architecture, Terraform implementation, and Agentic AI workflow. Answer each question briefly in your own words.

## Architecture

### 1. Why did you separate the Web, Application, and Database tiers?

I separated the Web, Application, and Database tiers to improve security, scalability, maintainability, and fault isolation. Each tier has a specific responsibility. The Web Tier handles incoming user requests, the Application Tier processes business logic and API requests, and the Database Tier stores application data.
This separation allows me to apply different security controls, scale components independently, and troubleshoot issues without affecting the entire system.

### 2. Why is the Application Tier private?

I placed the Application Tier in private subnets because it processes sensitive application operations and does not need to be directly accessible from the internet.
Requests should reach the Application Tier through an internal load balancer or an approved internal network path. This reduces the attack surface and prevents unauthorized direct access to backend services.

### 3. Why is MySQL private?

I kept MySQL in private database subnets to protect sensitive information such as user accounts, book records, and reviews.
The database should not have a public IP address or accept direct connections from the internet. Its security group should allow MySQL traffic on port 3306 only from authorized application components.
This follows the principle of least privilege and reduces the risk of unauthorized database access.

### 4. Why are multiple Availability Zones used?

I designed the infrastructure across multiple AWS Availability Zones to improve availability and fault tolerance.
If one Availability Zone experiences an outage, resources in another Availability Zone can continue supporting the application, provided the required failover and routing mechanisms are configured.
Distributing resources across Availability Zones also reduces dependence on a single physical location.



### 5. What is the difference between Multi-AZ/high availability and a read replica?

Multi-AZ and read replicas serve different purposes.
Multi-AZ is primarily designed for high availability and disaster recovery. In an Amazon RDS Multi-AZ DB instance deployment, AWS maintains a standby database in another Availability Zone and can automatically fail over if the primary database becomes unavailable.
A read replica is primarily designed to improve read performance. It maintains a separate copy of database data and can handle read-only queries, reducing the workload on the primary database.
The main difference is that Multi-AZ focuses on availability and failover, while read replicas focus on read scalability. A standard RDS read replica does not automatically replace the primary database during failure.

## Terraform

### 6. How did you divide your Terraform into modules?

I organized my Terraform configuration into reusable modules based on infrastructure responsibilities.
The modules covered networking, security, compute resources, load balancing, and database infrastructure.
The networking module defined the VPC, subnets, and routing components. The security module controlled network access using security groups. The compute module defined application instances, while the load-balancing module handled traffic distribution. The database module defined the managed MySQL infrastructure.

This modular approach made the configuration easier to understand, maintain, validate, and reuse.

### 7. How do the modules communicate through variables and outputs?

Terraform modules communicate through input variables and output values.
A module exposes important resource information through outputs, such as VPC IDs, subnet IDs, security group IDs, and load balancer details.
The root Terraform configuration then passes these outputs as input variables to other modules.
For example, the networking module can output private subnet IDs, which are passed to the compute and database modules. The security module can output security group IDs used by application instances and database resources.

### 8. What did you specifically check in `terraform plan`?

I reviewed the Terraform plan to understand which resources Terraform intended to create, modify, or destroy before deployment.
I specifically checked the VPC and six-subnet layout, public and private subnet placement, route tables, security group rules, compute resources, load balancer configurations, and RDS database settings.
I also checked for unexpected resource deletion, unnecessary public exposure, incorrect dependencies, and changes that could increase infrastructure costs.
The purpose was to identify potential mistakes before allowing Terraform to apply infrastructure changes. A successful plan alone does not prove that the deployed application works.



## Agentic AI

### 9. What was the purpose of `CLAUDE.md`?

I used CLAUDE.md to provide project-specific instructions and context for Claude Code.
The file described the project architecture, Terraform coding standards, security requirements, directory structure, validation expectations, and important operational constraints.
Its purpose was to help Claude understand the project before generating or modifying infrastructure code.
This reduced the need to repeat instructions and encouraged consistent decisions across the project.

### 10. What work did the Terraform Engineer subagent perform?

The Terraform Engineer subagent was responsible for assisting with Terraform infrastructure development.
Its responsibilities included reviewing infrastructure requirements, generating modular Terraform configurations, checking variable and output relationships, identifying resource dependencies, and recommending improvements to the infrastructure code.
It also supported validation and troubleshooting by helping identify configuration errors and suggesting corrections.
I treated its output as proposed infrastructure code that still required review and validation rather than accepting every recommendation automatically.

### 11. What did the Architecture and Security Reviewer identify?

The Architecture and Security Reviewer examined the proposed infrastructure for security weaknesses, architecture risks, and deviations from the intended three-tier design.
Important review areas included public and private subnet isolation, overly permissive security group rules, database exposure, load balancer placement, and high-availability considerations.
The review also highlighted unresolved deployment requirements, including runtime release authorization and necessary deployment inputs such as approved machine images, certificates, and public hostname configuration.
These findings helped distinguish between an infrastructure design that had been reviewed and one that was ready for a production deployment.

### 12. Why did you use Terraform MCP instead of relying only on Claude's existing Terraform knowledge?

I used Terraform MCP to give Claude access to Terraform-related tools and more relevant technical context instead of relying entirely on its pretrained knowledge.
Terraform providers, resource arguments, and best practices can change over time. Using MCP can help Claude retrieve more relevant information and work with supported Terraform tooling.
This improves the development workflow and can reduce the risk of outdated or incorrect configuration recommendations.
However, MCP does not replace independent verification using Terraform commands, provider documentation, and security reviews.

### 13. What was the purpose of your validation hooks?

The validation hooks were intended to introduce automated checks into the Terraform development workflow.
Their purpose was to help detect formatting problems, invalid configurations, and other issues as early as possible.
For example, validation hooks can run commands such as terraform fmt -check and terraform validate after relevant code changes.
This helps maintain code quality and reduces the chance of continuing with incorrect Terraform configurations.
Validation hooks are an additional safeguard, not a replacement for reviewing the Terraform plan or testing deployed resources.

### 14. Describe one real issue Claude helped you troubleshoot.

One issue addressed during the project review was ensuring that the network configuration maintained the correct separation between public and private infrastructure.
The concern was that incorrect routing or security group relationships could unintentionally expose application or database components.
Claude-assisted troubleshooting helped examine the subnet assignments, routing relationships, and security group references and identify the configurations that needed verification.
The recommended approach was to keep internet-facing access limited to the intended entry points and restrict backend and database communication to approved network paths.
This demonstrated how AI assistance can support infrastructure troubleshooting while still requiring Terraform validation and human review.

### 15. Describe one recommendation you reviewed, modified, or rejected instead of accepting blindly.

One important recommendation I evaluated was whether to proceed with infrastructure deployment before all security and runtime requirements were confirmed.
Rather than treating AI-generated Terraform code or a successful validation result as automatic approval to deploy, I considered the unresolved release requirements identified during the architecture review.
I supported keeping deployment authorization separate from code generation and validation until required inputs and security controls could be verified.
This reinforced an important lesson: AI can accelerate infrastructure development, but responsibility for security, cost, correctness, and deployment decisions remains with the engineer.

---

# Task 10 — Publish the Mandatory LinkedIn Post

## Goal

Publish a LinkedIn post describing the capstone, the technical work completed, the Agentic AI workflow, and the lessons learned.

Write the post in your own words, include at least one project image or other proof, and ensure that it can be viewed by the submission reviewer.

## LinkedIn Post URL

https://lnkd.in/p/d8GK8J-E

---

# Submission Instructions

- Complete Tasks 0–10 in sequence.
- Include all Screenshots 1–28 exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Include the selected cloud platform.
- Include the completed architecture diagram.
- Include the modular Terraform project structure.
- Include the working public application URL or public load-balancer DNS.
- Include all required Agentic AI workflow evidence.
- Answer all 15 reflection questions briefly in your own words.
- Include the published LinkedIn post URL.
- Do not expose cloud credentials, database passwords, SSH private keys, JWT secrets, access tokens, account IDs, Terraform state containing sensitive values, or other confidential information.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [x] Selected AWS or Azure
- [x] Added and reviewed the Agentic AI starter files
- [x] Configured `CLAUDE.md`
- [x] Configured the Terraform Engineer subagent
- [x] Configured the Architecture and Security Reviewer subagent
- [x] Connected Terraform MCP
- [x] Configured validation hooks and safety guardrails
- [x] Created the architecture diagram
- [x] Created the six-subnet design
- [x] Configured public Web Tier routing
- [x] Kept the Application Tier private
- [x] Kept the Database Tier private
- [x] Configured tier-specific Security Groups or NSGs
- [x] Restricted backend port `3001`
- [x] Restricted MySQL port `3306` to the Application Tier
- [x] Created the public load balancer
- [x] Created the internal load balancer
- [x] Configured listeners and health checks
- [x] Deployed the Web Tier compute resources
- [x] Deployed the private Application Tier compute resources
- [x] Provisioned private managed MySQL
- [x] Configured Multi-AZ or high availability
- [x] Configured a read replica
- [x] Created the modular Terraform project
- [x] Used variables, outputs, and module dependencies
- [x] Used current Terraform documentation through MCP
- [x] Used hooks for deterministic validation
- [x] Completed `terraform fmt`
- [x] Completed `terraform validate`
- [x] Reviewed `terraform plan`
- [x] Completed the Terraform Engineer review
- [x] Completed the Architecture and Security review
- [x] Applied the infrastructure only after human approval
- [x] Deployed and configured the backend
- [x] Deployed and configured the frontend
- [x] Configured Nginx where required
- [x] Configured the internal backend endpoint
- [x] Configured the public frontend endpoint
- [x] Verified the homepage
- [x] Verified login or authentication
- [x] Verified book data
- [x] Verified review functionality
- [x] Verified the backend API
- [x] Verified database reads and writes
- [x] Verified healthy load-balancer targets
- [x] Included AI-assisted Terraform generation evidence
- [x] Included one architecture or security review
- [x] Included one AI-assisted troubleshooting example
- [x] Completed the final architecture review
- [x] Answered all 15 reflection questions
- [x] Published the mandatory LinkedIn post
- [x] Added the LinkedIn post URL
- [x] Captured all 28 required screenshots
- [x] Confirmed that my full name is visible in the required screenshots
- [x] Checked that no secrets or sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- Book Review App Repository: [https://github.com/pravinmishraaws/book-review-app](https://github.com/pravinmishraaws/book-review-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
