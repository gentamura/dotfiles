# Done — Session Summary

Summarize this session and save it to the Obsidian vault.

## Steps

### 1. Collect metadata

Run the following commands:

```bash
date +%Y-%m-%d
date +%H%M%S
git branch --show-current 2>/dev/null || echo "no-branch"
basename "$PWD"

# Detect agent and get session ID
if [ -n "$CLAUDECODE" ]; then
  echo "agent=claude-code"
  # Get Claude Code session ID from history
  SESSION_ID=$(tail -100 ~/.claude/history.jsonl 2>/dev/null \
    | python3 -c "import sys,json; ids=[json.loads(l).get('sessionId','') for l in sys.stdin if 'sessionId' in l]; print(ids[-1] if ids else 'unknown')" 2>/dev/null)
  echo "session_id=${SESSION_ID}"
  echo "resume=claude --resume ${SESSION_ID}"
elif [ -n "$CODEX_THREAD_ID" ]; then
  echo "agent=codex"
  echo "session_id=${CODEX_THREAD_ID}"
  echo "resume=codex exec resume ${CODEX_THREAD_ID}"
else
  echo "agent=unknown"
  echo "session_id=unknown"
fi
```

### 2. Summarize the session

Review the full conversation history and extract:

- **Summary**: 1–3 sentence overview of what was accomplished
- **Agent**: Which CLI ran this session (claude-code / codex) and the model name (e.g. claude-sonnet-4-6, o4-mini)
- **What was discussed**: Topics and problems explored
- **Key decisions**: Technical choices made and their rationale
- **Changes made**: Files created, modified, or deleted (with paths)
- **Questions & clarifications**: Open questions or things that needed clarification
- **Follow-ups / Next steps**: TODOs, deferred work, things to pick up next time

### 3. Write the file

Save to: `$OBSIDIAN_VAULT/Sessions/`

> **Requires**: `OBSIDIAN_VAULT` environment variable set to your vault path.
> e.g. `export OBSIDIAN_VAULT="$HOME/Documents/Obsidian Vault"` in `~/.zshrc`
>
> If unset, abort and ask the user to configure it.

File name: `<date>-<branch>-<time>.md`
Example: `2026-02-18-main-143022.md`

Use this format:

```markdown
---
date: <YYYY-MM-DD>
project: <project-name>
branch: <branch-name>
session_id: <UUID>
agent: <claude-code | codex | unknown>
model: <model-name>
tags:
  - session
  - <agent-name>
---

# Session: <project> / <branch> (<date>)

## Summary

<overview>

## Agent

- **Agent**: <claude-code | codex | unknown>
- **Model**: <model name, e.g. claude-sonnet-4-6 or o4-mini>
- **Resume**: `<resume command>`

## What Was Discussed

- <topic>

## Key Decisions

- **<decision>**: <rationale>

## Changes Made

- `<path>` — <what and why>

## Questions & Clarifications

- <question or clarification>

## Follow-ups / Next Steps

- [ ] <next step>

## Notes

<any other useful context>
```

After writing the file, confirm the path where it was saved.
