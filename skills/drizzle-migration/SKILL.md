---
name: drizzle-migration
description: Use this skill for database schema changes with Drizzle ORM. Invoke when adding tables, columns, indexes, or modifying database structure.
---

# Drizzle Migration

Safe database schema changes following Drizzle ORM best practices.

## Golden Rules

1. **NEVER edit existing migration files**
2. **ALWAYS update schema first, then generate**
3. **ALWAYS review generated SQL before applying**
4. **ALWAYS test in development before staging/production**

## Workflow

### 1. Plan the Change

- Identify tables and columns affected
- Consider data migration needs
- Plan for backwards compatibility
- Document rollback strategy

### 2. Update Schema

Modify the schema file (e.g., `src/db/schema.ts`):

```typescript
// Example: Adding a new column
export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull(),
  // New column
  avatarUrl: varchar('avatar_url', { length: 500 }),
});
```

### 3. Generate Migration

```bash
drizzle-kit generate
```

Review the generated file in `drizzle/` or your migrations folder.

### 4. Review Generated SQL

Check for:
- Correct table and column names
- Appropriate data types
- NOT NULL constraints with defaults
- Index definitions
- Foreign key constraints

### 5. Apply Migration

```bash
# Development
drizzle-kit migrate

# Or with custom script
bun run db:migrate
```

### 6. Verify

```bash
# Connect and inspect
psql -d your_database

# Check table structure
\d table_name

# Verify data integrity
SELECT count(*) FROM table_name;
```

## Common Patterns

### Adding a Column

```typescript
// Schema
export const users = pgTable('users', {
  // existing columns...
  newColumn: varchar('new_column', { length: 100 }),
});
```

### Adding NOT NULL Column

```typescript
// Add with default first, then remove default if needed
newColumn: varchar('new_column').notNull().default(''),
```

### Adding an Index

```typescript
export const users = pgTable('users', {
  // columns...
}, (table) => ({
  emailIdx: index('email_idx').on(table.email),
}));
```

### Adding a Foreign Key

```typescript
export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  authorId: integer('author_id')
    .notNull()
    .references(() => users.id),
});
```

## Checklist

### Before Generating
- [ ] Schema changes are correct
- [ ] Types are appropriate
- [ ] Constraints are defined
- [ ] Indexes are considered

### After Generating
- [ ] Review generated SQL
- [ ] No destructive operations unexpected
- [ ] Migration file NOT manually edited

### After Applying
- [ ] Verify with `psql`
- [ ] Test affected queries
- [ ] Check application functionality

## Rollback Strategy

Document rollback approach before applying:

```markdown
## Migration: Add avatar_url to users

### Forward
- Adds nullable `avatar_url` column

### Rollback
- Safe to drop column (no data loss concerns)
- SQL: `ALTER TABLE users DROP COLUMN avatar_url;`
```

## Troubleshooting

### Migration fails

1. Check error message
2. Verify database connection
3. Check for conflicts with existing data
4. Review migration SQL

### Schema out of sync

```bash
# Introspect current database
drizzle-kit introspect

# Compare with schema file
# Resolve differences
```
