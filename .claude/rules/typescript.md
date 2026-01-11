# TypeScript Rules

## Type Safety

- Never use `any` type; always create proper type definitions
- Never use `as` casts; rely on type guards instead
- Never ignore TypeScript errors
- Never push with build errors

## Type Guards

Prefer type guards over type assertions:

```typescript
// Bad
const user = data as User;

// Good
function isUser(data: unknown): data is User {
  return typeof data === 'object' && data !== null && 'id' in data;
}

if (isUser(data)) {
  // data is typed as User
}
```

## Build Verification

After any file changes:

1. Run `bun run lint:fix`
2. Run `bun run build`
3. Fix any errors before committing
