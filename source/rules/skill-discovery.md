---
name: skill-discovery
description: Auto-detect missing skills. Suggest install from registry when technology has no matching skill.
---

## Skill Discovery

**On task start:** Check if `.claude/skills/` has a matching skill for the technology in use.

**If no match:** Check `skills-registry/registry.json` for downloadable skill. Ask once:
> "This project uses [X]. Installing the [X] skill improves first-attempt accuracy. Install? (~50 tokens startup cost)"

If yes: copy from `skills-registry/skills/[name]/SKILL.md` to `.claude/skills/[name]/SKILL.md`.
If no: proceed without. Don't ask again this session.

**Detection:** Look for framework files (next.config.*, Cargo.toml, manage.py, schema.prisma, etc.) or keywords matching registry triggers.
