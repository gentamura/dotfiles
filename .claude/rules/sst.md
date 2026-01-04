# SST Rules

[SST](https://sst.dev/) is a framework for building full-stack applications on AWS.

## Project Structure

```text
├── infra/              # Infrastructure definitions
│   ├── api.ts
│   ├── storage.ts
│   └── web.ts
├── packages/
│   ├── core/           # Shared business logic
│   ├── functions/      # Lambda functions
│   └── web/            # Frontend application
├── sst.config.ts       # SST configuration
└── sst-env.d.ts        # Type definitions
```

## Workflow

1. `sst dev` - Start development environment
2. `sst diff` - Preview infrastructure changes
3. `sst deploy --stage <stage>` - Deploy to stage
4. `sst remove --stage <stage>` - Remove stack

## Configuration

```typescript
// sst.config.ts
export default $config({
  app(input) {
    return {
      name: "my-app",
      removal: input?.stage === "prod" ? "retain" : "remove",
      home: "aws",
    };
  },
  async run() {
    // Infrastructure definitions
  },
});
```

## Best Practices

- Use `sst dev` for local development with live Lambda
- Always run `sst diff` before deploying to production
- Use stages for environment separation (dev, staging, prod)
- Keep infrastructure code in `infra/` directory
- Use `Link` for connecting resources to functions

## Linking Resources

```typescript
// infra/storage.ts
export const bucket = new sst.aws.Bucket("MyBucket");

// infra/api.ts
new sst.aws.Function("MyFunction", {
  handler: "packages/functions/src/handler.main",
  link: [bucket],
});
```

```typescript
// packages/functions/src/handler.ts
import { Resource } from "sst";

export async function main() {
  const bucketName = Resource.MyBucket.name;
}
```

## Secrets Management

```bash
# Set secret
sst secret set DatabaseUrl "postgresql://..."

# Use in function
sst.aws.Function("Api", {
  handler: "handler.main",
  link: [/* secrets are auto-linked */],
});
```

## Never Do

- Hardcode credentials in `sst.config.ts`
- Deploy to prod without `sst diff` review
- Use `removal: "remove"` in production
- Skip type generation (`sst-env.d.ts`)
