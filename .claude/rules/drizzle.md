# Drizzle ORM Rules

## Migration Policy

- Never edit existing migration files directly
- Update the schema definition first
- Generate migrations with `drizzle-kit generate`
- Apply migrations with `drizzle-kit migrate`

## Workflow

1. Modify schema files (`src/db/schema.ts` or similar)
2. Run `drizzle-kit generate` to create migration
3. Review generated migration file
4. Run `drizzle-kit migrate` to apply

## Database Access

- Use `psql` directly for database inspection
- Do not use Drizzle Studio in development
