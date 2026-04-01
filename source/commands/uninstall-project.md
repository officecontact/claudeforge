Remove ClaudeForge from the current project.

This removes: .claude/agents/ (ClaudeForge agents only), .claude/rules/, .claude/commands/, .claude/skills/ (built-in only), .claude/hooks/, .claude/settings.json, status/ directory, skills-registry/.

This PRESERVES: docs/preferences.md (your preferences are valuable), docs/ARCHITECTURE.md, docs/CONVENTIONS.md, all source code, all other .claude/ files not created by ClaudeForge, CLAUDE.md (only removes appended ClaudeForge section).

If .claude/.claudeforge-manifest exists, use it to remove ONLY files ClaudeForge installed.
If backup exists, restore settings.json to pre-install state.
Confirm with user before proceeding. List exactly what will be removed.