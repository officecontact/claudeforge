Initialize ClaudeForge for this project. 4-phase flow: Scan > Preview > Approve > Apply.

## PHASE 1: SCAN (read-only)
Run silently:
- ls package.json pyproject.toml requirements.txt Cargo.toml go.mod 2>/dev/null
- cat package.json 2>/dev/null | grep -E scripts | head -10
- find . -maxdepth 2 -type f \( -name "*.ts" -o -name "*.py" -o -name "*.go" \) 2>/dev/null | head -20
- ls .claude/ CLAUDE.md .claudeignore docs/ status/ 2>/dev/null
- ls tailwind.config.* 2>/dev/null
- git log --oneline -1 2>/dev/null

## PHASE 2: PREVIEW
Show findings:
```
📋 ClaudeForge Project Scan
🔍 Detected: [language], [framework], [CSS], [test framework]
⚙️ Commands: dev=[X], build=[Y], test=[Z]
📝 Will create (only missing files):
  [✓] status/current-task.md
  [✓] status/session-log.md
  [✓] status/handoff.md
  [✓] docs/preferences.md (auto-filled from detected stack)
  [·] CLAUDE.md (append protocol if <200 lines)
  [·] .gitignore (append ClaudeForge entries)
  [—] skipped: [files that already exist]
⚠️ Issues: [any collisions, large CLAUDE.md, etc.]
🎯 Suggested skills: [based on stack]
```
Ask: "Does this look correct? Type 'yes' to proceed."

## PHASE 3: APPLY (only after approval)
Create missing files only. Auto-fill preferences.md from detected stack. If docs/ has existing project docs, use docs/claude-preferences.md instead. Generate .claudeignore only for directories that actually exist. Append to CLAUDE.md only if <200 lines.

## PHASE 4: CONFIRM
List what was created, what was preserved, what skills are suggested.

## SAFETY: Never overwrite. Never delete. Never modify source code. Always preview first.