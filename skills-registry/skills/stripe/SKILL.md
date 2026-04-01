---
name: stripe
description: Stripe integration. Triggers on stripe, payment, checkout, subscription, webhook.
---

## Stripe
**Methods:** Checkout Session (simple), Payment Intents (custom), Elements (full UI).
**Webhooks:** Verify signature. Handle idempotently. Return 200 fast.
**Security:** NEVER secret key on client. ALWAYS verify sigs. NEVER trust client-side price.
