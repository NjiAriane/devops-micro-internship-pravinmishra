---
name: pr-ready
description: Reviews staged Git changes and drafts a Pull Request.
allowed-tools:
  - Bash
  - Read
  - Grep
disable-model-invocation: true
---

# PR Ready

Review the staged Git changes.

Check for:
- Secrets
- Debug statements
- Mixed unrelated changes
- Missing context

Generate:

1. Risk summary
2. Suggested PR title
3. Suggested PR description

Do not modify files.

Do not commit.

Do not push.

Do not open a Pull Request.
