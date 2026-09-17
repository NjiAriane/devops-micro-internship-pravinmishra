# Assignment 7 — AI-Assisted AWS Security and Cost Audit

Part of the DevOps Micro Internship (DMI) with Agentic AI

## Purpose

In this assignment, I built a read-only Bash script that audits AWS resources deployed earlier in the week, including S3, EC2, security groups, RDS, and EBS volumes.

I then connected the audit workflow to Claude Code as a reusable `/aws-audit` skill. The skill analyzes the audit evidence and recommends remediation steps without executing them automatically.

Finally, I identified security findings in my AWS environment, applied remediation manually, and ran the audit again to verify the changes.

---

# Task 1 — Confirm Your AWS Resources and Set Up Your Workspace

## Goal

Confirm that the AWS CLI is authenticated and can identify the AWS resources deployed earlier in the week.

## Evidence

### Screenshot 1 — AWS Resource Listings

![AWS Audit Initial Results](screenshots/01-aws-audit-initial-results.png)

---

### Screenshot 2 — Workspace Setup

![AWS Audit Workspace Setup](screenshots/02-aws-audit-workspace-setup.png)

---

## Notes

### 1. Which resources from this week's earlier assignments did you see in the listings?

The AWS resource listings showed the S3 bucket, running EC2 instances, and the RDS database resources created during the earlier assignments. The RDS listing also showed the Book Review database and its read replica.

### 2. Why must you confirm your resources exist before writing an audit script against them?

Confirming the resources first ensures that the audit script targets real resources in the correct AWS account and region. It also prevents incorrect resource identifiers from being hard-coded into the script and makes the audit results more reliable.

---

# Task 2 — Define Safety Rules in CLAUDE.md

## Goal

Create a `CLAUDE.md` file that defines the audit as a read-only workflow and prevents Claude from automatically executing remediation commands.

## Evidence

### Screenshot 3 — CLAUDE.md Safety Rules

![CLAUDE.md Safety Rules](screenshots/03-claude-md-safety-rules.png)

---

## Notes

### 1. Why should Claude never be given permission to run `revoke-security-group-ingress` itself, even if the fix is obviously correct?

A security-group change can affect access to live AWS resources. A revoke command could remove legitimate access or cause service disruption if the wrong security group or rule is selected. Claude should therefore recommend the command and allow the human administrator to review and execute it manually.

### 2. Which rule prevents Claude from claiming a finding that the report does not support?

The rule stating that Claude must not claim a finding unless the report contains supporting evidence prevents unsupported conclusions. Claude must base its findings on the evidence collected by the audit.

---

# Task 3 — Plan the Audit with Claude Code

## Goal

Use Claude Code to create a read-only audit plan covering five security checks.

## Evidence

### Screenshot 4 — Five-Check Audit Plan

![Claude Code Five-Check Audit Plan](screenshots/04-aws-audit-five-check-plan.png)

---

## Notes

### 1. Which part of this task represents the Gather phase?

The Gather phase is the process of collecting information from AWS using read-only AWS CLI commands. The commands inspect S3 public-access settings, security-group rules, RDS accessibility, and EBS encryption status without changing any resources.

### 2. Did every proposed command start with `describe-`, `get-`, or `list-`? Why does that matter?

Yes. The proposed commands use read-only AWS CLI operations such as `describe-`, `get-`, and `list-`. This matters because these commands retrieve information without modifying AWS resources, keeping the audit safe and read-only.

---

# Task 4 — Build the AWS Audit Script

## Goal

Create a Bash script that performs the five security checks, produces a report, and returns an exit code based on the audit result.

## Evidence

### Screenshot 5 — Audit Script Variables and Checks Array

![AWS Audit Script Variables](screenshots/05-aws-audit-script-top.png)

---

### Screenshot 6 — Audit Check Function

![AWS Audit Check Function](screenshots/06-aws-audit-check-function.png)

---

### Screenshot 7 — Script Syntax and Permissions

![AWS Audit Script Syntax Check](screenshots/07-aws-audit-script-syntax.png)

---

## Notes

### 1. What is stored in the checks array, and how does the loop use it?

The checks array stores the names of the five audit functions:

- `check_s3_public_access`
- `check_ssh_open_to_world`
- `check_mysql_open_to_world`
- `check_rds_public_access`
- `check_ebs_encryption`

The script loops through the array and calls each function. This makes the audit organized and allows all checks to be executed using the same workflow.

### 2. Why does every AWS CLI call in this script use `--query` and `--output text` instead of parsing raw JSON?

`--query` extracts only the AWS information needed by each check, while `--output text` produces simple text that is easier for Bash to evaluate. This avoids unnecessary JSON parsing and makes the script easier to read and maintain.

### 3. Why does the script use different exit codes for HEALTHY, WARN, and FAIL?

Different exit codes allow other tools or automation systems to determine the audit result programmatically.

For example:

- `0` — HEALTHY / all checks passed
- `1` — WARN / warnings were detected
- `2` — FAIL / one or more security checks failed

This makes the audit useful in automation and CI/CD workflows.

---

# Task 5 — Run the Baseline Audit

## Goal

Run the audit against the live AWS environment and record the baseline security state before remediation.

## Evidence

### Screenshot 8 — Baseline Audit Results

![AWS Baseline Audit Results](screenshots/08-aws-audit-baseline-results.png)

---

### Screenshot 9 — Captured Exit Code and Summary

![AWS Audit Exit Code and Summary](screenshots/09-aws-audit-exit-code-summary.png)

---

## Notes

### 1. What is the overall status of your baseline audit?

The baseline audit returned a **WARN** status.

The audit completed successfully, but the results identified an EBS encryption warning that required attention.

### 2. Did any check return FAIL or WARN? If so, which one, and what evidence did it show?

The EBS encryption check returned a **WARN** result. The audit reported that three EBS volumes were not encrypted.

The other checks passed, including:

- S3 public-access protection
- SSH access restriction
- MySQL access restriction
- RDS public accessibility

### 3. If every check passed, what does that tell you about the security posture of your account so far?

This question does not apply to my baseline result because the audit returned a warning. The results showed that most of the checked controls were passing, while the unencrypted EBS volumes remained an area requiring remediation.

---

# Task 6 — Build and Run the /aws-audit Skill

## Goal

Turn the script into a Claude Code skill named `/aws-audit` that runs the script, reads the report, and explains every finding along with its estimated cost or security risk — with tool access restricted so it can never modify the AWS account.

## Evidence

### Screenshot 10 — SKILL.md

![AWS Audit Skill](screenshots/10-aws-audit-skill.png)

---

### Screenshot 11 — /aws-audit Output

![AWS Audit Skill Output](screenshots/11-aws-audit-skill-output.png)

---

## Notes

### 1. Why does this skill have Bash, Read, and Grep, but not Write?

The skill needs Bash to run the read-only audit script, Read to inspect the generated report, and Grep to search for specific findings. Write is excluded so that Claude cannot modify files or make changes to the AWS environment.

### 2. What part is performed by Bash, and what part is performed by Claude?

Bash performs the actual read-only AWS resource checks and generates the audit report. Claude then reads and interprets the report, explains the findings, identifies the security or cost impact, and recommends remediation steps.

### 3. Why is estimating cost/risk impact something the AI adds on top of a plain PASS/FAIL script?

A Bash script can determine whether a technical condition passes or fails, but it does not necessarily explain the practical security or cost impact. Claude adds context by interpreting the findings and explaining why they matter and what remediation could be considered.

---

# Task 7 — Fix a Real Finding and Re-Verify

## Goal

Pick one real finding from the baseline report, apply the fix yourself in a separate terminal, then rerun the script to prove the finding is resolved.

## Evidence

### Screenshot 12 — Security Group Remediation

![SSH Security Group Remediation](screenshots/12-ssh-security-group-remediation.png)

---

### Screenshot 13 — Re-verified Audit

![AWS Audit Final Results](screenshots/13-aws-audit-final-results.png)

---

## Notes

### 1. Which exact finding did you fix, and what command did you run?

I fixed the security-group rule that allowed SSH access from the entire internet (`0.0.0.0/0`). I revoked the unrestricted SSH rule and authorized SSH access using my own IP address.

### 2. Why did you scope the new rule to your own IP address instead of leaving it open to `0.0.0.0/0`?

Restricting SSH access to my own IP address reduces exposure to unauthorized access attempts from the public internet. It follows the principle of least privilege by allowing access only from the required source.

### 3. Did Claude execute the remediation command, or did you? Why does that matter?

I executed the remediation command myself. This matters because the `/aws-audit` skill is designed to be read-only and should never make infrastructure changes automatically. Human review and approval are required before applying a remediation.

### 4. Which phase of the Agentic Loop does the Bash script represent? Which phase does Claude's explanation represent? Which phase is you running the fix?

The Bash audit script represents the **Gather** phase because it collects information from AWS.

Claude's explanation represents the **Reason** phase because it interprets the evidence, identifies risks, and recommends remediation.

Running the fix myself represents the **Act** phase because I manually apply the approved remediation.

The second audit run represents the **Verify** phase because it confirms whether the finding has been resolved.

---

# LinkedIn Post (Required)

## Goal

Create a LinkedIn post including:

- What I built: a read-only AWS audit script and a Claude Code `/aws-audit` skill
- One real finding I caught and fixed in my own account
- What the workflow demonstrated: evidence gathering, AI-assisted cost/risk analysis, human-approved remediation, and reverification
- Screenshot of the finding before the fix
- Screenshot of the same check passing after the fix
- 4–6 lines written in my own words

### Suggested Tags

`#DMIByPravinMishra #AWS #AgenticAI #ClaudeCode #DevOps`

## Evidence

### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://www.linkedin.com/posts/nji-ariane-ruth-494805172_dmibypravinmishra-aws-devops-activity-7506303089994563584-wA1N?utm_source=share&utm_medium=member_desktop&rcm=ACoAACkN5HAB_6uWL_--MIEwRhEZ_BLCaqDxIoo

---

### Screenshot of Published LinkedIn Post

![Published LinkedIn Post](screenshots/LinkedIn-post-ass7.png)

---

# Submission Instructions

Complete all tasks in sequence.

Your submission must include:

- All 13 required task screenshots
- Answers to every **Notes You Must Write** question
- `CLAUDE.md`
- `scripts/aws-audit.sh`
- `.claude/skills/aws-audit/SKILL.md`
- `reports/aws-audit-report.txt` baseline report and the reverified report from Task 7
- GitHub folder or repository URL containing the assignment files
- Your Full Name visible in the required outputs
- LinkedIn post URL
- Screenshot of the published LinkedIn post
- GitHub repository URL

---

# Completion Checklist

- [x] Task 1: AWS resources confirmed and workspace created (Screenshots 1–2)
- [x] Task 2: `CLAUDE.md` created with project context and safety rules (Screenshot 3)
- [x] Task 3: Claude produced a read-only five-check audit plan before any script existed (Screenshot 4)
- [x] Task 4: `aws-audit.sh` built, executable, and passes `bash -n` (Screenshots 5–7)
- [x] Task 5: Baseline audit captured and saved with Full Name visible (Screenshots 8–9)
- [x] Task 6: `/aws-audit` skill loads and runs successfully with no Write permission (Screenshots 10–11)
- [x] Task 7: A real finding was fixed by me and reverified as PASS (Screenshots 12–13)
- [x] Skill never executed a remediation command
- [x] New security group rule is scoped to my own IP, not `0.0.0.0/0`
- [x] All 13 required task screenshots are included
- [x] All "Notes You Must Write" questions are answered in my own words
- [x] No AWS credentials or unblurred account IDs exposed
- [x] LinkedIn post published and URL submitted
- [x] GitHub repository URL included
- [x] All assignment files committed and visible in GitHub

---

# Final Submission

Submit the GitHub repository URL containing all assignment files, screenshots, reports, and output.

### GitHub Repository URL

Paste your GitHub repository URL here:

`Add your GitHub repository URL here`