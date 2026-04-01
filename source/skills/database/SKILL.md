---
name: database
description: Database design and query patterns. Triggers on database, schema, migration, SQL, ORM, Prisma, N+1.
---

## Database Patterns
**Schema:** Singular names. Every table: id, created_at, updated_at. UUIDs for public IDs. Soft delete.
**Migrations:** Forward-only. One thing per migration. Both up and down.
**Queries:** SELECT specific columns. Index WHERE/JOIN columns. EXPLAIN ANALYZE. Batch inserts.
**N+1 fix:** JOINs or eager loading.
