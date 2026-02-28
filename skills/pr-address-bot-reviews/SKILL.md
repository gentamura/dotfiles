---
name: pr-address-bot-reviews
description: Use this skill to process bot review feedback on a pull request (for example coderabbitai and chatgpt-codex-operator). Invoke when bot comments arrive and the user wants triage, decision making, and implementation of required fixes.
---

# PR Address Bot Reviews

Triage and resolve bot-generated PR feedback with a consistent workflow.

## Supported Sources

- `coderabbitai[bot]`
- `chatgpt-codex-operator`

Add more bot logins when needed.

## Workflow

### 1. Collect Feedback

- Identify the target PR number (from current branch PR or user input).
- Fetch PR review data with `gh`:
  - reviews
  - review comments
  - issue comments
- Filter feedback to supported bot authors.

### 2. Normalize and Group

- Deduplicate repeated suggestions.
- Group by file/path and concern type:
  - correctness/bug risk
  - security
  - performance
  - maintainability/style
  - test/documentation gaps

### 3. Decide Actionability

Classify each item into:

- `must-fix`: clear bug/risk/regression
- `should-fix`: strong improvement with low downside
- `skip-with-reason`: incorrect assumption, out-of-scope, or high-cost low-value
- `needs-user-decision`: product/architecture tradeoff

### 4. Implement Needed Changes

- Apply `must-fix` and agreed `should-fix` items.
- Keep changes scoped to the PR intent.
- Run relevant checks/tests for touched areas.

### 5. Respond on PR

- For fixed items: reply with what changed.
- For skipped items: reply with concise rationale.
- For tradeoffs: ask explicit decision questions.
- Reply in the correct channel:
  - Inline review thread: use `skills/pr-address-bot-reviews/scripts/pr-thread-reply <pr> <comment_id> "<response>"`
  - General PR note: use `gh pr comment`

### 6. Report Back to User

- Summarize by category:
  - fixed
  - skipped (with reason)
  - pending decision
- Provide changed files and verification commands run.

## Decision Heuristics

- Prefer concrete evidence over bot confidence.
- Reject suggestions that conflict with project conventions.
- Reject speculative refactors that increase scope without reducing risk.
- Escalate when the fix changes behavior, API contract, or data model.

## Minimal Command Sequence

```bash
gh pr view <number> --json number,title,body,reviews,comments,files
gh pr view <number> --comments
gh api repos/<owner>/<repo>/pulls/<number>/comments --jq '.[] | [.id,.user.login,.path,.line] | @tsv'
# reply to inline review comment thread
skills/pr-address-bot-reviews/scripts/pr-thread-reply <number> <comment_id> "<response>"
# optional general PR note
gh pr comment <number> --body "<response>"
# implement code changes
git add <files...>
git commit -m "<message>"
git push
```
