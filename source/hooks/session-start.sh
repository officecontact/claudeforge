#!/bin/bash
# ClaudeForge — Session start: load handoff + preferences
if [ -d "status" ] && [ -f "status/handoff.md" ]; then
    words=$(wc -w < "status/handoff.md" 2>/dev/null || echo "0")
    if [ "$words" -gt 50 ]; then
        mod_time=$(stat -c %Y "status/handoff.md" 2>/dev/null || stat -f %m "status/handoff.md" 2>/dev/null || echo "0")
        now=$(date +%s)
        age_days=$(( (now - mod_time) / 86400 ))
        if [ "$age_days" -gt 7 ]; then
            echo "⚠️ Handoff is ${age_days} days old. Run /scan to refresh."
        else
            echo "📋 RESUMING — Previous session handoff:"
            head -100 "status/handoff.md"
            [ "$(wc -l < "status/handoff.md")" -gt 100 ] && echo "... [truncated]"
            echo "---"
        fi
    fi
fi
[ -f "docs/preferences.md" ] && echo "🎨 Preferences loaded from docs/preferences.md"
[ -f "docs/claude-preferences.md" ] && echo "🎨 Preferences loaded from docs/claude-preferences.md"

exit 0
