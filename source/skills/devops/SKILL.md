---
name: devops
description: Infrastructure and CI/CD patterns. Triggers on Docker, Kubernetes, CI/CD, deploy, nginx, terraform, AWS.
---

## Infrastructure Standards
**Docker:** Specific tags (not latest), multi-stage, non-root USER, .dockerignore, health checks.
**CI/CD:** Trigger > Install (cached) > Lint > Test > Build > Deploy (staged + rollback).
**Deploy checklist:** Env vars set, health endpoint, rollback plan, migrations first, secrets in vault.
