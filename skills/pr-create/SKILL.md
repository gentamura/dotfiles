---
name: pr-create
description: Use this skill to create a pull request from current local changes. Invoke when the user asks to create a branch, commit, push, and open a PR.
---

# PR Create

Create a pull request from local changes with consistent, low-friction steps.

## Workflow

### 1. Confirm Current State

- Check current branch and working tree status.
- If there are no changes and no new commits to publish, report and stop.

### 2. Branch Strategy

- If user requests a new branch, create and switch to it from the current branch.
- If user says to continue on current branch, keep it.

### 3. Commit Changes

- Review changed files quickly for scope sanity.
- Stage only relevant files.
- Write a clear Conventional Commit-style message when possible.
- Commit.

### 4. Push Branch

- Push with upstream tracking when needed.

### 5. Open PR

- Create PR with `gh pr create`.
- Use explicit `--base` and `--head` when known.
- Include concise summary and verification notes in PR body.
- After PR creation, open it in the browser with `gh pr view --web`.

### 6. Report Back

- Return branch name, commit hash, and PR URL.
- Mention anything skipped (for example, tests not run).

## Safety Checks

- Do not include unrelated files in commit.
- Do not use destructive git commands unless explicitly requested.
- If branch name, base branch, or PR title is ambiguous, ask the user.

## Minimal Command Sequence

```bash
git status --short
git rev-parse --abbrev-ref HEAD
git checkout -b <branch-name>   # only when requested
git add <files...>
git commit -m "<message>"
git push -u origin <branch-name>
gh pr create --base <base> --head <branch-name> --title "<title>" --body "<summary>"
gh pr view --web
```
