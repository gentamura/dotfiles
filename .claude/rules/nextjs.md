# Next.js Rules

## Next.js 15 Requirements

### Dynamic Route Parameters

In Next.js 15+ (App Router, Server Components), dynamic route params are `Promise<T>`, so you must `await` them before use.

```typescript
// app/users/[id]/page.tsx

// Bad - direct access
export default function Page({ params }: { params: { id: string } }) {
  return <div>{params.id}</div>;
}

// Good - await params (Next.js 15+)
export default async function Page({
  params
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params;
  return <div>{id}</div>;
}
```

### Server Components

- Default to Server Components
- Use `'use client'` only when necessary (interactivity, browser APIs)
- Keep client components small and focused
