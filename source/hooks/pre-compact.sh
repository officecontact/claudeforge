#!/bin/bash
# ClaudeForge — Pre-compact: warn + log
mkdir -p status 2>/dev/null
if [ -f "status/session-log.md" ]; then
    lines=$(wc -l < "status/session-log.md")
    if [ "$lines" -gt 500 ]; then
        tail -200 "status/session-log.md" > "status/session-log.tmp" && mv "status/session-log.tmp" "status/session-log.md"
    fi
    echo "" >> "status/session-log.md"
    echo "## Auto-Compact — $(date '+%Y-%m-%d %H:%M')" >> "status/session-log.md"
fi
echo "⚠️ COMPACTION TRIGGERED — checkpoint progress NOW. Run: /checkpoint"

exit 0
