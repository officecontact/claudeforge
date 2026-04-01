---
name: api-design
description: REST and GraphQL API patterns. Triggers on API, endpoint, REST, GraphQL, route, schema.
---

## API Standards
**REST:** GET /resources (list), GET /:id (one), POST (create>201), PUT (update), DELETE (>204).
**Response:** `{ data, meta: {page, total}, errors: [{code, message, field}] }`.
**Errors:** 400 validation, 401 unauth, 403 forbidden, 404 not found, 409 conflict, 500 server.
**Pagination:** Cursor-based for large/realtime, offset for admin.
