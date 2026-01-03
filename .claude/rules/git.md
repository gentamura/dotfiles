# Git Rules

## Staging

- Stage files individually: `git add a.txt b.txt`
- Never use `git add .`
- Review each file before staging

## Pre-commit Checks

Before committing:

1. Run `bun run lint:fix`
2. Run `bun run build`
3. Verify all checks pass

## Commit Messages

- Write clear, descriptive commit messages
- Use conventional commits format when applicable
- Keep subject line under 50 characters
