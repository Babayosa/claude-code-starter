---
name: commit
description: "Create a git commit with an auto-drafted message. Use when the user says 'commit', 'commit my changes', 'save my work', or invokes /commit."
argument-hint: "[optional commit message override]"
user-invocable: true
allowed-tools: Bash, Read, Write, Glob, Grep, AskUserQuestion
---

# Git Commit

Create a well-crafted git commit from the current working tree changes.

## Workflow

### Step 1: Inspect Changes

Run these three commands in parallel using the Bash tool:

1. `git status -s` — see all modified/untracked files (never use `-uall`)
2. `git diff --stat && git diff --staged --stat` — see scope of staged and unstaged changes
3. `git log --oneline -5` — see recent commit message style

### Step 2: Analyze and Draft Message

Look at the actual diff content to understand what changed:

- Run `git diff` and `git diff --staged` to read the changes (use `--stat` first, then targeted diffs for large changesets)
- Determine the nature: new feature, enhancement, bug fix, refactor, test, docs, chore
- Draft a commit message following the repository's existing style (from Step 1's git log)

**Message format:**
- Line 1: concise summary (imperative mood, under 72 chars) — focus on "why" not "what"
- Line 3+: brief body if the change is non-trivial (what and why, not how)
- Final line: `Co-Authored-By: Claude <noreply@anthropic.com>`

**If the user provided an argument**, use it as the commit message summary (Line 1) instead of drafting one. Still add the co-author line.

### Step 3: Stage Files

- If there are already staged files and no unstaged changes, use what's staged
- Otherwise, stage specific files by name — prefer explicit `git add file1 file2` over `git add -A`
- NEVER stage files that look like secrets: `.env`, `credentials.json`, `*.key`, `*.pem`, etc. Warn the user if these exist
- If unsure what to stage, ask the user with AskUserQuestion

### Step 4: Commit

**IMPORTANT: Always use the file-based message approach to avoid shell escaping issues.**

1. Write the commit message to a temporary file using the Write tool:
   - Path: `/private/tmp/claude-commit-msg.txt`
2. Run: `git commit -F /private/tmp/claude-commit-msg.txt`
3. Run: `trash /private/tmp/claude-commit-msg.txt`

Never use heredocs or multiline `-m` arguments — they trigger safety guards.

### Step 5: Verify

Run `git status -s` to confirm the working tree is clean (or only has intentionally unstaged files).

Show the user the commit hash and summary.

## Rules

- NEVER amend existing commits unless the user explicitly says "amend"
- NEVER push unless the user explicitly asks
- NEVER use `--no-verify` or skip hooks
- NEVER use `-i` (interactive) flags
- NEVER update git config
- If a pre-commit hook fails, fix the issue and create a NEW commit (do not amend)
- If there are no changes to commit, say so and stop
