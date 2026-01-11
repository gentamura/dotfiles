---
name: pr-review
description: Use this skill to review pull requests against coding standards and best practices. Invoke when reviewing code changes before merge.
---

# PR Review

Systematic code review following team standards.

## Review Process

### 1. Understand the Change

- Read PR description and linked issues
- Understand the intent and scope
- Check if the approach aligns with architecture

### 2. Review Code Quality

Go through each checklist section below.

### 3. Provide Feedback

- Be specific and actionable
- Explain the "why" behind suggestions
- Distinguish blocking issues from suggestions
- Acknowledge good patterns

## Review Checklist

### TypeScript

- [ ] No `any` types used
- [ ] No `as` casts (type guards used instead)
- [ ] Functions have explicit return types
- [ ] Proper error types defined
- [ ] No TypeScript errors (`bun run build` passes)

### React

- [ ] useEffect only for external synchronization
  - API calls, WebSocket, browser APIs, timers
- [ ] No derived state in useEffect
- [ ] No props copied to state
- [ ] User actions handled in event handlers
- [ ] Effects have comments explaining external resource
- [ ] Proper cleanup in effects when needed

### Code Quality

- [ ] `bun run lint:fix` (or `bun run lint` if no fix script) passes
- [ ] No console.log in production code
- [ ] Follows existing patterns in codebase
- [ ] No dead code or commented-out code
- [ ] Meaningful variable and function names

### Security

- [ ] Input validated at boundaries
- [ ] No hardcoded secrets or credentials
- [ ] Proper authentication/authorization checks
- [ ] No SQL injection vulnerabilities
- [ ] No XSS vulnerabilities

### Database (if applicable)

- [ ] Existing migrations NOT edited
- [ ] Schema changes via `drizzle-kit generate`
- [ ] Appropriate indexes considered
- [ ] No N+1 query patterns

### Testing

- [ ] Tests cover happy path
- [ ] Tests cover error cases
- [ ] Tests are meaningful (not just coverage)

### Documentation

- [ ] Comments and docs in English
- [ ] Complex logic explained
- [ ] API changes documented
- [ ] README updated if needed

## Feedback Template

```markdown
## Summary

[Overall assessment: Approve / Request Changes / Comment]

## Blocking Issues

- [ ] **[File:Line]** Issue description
  - Why it's a problem
  - Suggested fix

## Suggestions

- **[File:Line]** Suggestion description
  - Why this would be better

## Questions

- [Question about design or implementation]

## Praise

- [Acknowledge good patterns or improvements]
```

## Severity Levels

| Level | Meaning | Action |
|-------|---------|--------|
| Blocking | Must fix before merge | Request changes |
| Suggestion | Would improve code | Comment |
| Nitpick | Minor style preference | Optional |
| Question | Need clarification | Comment |
