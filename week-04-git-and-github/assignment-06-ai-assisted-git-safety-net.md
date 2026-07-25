# Assignment 6 — Building an AI-Assisted Git Safety Net (PR Ready Check)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In Week 2 you built Claude Code hooks that block a dangerous action *before* it happens (`PreToolUse`), and a restricted skill that could look but not touch (`allowed-tools` without `Write`). In this assignment you will discover that Git has the exact same idea, decades older: a **pre-commit hook** that blocks a commit before it's created.

You will build both halves of a real "PR Ready" workflow:

1. A **Git hook that follows fixed rules** — scans staged changes for hardcoded secrets and oversized files and refuses the commit. No AI involved, no guessing, just a rule that gives the same answer every time.
2. A **restricted Claude Code skill** (`/pr-ready`) that reads your staged diff and drafts a Pull Request title, description, and a short list of things worth a second look — the kind of judgment a fixed rule can't make (mixed changes, missing context, unclear intent). The skill never commits, pushes, or opens the PR. You do that yourself, using its draft as a starting point.

This mirrors the Agentic Loop from Week 3's Linux triage assignment: **Gather → Analyze → Human Act → Verify**. The hook and the skill both gather and analyze; only you act.

---

# Task 0 — Confirm Your Fork and Create a Feature Branch

## Goal

Confirm you are working in your own fork, then create a dedicated branch for this assignment.

### Evidence

#### Screenshot 1 — Output of git remote -v and git branch showing the new branch

![Screenshot 1](screenshots/w4a6-screenshot1.png)

---

### Notes

**1. Why create a dedicated branch instead of doing this work on main?**

A dedicated branch keeps assignment changes isolated from the main branch. It allows me to experiment, test changes, and review my work before merging. This prevents unfinished or risky changes from affecting the stable main branch.

---

# Task 1 — Stage a Change With Realistic Risk

## Goal

On your own fork of this repository (the one you've been submitting your DMI work in since onboarding), create a new branch and stage a change that a real reviewer should catch: a hardcoded-looking secret and a leftover debug statement.

### Evidence

#### Screenshot 1 — Output of  `git status` showing the staged file on feature/ai-pr-ready

![Screenshot 1](screenshots/w4a6-screenshot1.png)

---

### Notes

**1. Why does this assignment use an obviously fake key instead of a real one?**

The fake key demonstrates how secret detection tools work without exposing real credentials. Using a real key would create a security risk because anyone with access to the repository could potentially misuse it.

---

# Task 2 — Write a Real Git Pre-Commit Hook

## Goal

Create a tracked, shareable pre-commit hook that blocks a commit containing secret-like patterns or files over 1MB.

### Evidence

#### Screenshot 2 — `hooks/pre-commit` open in VS Code showing the full script

![Screenshot 1](screenshots/w4a6-screenshot2.png)

---

#### Screenshot 3 — Output of `git config core.hooksPath` confirming it points to `hooks`

![Screenshot 1](screenshots/w4a6-screenshot3.png)

---

### Notes

**1. Why is `hooks/pre-commit` tracked in the repo instead of living only in `.git/hooks/`?**

Tracking the hook in the repository allows all team members to use the same security checks. The .git/hooks/ directory is local to each developer and is not shared when the repository is cloned.

---

**2. Compare this to `PreToolUse` from Week 2 Assignment 6. What does each one intercept, and what do they have in common?**

Both intercept actions before they happen. The Git pre-commit hook intercepts commits before they are created, while the Claude Code PreToolUse hook intercepts tool actions before execution. They both act as safety gates that prevent unsafe operations.

---

# Task 3 — Prove the Hook Blocks the Risky Commit

## Goal

Attempt to commit the staged file from Task 1 and show the hook rejecting it.

### Evidence

#### Screenshot 4 — Terminal showing `git commit` rejected with the hook's "BLOCKED" message naming the exact file

![Screenshot 1](screenshots/w4a6-screenshot4.png)

---

### Notes

**1. Which line in `hooks/pre-commit` matched your fake key, and why did it match?**

The line containing AKIA matched the fake AWS key pattern. The hook detected it because AWS access keys commonly start with the AKIA prefix, which is a known pattern used for identifying possible credentials.

---

**2. Could this hook have caught a poorly-named variable that stores a secret without the `AKIA` prefix? What does that tell you about the limits of a fixed rule like this?**

No. A fixed rule can only detect patterns it has been programmed to recognize. If a secret uses a different format or naming style, the hook may miss it. This shows that rule-based security checks are useful but have limitations.

---

# Task 4 — Build the `/pr-ready` Skill

## Goal

Create a manually invoked Claude Code skill that reads your staged changes and produces a PR-readiness report and a draft PR description — without writing, committing, or pushing anything itself.

### Evidence

#### Screenshot 5 — `SKILL.md` frontmatter showing `allowed-tools: Bash, Read, Grep` (no `Write`) and `disable-model-invocation: true`

![Screenshot 1](screenshots/w4a6-screenshot5.png)

---

#### Screenshot 6 — `/pr-ready` output while the risky file is still staged, showing it flagged the secret and/or debug statement


![Screenshot 1](screenshots/w4a6-screenshot6.png)

---

### Notes

**1. Why does `/pr-ready` have `Bash` and `Read` but not `Write`?**

The /pr-ready skill is designed to inspect and analyze staged changes without modifying the repository. Bash, Read, and Grep allow it to gather information safely, while removing Write prevents accidental changes, commits, or pushes.

---

**2. The pre-commit hook and `/pr-ready` both looked at the same staged diff. Did they flag the same things? What did one catch that the other didn't?**

Both detected the hardcoded AWS-style key and debug statement. However, /pr-ready provided additional context by explaining risks, suggesting improvements, and generating a possible PR title and description. The pre-commit hook only followed fixed rules and blocked the commit.

---

# Task 5 — Fix the Issues and Re-Verify

## Goal

Remove the secret and debug statement, then prove both gates now pass clean.

### Evidence

#### Screenshot 7 — `git commit` succeeding after the fix (no BLOCKED message)

![Screenshot 1](screenshots/w4a6-screenshot7.png)

---

#### Screenshot 8 — Second `/pr-ready` run showing a clean risk report and a drafted PR title + description

![Screenshot 1](screenshots/w4a6-screenshot8.png)

---

### Notes

**1. What exactly did you change to satisfy the pre-commit hook?**

I removed the fake AWS key and the debug statement from scripts/notify.sh. After removing those risky patterns, the pre-commit hook allowed the commit to proceed successfully.

---

# Task 6 — Push and Open a Pull Request Using the AI Draft

## Goal

Push your branch and open a real Pull Request, using `/pr-ready`'s drafted title and description as your starting point — read it critically and edit before you use it.

**Important:** Open this Pull Request with base repository set to **your own fork** — not the shared upstream `pravinmishraaws/devops-micro-internship-pravinmishra` repository. This assignment's hook and skill files are your own practice work, not a change meant for the shared class repo.

### Evidence

#### Screenshot 9 — Your Pull Request showing the base repository is your own fork, plus the title and description, with the `/pr-ready` draft visible for comparison (paste it in the PR conversation or your notes below)

![Screenshot 1](screenshots/w4a6-screenshot9.png)

---

#### PR Link
https://github.com/your-username/devops-micro-internship-pravinmishra/pull/1
---

### Notes

**1. What, if anything, did you edit in the AI's drafted PR description before using it? Why?**

I reviewed the AI-generated PR description and made small edits to ensure it accurately reflected the changes I made. I adjusted some wording, added details about the pre-commit hook and /pr-ready skill, and removed any statements that were not directly verified. This helped make the PR description more accurate and easier for reviewers to understand.

---

**2. If you had blindly copy-pasted the AI's draft without reading it, what could go wrong?**

If I copied the AI draft without reviewing it, it could contain incorrect information, missing details, or claims about changes that were not actually made. The PR description might mislead reviewers, so human review is necessary before using AI-generated content.

---

**3. Why does this PR need to target your own fork instead of the shared upstream repository?**

This PR targets my own fork because the assignment work, including the Git hook and Claude Code skill, belongs to my personal practice repository. Creating a PR against the shared upstream repository could submit changes directly to the main class repository, which is not intended for this assignment.

---

# Task 7 — Map the Workflow to the Agentic Loop

## Goal

Explain this assignment's workflow using the same Gather → Analyze → Human Act → Verify structure from Week 3.

### Notes

**1. Which step(s) represent Gather?**

The Gather phase includes collecting information from the staged Git changes. The pre-commit hook gathers the staged files and scans them for secrets or oversized files. The /pr-ready skill also gathers information by reading the staged diff.
---

**2. Which step(s) represent Analyze?**

The Analyze phase happens when the pre-commit hook checks the staged changes against fixed rules and when /pr-ready reviews the changes to identify risks, missing context, and suggest a PR title and description.

---

**3. Which step is Human Act, and why must a human — not Claude — run `git commit`, `git push`, and open the PR?**


The Human Act phase is when I review the results, fix issues, commit the changes, push the branch, and open the Pull Request. A human must perform these actions because they require judgment, ownership, and approval. Claude can assist with analysis, but it should not make decisions or publish changes automatically.

---

**4. Which step is Verify?**

The Verify phase happens when I confirm that the commit succeeds after fixing issues, run /pr-ready again to ensure there are no remaining risks, and review the final Pull Request before submission.

---

**5. In one or two sentences: why do you need *both* the fixed-rule pre-commit hook and the AI skill? Isn't one enough?**

Both tools are needed because they solve different problems. The pre-commit hook provides consistent automated protection against known risks like secrets, while the AI skill provides deeper review and context-based suggestions that fixed rules cannot understand.

---

# Task 8 — LinkedIn Post

## Goal

Publish a LinkedIn post summarizing what you built and what you learned about combining fixed-rule safety checks with AI-assisted review.

### Evidence

#### LinkedIn Post URL

https://www.linkedin.com/posts/nji-ariane-ruth-494805172_devops-git-github-share-7486566165775900672-UDL8/?utm_source=share&utm_medium=member_desktop&rcm=ACoAACkN5HAB_6uWL_--MIEwRhEZ_BLCaqDxIoo

---

## Key Learnings

Add 3-5 bullet points on what you learned this week.

-Learned how Git pre-commit hooks can automatically block risky changes before they enter the repository, improving code security.
-- Learned how to create a restricted Claude Code skill using specific permissions (`allowed-tools`) to safely analyze changes without modifying files.
-Improved my understanding of the Agentic Loop: Gather → Analyze → Human Act → Verify, and how it applies to real DevOps processes.

---

# Submission Instructions

- Ensure `hooks/pre-commit` and `.claude/skills/pr-ready/SKILL.md` are committed to your GitHub repository
- Add all required screenshots to your submission
- All written answers must be in your own words
- Do not use a real secret or credential anywhere in your submission — the fake key in Task 1 is intentional and must stay clearly fake
- Open your Pull Request against your own fork, not the shared upstream repository
- Push your final changes to your forked repository
- Include your PR link and LinkedIn post URL

---

## GitHub Repository URL

Paste your forked repository URL here:

https://github.com/NjiAriane/devops-micro-internship-pravinmishra.git

---

# Completion Checklist

- [x] Branch `feature/ai-pr-ready` created with a staged file containing a fake secret and a debug statement
- [x] `hooks/pre-commit` created and tracked in the repo (not only in `.git/hooks/`)
- [x] `core.hooksPath` configured to point at `hooks/`
- [x] Pre-commit hook shown blocking the risky commit
- [x] `.claude/skills/pr-ready/SKILL.md` created with correct `allowed-tools` (no `Write`) and `disable-model-invocation: true`
- [x] `/pr-ready` run against the risky diff and shown flagging issues
- [x] Risky file fixed; `git commit` succeeds cleanly
- [x] `/pr-ready` re-run showing a clean report and drafted PR title/description
- [x] Pull Request opened using the AI draft as a starting point, with your own fork as the base repository (not upstream), PR link included
- [x] Agentic Loop mapping (Task 7) completed in your own words
- [x] LinkedIn post published and URL submitted
- [x] All required screenshots added
- [x] GitHub repository URL provided

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://pravinmishra.com/dmi  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
