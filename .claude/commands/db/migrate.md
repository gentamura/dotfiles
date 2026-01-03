# Database Migration

Create a database migration for the specified change.

## Change

$ARGUMENTS

## Rules

1. **Never edit existing migration files**
2. Update schema definition first
3. Generate migration with `drizzle-kit generate`
4. Apply with `drizzle-kit migrate`

## Workflow

1. **Update Schema**
   - Modify `src/db/schema.ts` (or equivalent)
   - Add/modify table definitions
   - Update relationships if needed

2. **Generate Migration**
   ```bash
   drizzle-kit generate
   ```

3. **Review Migration**
   - Check generated SQL
   - Verify it matches intent
   - Note any data implications

4. **Apply Migration**
   ```bash
   drizzle-kit migrate
   ```

5. **Verify**
   - Check with `psql`
   - Test affected queries

## Checklist

- [ ] Schema updated correctly
- [ ] Migration generated (not manually edited)
- [ ] Migration reviewed
- [ ] Tested in development
- [ ] Rollback plan documented
