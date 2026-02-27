# AGENTS.md

Entry guide for AI coding agents working in this repository.

## Quick Start

- Read `.claude/CLAUDE.md` first for repository-wide operating guidance.
- Treat `.claude/` and `skills/` as the source of truth for detailed procedures and constraints.
- Keep this file lightweight. Use it as an index and routing layer.

## Where To Look

- Rules: `.claude/rules/`
- Skills (shared): `skills/`
- Agents: `.claude/agents/`
- Commands: `.claude/commands/`

## Skill Usage

- If a user explicitly names a skill, use that skill for the task.
- If a request clearly matches a skill description, use that skill even without explicit naming.
- When multiple skills match, choose the minimum set and apply them in explicit order.

## Skill Index

- `agent-browser`: Browser automation for testing, screenshots, and data extraction
- `architecture-adr`: Create ADRs for architectural decisions
- `done`: Summarize session outcomes
- `drizzle-migration`: Safe Drizzle schema/migration workflow
- `incident-hotfix`: Incident response and hotfix workflow
- `pr-create`: Create pull requests from local branch changes
- `pr-address-bot-reviews`: Triage and address bot review feedback on PRs
- `pr-review`: Systematic PR review against standards
- `release-runbook`: Release preparation and execution checklist
- `requirements-to-tasks`: Break requirements into actionable tasks

## Documentation Strategy

- `AGENTS.md`: entry point, skill index, and pointers
- `.claude/CLAUDE.md`: canonical operational guidance
- `skills/`: shared skills consumed by both Codex and Claude via symlink
- `.claude/*`: detailed tool-specific workflows and assets (excluding shared skills)
