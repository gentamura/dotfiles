# Claude Code Configuration

This directory contains Claude Code configuration for consistent development workflows.

## Structure

```text
.claude/
├── CLAUDE.md           # Operating model and instructions for Claude
├── rules/              # Always-on constraints and coding standards
├── agents/             # Role-based agent definitions
├── commands/           # Slash command templates
└── skills/             # Reusable procedure templates
```

## Components

### Rules

Always-active constraints that Claude follows automatically.

| File | Purpose |
|------|---------|
| `typescript.md` | Type safety: no `any`, no `as` casts |
| `react.md` | useEffect policy, component patterns |
| `drizzle.md` | Migration workflow, never edit existing |
| `git.md` | Staging policy, pre-commit checks |
| `development.md` | General practices, tooling |
| `nextjs.md` | Next.js 15 specific patterns |
| `terraform.md` | State management, workflow, security |
| `sst.md` | SST framework patterns, linking, secrets |

### Agents

Specialized agents for different responsibilities.

| Agent | Use Case |
|-------|----------|
| `tech-lead` | Requirements analysis, ADR, coordination |
| `frontend-engineer` | React/Next.js, UI implementation |
| `backend-engineer` | API, database, business logic |
| `infra-engineer` | AWS, IaC, CI/CD |
| `qa-verifier` | Testing, code review, release validation |

### Commands

Slash commands to trigger specific workflows.

| Command | Purpose |
|---------|---------|
| `/req <description>` | Break down requirements into tasks |
| `/adr <topic>` | Create Architecture Decision Record |
| `/api:scaffold <resource>` | Generate API endpoint structure |
| `/db:migrate <change>` | Database migration workflow |
| `/pr:review [target]` | Review PR against standards |
| `/release <env>` | Release preparation checklist |

### Skills

Reusable procedures that Claude can invoke.

| Skill | Purpose |
|-------|---------|
| `requirements-to-tasks` | Requirements → User Stories → Tasks |
| `architecture-adr` | ADR creation with options analysis |
| `pr-review` | Systematic code review checklist |
| `drizzle-migration` | Safe database schema changes |
| `release-runbook` | Release process and rollback |
| `incident-hotfix` | Incident response and postmortem |

## Setup

### New Machine

1. Clone dotfiles repository:

```bash
git clone https://github.com/gentamura/dotfiles.git ~/dotfiles
```

2. Run installation (includes `.claude/` symlink):

```bash
cd ~/dotfiles
.bin/install.sh link
```

3. Verify setup:

```bash
ls -la ~/.claude
```

The `install_link.sh` script automatically symlinks all dotfiles including `.claude/` to your home directory.

### Per-Project Override

Create project-specific overrides in your repository:

```bash
# Project-specific rules
.claude/rules/project-specific.md

# Project-specific CLAUDE.md (extends global)
.claude/CLAUDE.md
```

## Customization

### Adding a New Rule

Create a markdown file in `rules/`:

```markdown
# Rule Name

## Description
What this rule enforces.

## Guidelines
- Guideline 1
- Guideline 2
```

### Adding a New Command

Create a markdown file in `commands/`:

```markdown
# Command Name

Description of what this command does.

## Input
$ARGUMENTS

## Process
1. Step 1
2. Step 2

## Output
Expected output format.
```

### Adding a New Skill

Create a directory in `skills/` with `SKILL.md`:

```markdown
---
name: skill-name
description: When to use this skill.
---

# Skill Name

Detailed instructions for the skill.
```

## Design Principles

1. **Rules** are always-on constraints (safety rails)
2. **Commands** are explicit entry points (human-triggered)
3. **Skills** are reusable procedures (Claude-invoked)
4. **Agents** are role-based experts (delegation)

## License

MIT
