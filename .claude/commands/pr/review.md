# PR Review

Review the current changes or specified PR.

## Target

$ARGUMENTS

## Review Checklist

### Type Safety
- [ ] No `any` types
- [ ] No `as` casts (type guards used instead)
- [ ] Proper return types on functions
- [ ] Correct error types

### React (if applicable)
- [ ] useEffect only for external synchronization
- [ ] No derived state in effects
- [ ] Effects have cleanup when needed
- [ ] User actions in event handlers

### Code Quality
- [ ] `bun run lint:fix` (or `bun run lint` if no fix script) passes
- [ ] `bun run build` passes
- [ ] No console.log in production code
- [ ] Follows existing patterns

### Security
- [ ] Input validation at boundaries
- [ ] No hardcoded secrets
- [ ] Proper auth checks
- [ ] SQL injection prevention

### Database (if applicable)
- [ ] Existing migrations not edited
- [ ] Schema changes via drizzle-kit
- [ ] Indexes considered

### Documentation
- [ ] Comments in English
- [ ] Complex logic explained
- [ ] API changes documented

## Output

Provide review in this format:

```markdown
## Summary
[Overall assessment]

## Issues
- [ ] Issue 1 (severity: high/medium/low)
- [ ] Issue 2

## Suggestions
- Suggestion 1
- Suggestion 2

## Approval
Ready to merge: Yes/No
Blockers: [list if any]
```
