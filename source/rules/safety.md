---
name: safety
description: Prevent ClaudeForge from breaking code, configs, or team workflows.
---

## Safety Boundaries

**ClaudeForge ONLY manages:** .claude/, status/, docs/preferences.md, docs/ARCHITECTURE.md, docs/CONVENTIONS.md, CLAUDE.md (append only), .claudeignore (create only if missing), .gitignore (append only).

**NEVER touches:** Source code, test files, package.json, build configs, deployment configs, CI/CD pipelines, environment files, Docker files, or ANY file not listed above.

**On error:** If a status file or preferences file is missing, proceed without it. Never crash or refuse to work. Create it lazily when next needed.

**Team safety:** All per-developer files (status/session-log.md, handoff.md, CLAUDE.local.md) are gitignored. Shared files (docs/preferences.md, CLAUDE.md) are safe to commit.

**CI/CD safety:** .claudeignore only affects Claude Code. It does NOT affect build tools, linters, or test runners.
