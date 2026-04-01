#!/bin/bash
# ClaudeForge — Post-compact: re-inject current task
echo "🔄 Compaction complete."
[ -f "status/current-task.md" ] && echo "📌 Current task:" && head -10 "status/current-task.md" && echo ""
echo "⚡ Style: docs/preferences.md | Patterns: match existing codebase"

exit 0
