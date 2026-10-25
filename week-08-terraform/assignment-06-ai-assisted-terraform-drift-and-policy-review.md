# Assignment 6 — AI-Assisted Terraform Drift and Policy Review

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** Add your full name here  
**GitHub Repository/Folder URL:** Add your GitHub URL here

---

## Purpose

Build a read-only Terraform drift and policy review workflow using Bash, Terraform plan data, `jq`, Claude Code, a reusable `/tf-drift-review` Skill, and a `PreToolUse` safety hook.

The workflow must follow this pattern:

```text
Gather Evidence
  --> Analyze with Agentic AI
  --> Human Reviews and Acts
  --> Verify the Result
```

The `/tf-drift-review` Skill and `tf-drift-check.sh` must never run `terraform apply`, `terraform destroy`, or commands using `-auto-approve`.

---

# Task 1 — Confirm the Clean Baseline and Create the Workspace

## Goal

Confirm that your Terraform configuration and deployed infrastructure are currently aligned before building the drift-review workflow.

## Evidence

### Screenshot 1 — Clean Terraform Plan

Add a screenshot of `terraform plan` showing no pending changes.

![Screenshot 1 — Clean Terraform Plan](screenshots/Screenshot-01-Clean-Terraform-Plan.png)

---

### Screenshot 2 — Assignment Workspace

Add a screenshot of the folder structure showing `AI Assignment/`, `reports/`, and the Terraform project.

![Screenshot 2 — Assignment Workspace](screenshots/Screenshot-02-Assignment-Workspace.png)

## Questions

### 1. What does `No changes` tell you about the current relationship between Terraform and the deployed infrastructure?

Terraform reported that the configuration matched the state it evaluated, with no proposed changes. This is evidence of alignment for that plan and its scope; it does not prove that every resource or every security concern is safe.

### 2. Why is a clean baseline important before introducing a test change?

A clean baseline gives me a known starting point. It helps distinguish the intentional test change from pre-existing differences and makes the before-and-after plans easier to compare.

---

# Task 2 — Create Project Context and Safety Rules in `CLAUDE.md`

## Goal

Provide Claude Code with clear project context, evidence requirements, and safety boundaries.

## Evidence

### Screenshot 3 — Project Context and Safety Rules

Add a screenshot of `CLAUDE.md` open in VS Code showing the Project Overview, Review Workflow, Safety Rules, and Output Rules.

![Screenshot 3 — Project Context and Safety Rules](screenshots/Screenshot-03-Project-Context-and-Safety-Rules.png)


## Questions

### 1. Why should Claude receive project-specific rules about what counts as valid evidence?

Project-specific rules tell Claude which files and reports are trusted, how recent evidence must be, what the checks cover, and what must not be inferred. This reduces unsupported claims and keeps the review within the assignment's safety boundaries.

### 2. Why must the human remain responsible for running `terraform apply`?

terraform apply can change real infrastructure and cause downtime, exposure, or cost. A human must inspect the plan, understand the impact, and explicitly authorize any change rather than delegating that decision to an AI agent.

### 3. Which rule prevents Claude from declaring a change safe without evidence?

The rule requiring complete, fresh, source-backed evidence—and prohibiting safety conclusions from stale, missing, synthetic, or incomplete reports—prevents Claude from declaring a change safe without evidence.

---

# Task 3 — Build the Terraform Drift and Policy Check Script

## Goal

Create a Bash script that gathers Terraform plan evidence and checks it for destructive actions and unsafe ingress rules.

## Evidence

### Screenshot 4 — Script Variables and Checks Array

Add a screenshot of the top section of `tf-drift-check.sh` showing the variables and `checks` array.

![Screenshot 4 — Script Variables and Checks Array](screenshots/Screenshot-04-Script-Variables-and-Checks-Array.png)


---

### Screenshot 5 — Destructive-Action and Open-Ingress Checks

Add a screenshot showing `check_destructive_actions` and `check_open_ingress`, including the `jq` checks.

![Screenshot 5 — Destructive-Action and Open-Ingress Checks](screenshots/Screenshot-05-Destructive-Action-and-Open-Ingress-Checks.png)

---

### Screenshot 6 — Script Validation and Permissions

Add a screenshot showing successful `bash -n` and `ls -l` output.

![Screenshot 6 — Script Validation and Permissions](screenshots/Screenshot-06-Script-Validation-and-Permissions.png)

## Questions

### 1. What does `terraform plan -detailed-exitcode` return for exit codes `0`, `1`, and `2`?

Exit code 0 means the plan completed with no changes; 1 means Terraform encountered an error; 2 means the plan completed successfully and contains changes.

### 2. Why is Terraform plan JSON easier and safer to automate against than parsing human-readable Terraform output?

Terraform plan JSON provides structured fields such as resource actions, before/after values, and security-group rules. jq can inspect those fields consistently without relying on fragile text matching that can break when human-readable output changes.

### 3. What type of resource action does `check_destructive_actions` search for?

It searches planned resource actions for destructive actions, especially delete actions, including replacement actions that include deletion.

### 4. Why does finding a `delete` action also help detect replacements?

A replacement commonly consists of a delete and a create action, so looking for delete helps flag replacements as potentially destructive rather than treating them as harmless updates.

### 5. Why must this script never run `terraform apply`?

The script is an evidence-gathering and review tool, not a deployment tool. Running apply would cross the safety boundary and could mutate real infrastructure without an independently reviewed and authorized decision.

---

# Task 4 — Run the Script Against the Clean Baseline

## Goal

Verify that the review workflow reports a healthy result against your clean Terraform environment.

## Evidence

### Screenshot 7 — Healthy Baseline Report

Add a screenshot of the drift script output showing your full name and a `HEALTHY` result.

![Screenshot 7 — Healthy Baseline Report](screenshots/Screenshot-07-Healthy-Baseline-Report.png)

---

### Screenshot 8 — Baseline Script Exit Code

Add a screenshot showing the captured script exit code `0`.

![Screenshot 8 — Baseline Script Exit Code](screenshots/Screenshot-08-Baseline-Script-Exit-Code.png)

## Questions

### 1. What is the Overall Status of your baseline?

The baseline report showed LIVE / HEALTHY, with Terraform detailed exit code 0 and zero destructive actions, unsafe ingress findings, unknown findings, non-no-op changes, output changes, and refresh-drift entries within the check's supported scope.

### 2. Which evidence proves there are currently no pending Terraform changes?

The recorded plan output says, No changes. Your infrastructure matches the configuration. The detailed exit code was 0, and the baseline report recorded zero non-no-op changes and zero refresh-drift entries.

### 3. Was `reports/tfplan.json` created? Explain why or why not.

The raw plan was written to a restricted temporary workspace and was not intended to be saved as reports/tfplan.json. The report retained summarized evidence while raw plan data and sensitive details were kept out of ordinary reports.

---

# Task 5 — Create and Run the `/tf-drift-review` Claude Code Skill

## Goal

Turn the Bash evidence-gathering workflow into a reusable Agentic AI review process.

## Evidence

### Screenshot 9 — `/tf-drift-review` Skill Configuration

Add a screenshot of `SKILL.md` showing the frontmatter, allowed tools, and safety rules.

![Screenshot 9 — TF Drift Review Skill Configuration](screenshots/Screenshot-09-TF-Drift-Review-Skill-Configuration.png)

---

### Screenshot 10 — Clean Agentic AI Review

Add a screenshot of `/tf-drift-review` showing the clean `HEALTHY` result.

![Screenshot 10 — Clean Agentic AI Review](screenshots/Screenshot-10-Clean-Agentic-AI-Review.png)

## Questions

### 1. Why does this Skill have `Bash`, `Read`, and `Grep`, but not `Write`?

Bash, Read, and Grep allow the Skill to run the approved checker and inspect project evidence. Omitting Write reduces the chance that the review modifies configuration, reports, or other project files; the Skill is intended to analyze, not change infrastructure.

### 2. Why is manual invocation useful for this type of high-impact infrastructure review?

Manual invocation makes the review deliberate and tied to a specific point in the workflow. It helps ensure the operator knows which evidence is being reviewed and does not treat the review as automatic permission to change infrastructure.

### 3. Which part of the workflow is deterministic Bash automation?

The Bash script deterministically runs the permitted Terraform plan/checking steps, parses plan JSON with jq, counts policy findings, records exit codes and hashes, and writes the bounded report.

### 4. Which part requires Claude's reasoning?

Claude's reasoning is used to interpret the reported findings in project context, explain risk and uncertainty, distinguish a configuration proposal from actual drift, and recommend a cautious next step without authorizing mutation.

### 5. Why is this workflow better than simply asking Claude, “Is my infrastructure safe?”

It relies on current, structured plan evidence and repeatable policy checks, then asks Claude to interpret the results under explicit rules. A general chatbot question may lack fresh evidence, miss scope limitations, or make unsupported assumptions.

---

# Task 6 — Introduce a Controlled Difference and Detect It

## Goal

Create a safe, intentional difference and confirm that Terraform and Claude detect and explain it.

## Evidence

### Screenshot 11 — Controlled Difference

Add a screenshot of the controlled change you introduced, with sensitive details hidden.

![Screenshot 11 — Controlled Difference](screenshots/Screenshot-11-Controlled-Difference.png)

---

### Screenshot 12 — Detected Difference and Risk Assessment

Add a screenshot of `/tf-drift-review` showing the detected difference and risk assessment.

![Screenshot 12 — Detected Difference and Risk Assessment](screenshots/Screenshot-12-Detected-Difference-and-Risk-Assessment.png)

---

### Screenshot 13 — Detected Drift Report

Add a screenshot of `drift-detected-report.txt` showing your full name and the `WARN` or `FAIL` result.

![Screenshot 13 — Detected Drift Report](screenshots/Screenshot-13-Detected-Drift-Report.png)

## Questions

### 1. What change did you introduce?

I supplied a temporary test_public_ssh=true variable only to the planning process. It proposed TCP port 22 from 0.0.0.0/0 on an isolated, unattached security group; it was a controlled configuration proposal and was never applied.

### 2. Was it true infrastructure drift or a Terraform configuration change?

It was a Terraform configuration change proposal, not true out-of-band infrastructure drift. The proposal was supplied to a planning process and the security group was unattached; the deployed baseline remained closed


### 3. What Terraform plan evidence proves that a change is pending?

The plan completed with detailed exit code 2, and the plan JSON showed one non-no-op resource change. The policy report recorded one unsafe public-ingress finding and identified the proposed public SSH rule.

### 4. Was the action an update, deletion, replacement, or security-rule change?

It was a security-rule change: an ingress rule proposing TCP/22 from 0.0.0.0/0. It was an unapplied proposal on an unattached security group, not a deployed change.

### 5. What did Claude recommend?

Claude recommended not applying the configuration, identified the public SSH rule as unsafe, and left the decision pending human review. The human resolution was to reject public SSH and retain empty ingress and egress.

### 6. Why should you review the recommendation before taking action?

Terraform plans and AI recommendations can be incomplete or misinterpreted, and public access can expose systems. Reviewing the evidence confirms the affected resource, whether the change is actually deployed, its scope, and whether the proposed action is appropriate.

---

# Task 7 — Add a `PreToolUse` Hook to Block Unsafe Apply Attempts

## Goal

Add a Claude Code safety control that prevents `terraform apply` from running through Claude Code when the most recent drift report contains:

```text
Overall Status: FAIL
```

## Evidence

### Screenshot 14 — `PreToolUse` Safety Hook

Add a screenshot of `.claude/settings.json` showing the `PreToolUse` safety hook.

![Screenshot 14 — PreToolUse Safety Hook](screenshots/Screenshot-14-PreToolUse-Safety-Hook.png)


---

### Screenshot 15 — Blocked Apply Attempt

Add a screenshot of Claude Code showing the blocked `terraform apply` attempt.

![Screenshot 15 — Blocked Apply Attempt](screenshots/Screenshot-15-Blocked-Apply-Attempt.png)

## Questions

### 1. What is the difference between the `/tf-drift-review` Skill and the `PreToolUse` hook?

The /tf-drift-review Skill reads and analyzes evidence and explains findings. The PreToolUse hook is a deterministic guard that checks a tool request before execution and can block disallowed commands based on the safety policy and current report.

### 2. Which component performs analysis?

The /tf-drift-review Skill and Claude's reasoning perform the analysis of Terraform evidence and explain the risk.

### 3. Which component enforces the safety gate?

The PreToolUse hook enforces the safety gate by rejecting a disallowed terraform apply request when the report is FAIL.

### 4. Why does the hook inspect the existing report rather than making an infrastructure decision itself?

The report contains the checker’s structured findings; the hook should enforce a predefined rule, not invent a risk assessment. Human review remains responsible for deciding whether and how to resolve the finding.

### 5. Why is a deterministic guard useful for high-impact commands?

A deterministic guard can block dangerous commands consistently before they run, reducing dependence on the model correctly remembering or interpreting every safety instruction.

---

# Task 8 — Resolve the Difference and Verify the Final State

## Goal

Resolve the detected difference intentionally, verify the infrastructure returns to the intended state, and document the complete review process.

## Evidence

### Screenshot 16 — Human-Reviewed Resolution

Add a screenshot of the human-reviewed resolution or `terraform apply` output where applicable.

![Screenshot 16 — Human-Reviewed Resolution](screenshots/Screenshot-16-Human-Reviewed-Resolution.png)

---

### Screenshot 17 — Final Healthy Review

Add a screenshot of the final `/tf-drift-review` showing `HEALTHY`.

![Screenshot 17 — Final Healthy Review](screenshots/Screenshot-17-Final-Healthy-Review.png)

---

### Screenshot 18 — Saved Reports

Add a screenshot of `ls -lah reports` showing both:

- `drift-detected-report.txt`
- `resolved-report.txt`

![Screenshot 18 — Saved Reports](screenshots/Screenshot-18-Saved-Reports.png)

---

### Screenshot 19 — Drift Review Summary

Add a screenshot of `drift-review-summary.md` showing all required sections and your full name.

![Screenshot 19 — Drift Review Summary](screenshots/Screenshot-19-Drift-Review-Summary.png)

## Terraform Drift Review Summary

### 1. Change Introduced

Explain the controlled change you introduced.

State whether it was:

- True infrastructure drift, or
- A Terraform configuration change

The controlled difference was a temporary planning input, test_public_ssh=true, proposing TCP/22 from 0.0.0.0/0 on an unattached security group. It was a Terraform configuration proposal, not out-of-band drift, and it was never applied.

### 2. Evidence Collected

Describe the Terraform plan evidence and affected resource.

The baseline plan returned no changes. The later proposal plan returned detailed exit code 2, one non-no-op resource change, one unsafe public-ingress finding, zero destructive actions, and zero refresh-drift entries.

### 3. Risk Assessment

Explain the risk identified by the Bash check and Claude Code.

The Bash checker marked the proposal FAIL because it detected unsafe public SSH ingress. Claude's risk review agreed that the proposal must not be applied. The finding was limited to the reviewed plan and policy scope.

### 4. Human-Approved Action

Explain the action you reviewed and executed manually.

After reviewing the finding, the human decision was to reject public SSH and retain empty ingress and egress. No persistent override was retained, and no manual human Terraform execution is claimed.

### 5. Verification

Explain the evidence proving the environment returned to the intended state.

Fresh post-decision plans returned no-op/exit code 0. The final checker reported LIVE / HEALTHY with zero findings, changes, and drift counts. Cleanup was separately verified and the isolated lab was deleted.

### 6. Safety Decision

Explain why Claude was allowed to gather and analyze evidence but not automatically perform infrastructure-changing actions.

Claude was allowed to gather and interpret evidence, but the PreToolUse hook blocked an actual apply request when the report was FAIL. Infrastructure-changing operations required a separate human decision and authorization.

### 7. Agentic Loop Mapping

Explain how your workflow followed:

```text
Gather --> Analyze --> Human Act --> Verify
```

Write your answer here.

## Questions

### 1. What action did you execute to resolve the difference?

The human-reviewed resolution was to reject the public-SSH proposal and retain closed ingress/egress. The proposal was never applied, so no infrastructure rollback was required; the final isolated lab was later cleaned up separately.

### 2. Did you review `terraform plan` before taking action?

Yes. The plan was reviewed before any resolution decision. The proposal plan showed a pending change and public TCP/22 ingress; the decision was to reject it rather than apply it.

### 3. What evidence proves the environment is now aligned?

The post-decision plans returned no-op/exit code 0, and the final checker reported LIVE / HEALTHY with zero findings, changes, and drift counts. Cleanup evidence also confirmed the isolated lab resources were removed.

### 4. Why is a second drift review required after the fix?

A second review confirms that the intended resolution took effect, no unexpected changes remain, and the earlier warning is not being mistaken for the current state. It uses fresh evidence rather than relying on an old report.

### 5. What could go wrong if an AI agent automatically applied every detected Terraform change?

An agent might expose services publicly, delete or replace critical resources, cause downtime, incur unexpected cost, or apply a change based on stale or incomplete evidence. A plan and policy finding should be reviewed and authorized before mutation.

### 6. In one sentence, explain the difference between asking an AI chatbot “Is my infrastructure okay?” and using this evidence-based Agentic AI workflow.

A chatbot answer may be based on assumptions, whereas an evidence-based Agentic AI workflow checks fresh Terraform data, applies deterministic policy checks, explains the bounded findings, requires a human decision, and verifies the result.
---

# LinkedIn Post — Mandatory

## Goal

Publish a LinkedIn post in your own words describing:

- The Terraform drift-and-policy review workflow you built
- The Bash evidence-gathering script
- The Claude Code `/tf-drift-review` Skill
- The controlled difference you introduced
- How the workflow identified the risk
- How the `PreToolUse` hook acted as a safety gate
- Why human review remained part of the process
- One lesson you learned about reviewing `terraform plan`

Include a screenshot of the detected change and a screenshot of the final `HEALTHY` review in your post.

Suggested tags:

```text
#DMIByPravinMishra #Terraform #AgenticAI #ClaudeCode #DevOps
```

## LinkedIn Evidence

### LinkedIn Post URL

https://lnkd.in/p/dt_f4iNH

### Published LinkedIn Post Screenshot — Mandatory

![LinkedIn Published Post](screenshots/Screenshot-22-LinkedIn-Published-Post.png)

---

# Required Assignment Files

Confirm that the following files are included in your GitHub repository:

- `CLAUDE.md`
- `AI Assignment/tf-drift-check.sh`
- `.claude/skills/tf-drift-review/SKILL.md`
- `.claude/settings.json` containing the safety hook
- `reports/drift-detected-report.txt`
- `reports/resolved-report.txt`
- `drift-review-summary.md`

---

# Submission Instructions

- Complete Tasks 1–8 in sequence.
- Include Screenshots 1–19 exactly as specified.
- Answer every question under Tasks 1–8 in your own words.
- Complete all seven sections of the Terraform Drift Review Summary.
- Include the GitHub repository/folder URL containing the assignment files.
- Include your full name in the required reports and screenshots.
- Include the LinkedIn post URL and a screenshot of the published LinkedIn post.
- Do not expose access keys, passwords, tokens, account IDs, private keys, Terraform secrets, or other sensitive information.
- Review all screenshots carefully and hide or redact sensitive details where necessary.

---

# Completion Checklist

- [ ] Confirmed a clean Terraform baseline
- [ ] Created the required assignment workspace
- [ ] Created or updated `CLAUDE.md`
- [ ] Added project context and safety rules
- [ ] Created `tf-drift-check.sh`
- [ ] Added my full name to the report
- [ ] Validated the Bash script
- [ ] Made the script executable
- [ ] Used `terraform plan -detailed-exitcode`
- [ ] Used Terraform plan JSON
- [ ] Used `jq` to inspect destructive actions
- [ ] Used `jq` to inspect unsafe ingress
- [ ] Confirmed the baseline returns `HEALTHY`
- [ ] Created `/tf-drift-review`
- [ ] Restricted the Skill to appropriate tools
- [ ] Confirmed the Skill remains read-only
- [ ] Confirmed the Skill never runs `terraform apply`
- [ ] Confirmed the Skill never runs `terraform destroy`
- [ ] Introduced a controlled detectable difference
- [ ] Correctly identified whether it was true drift or a configuration change
- [ ] Saved `drift-detected-report.txt`
- [ ] Added the `PreToolUse` safety hook
- [ ] Verified the hook blocks `terraform apply` when the report is `FAIL`
- [ ] Reviewed the Terraform evidence before resolving the change
- [ ] Performed any infrastructure-changing action manually
- [ ] Ran the drift review again after resolution
- [ ] Confirmed the final status is `HEALTHY`
- [ ] Saved `resolved-report.txt`
- [ ] Completed `drift-review-summary.md`
- [ ] Mapped the workflow to `Gather --> Analyze --> Human Act --> Verify`
- [ ] Included all 19 numbered screenshots
- [ ] Answered all required questions
- [ ] Published the required LinkedIn post
- [ ] Added the LinkedIn post URL and screenshot
- [ ] Included the GitHub repository/folder URL
- [ ] Confirmed that no sensitive information is exposed

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
