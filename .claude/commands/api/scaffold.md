# API Scaffold

Create API endpoint scaffolding for the specified resource.

## Resource

$ARGUMENTS

## Prerequisites

This scaffold uses [Zod](https://zod.dev/) for runtime validation. Ensure it is installed:

```bash
# Check if Zod is installed
bun pm ls | grep zod

# Install if needed
bun add zod
```

## Tasks

1. **Check Dependencies**
   - Verify Zod is installed
   - Check existing validation patterns in codebase

2. **Analyze Requirements**
   - Determine CRUD operations needed
   - Identify relationships
   - Define validation rules

3. **Create Files**
   - Route handler
   - Type definitions
   - Validation schema (Zod)
   - Tests

4. **Implementation Checklist**

- [ ] Verify Zod dependency is installed
- [ ] Define Zod schema for request/response
- [ ] Create route handler with proper types
- [ ] Implement input validation
- [ ] Add error handling
- [ ] Create unit tests
- [ ] Update API documentation

## Output Structure

```typescript
// types.ts
import { z } from 'zod';

export const CreateResourceSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  // add fields as needed
});

export type CreateResourceInput = z.infer<typeof CreateResourceSchema>;

export const ResourceResponseSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string(),
  createdAt: z.string().datetime(),
});

export type ResourceResponse = z.infer<typeof ResourceResponseSchema>;
```

```typescript
// route.ts
import { NextResponse } from 'next/server';
import { CreateResourceSchema } from './types';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const input = CreateResourceSchema.parse(body);

    // implementation
    const result = await createResource(input);

    return NextResponse.json({ data: result });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: { code: 'VALIDATION_ERROR', message: error.message } },
        { status: 400 }
      );
    }
    throw error;
  }
}
```

## Remember

- No `any` types
- Use type guards, not `as` casts
- Validate at boundaries with Zod
- Handle errors consistently
- Import `z` from 'zod' in all files using schemas
