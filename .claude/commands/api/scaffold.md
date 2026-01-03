# API Scaffold

Create API endpoint scaffolding for the specified resource.

## Resource

$ARGUMENTS

## Tasks

1. **Analyze Requirements**
   - Determine CRUD operations needed
   - Identify relationships
   - Define validation rules

2. **Create Files**
   - Route handler
   - Type definitions
   - Validation schema (Zod)
   - Tests

3. **Implementation Checklist**

- [ ] Define Zod schema for request/response
- [ ] Create route handler with proper types
- [ ] Implement input validation
- [ ] Add error handling
- [ ] Create unit tests
- [ ] Update API documentation

## Output Structure

```typescript
// types.ts
export const CreateResourceSchema = z.object({
  // fields
});

export type CreateResourceInput = z.infer<typeof CreateResourceSchema>;

// route.ts
export async function POST(request: Request) {
  const body = await request.json();
  const input = CreateResourceSchema.parse(body);
  // implementation
}
```

Remember:
- No `any` types
- Use type guards, not `as` casts
- Validate at boundaries
- Handle errors consistently
