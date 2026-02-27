# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Claude Code Operating Model

This repository follows a structured Claude Code setup with four conceptual layers:

| Layer    | Purpose                                          | Location             |
|----------|--------------------------------------------------|----------------------|
| Rules    | Always-on constraints and safety rails           | `.claude/rules/`     |
| Skills   | Reusable procedures for recurring tasks          | `skills/`            |
| Agents   | Role-based delegation (FE, BE, Infra, QA, Lead)  | `.claude/agents/`    |
| Commands | Explicit entry points to trigger workflows       | `.claude/commands/`  |

### Design Principles

- **Commands** are the primary UI for humans to invoke workflows
- **Skills** encode repeatable execution logic (procedures, checklists)
- **Agents** own responsibility boundaries and domain expertise
- **Rules** prevent footguns and enforce quality standards

### Dotfiles Strategy

- Public dotfiles contain generic, reusable templates only
- Private overlays (CLAUDE.local.md) contain environment-specific data
- Repo-local CLAUDE.md defines project-specific truth

### Plan Mode and ADR Integration

When in Plan Mode, suggest creating an ADR (`/adr`) if any of these conditions apply:

- Multiple viable technical approaches exist
- The decision affects project-wide architecture
- The choice is difficult to reverse later
- Future developers will ask "why this approach?"

Workflow: Plan Mode (how to implement) → ADR (why this approach) → Implementation

### Plan and ADR Storage

Save implementation plans and ADRs in the **project repository**, not in global dotfiles:

- Plans: `docs/plans/YYYY-MM-DD-<feature-name>.md`
- ADRs: `docs/adr/NNNN-<title>.md`

When exiting Plan Mode, save the approved plan so sub-agents can reference it during parallel implementation.

## Development Practices

- All files must end with an actual newline character
- Use `rg` (ripgrep) instead of `grep` whenever possible
- Use `psql` directly instead of Drizzle Studio for database checks
- Check documentation using Context7 MCP server (`mcp__context7__query-docs`) before implementing frameworks/libraries
- Never start the development server in background using `&`

## Build & Type Checking

After any file changes, always run:

1. `bun run lint:fix` (or `bun run lint` if no fix script) - Fix formatting and linting issues
2. `bun run build` - Verify TypeScript types and build success
3. Fix any errors before committing

## Language

- Keep all repository documentation, comments, and text in English
- Answers and conversations may be in Japanese when requested

Refer to `.claude/` for detailed rules, agents, skills, and commands.
