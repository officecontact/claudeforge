---
name: nextjs
description: Next.js App Router patterns. Triggers on next.js, nextjs, app router, server component, page.tsx.
---

## Next.js App Router
**Files:** page.tsx (route), layout.tsx (wrapper), loading.tsx (Suspense), error.tsx (boundary), route.ts (API).
**Server vs Client:** Default=Server. 'use client' ONLY for useState/useEffect/onClick/browser APIs.
**Data:** Server Components fetch directly. Server Actions for mutations. revalidatePath() after writes.
**Anti-patterns:** 'use client' on layouts, fetching in useEffect when Server Component works.
