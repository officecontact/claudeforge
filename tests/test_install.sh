#!/bin/bash
set -e
PASS=0; FAIL=0
assert() {
    if eval "$1" 2>/dev/null; then PASS=$((PASS+1)); echo -e "  \033[32m✓\033[0m $2"
    else FAIL=$((FAIL+1)); echo -e "  \033[31m✗\033[0m $2"; fi
}
echo "ClaudeForge Tests"
T=$(mktemp -d); cp -r "$(cd "$(dirname "$0")/.."; pwd)" "$T/cf"; cd "$T"

echo "Clean install:"
mkdir p1 && cd p1 && bash "$T/cf/install.sh" >/dev/null 2>&1
assert '[ -f .claude/settings.json ]' "settings.json"
assert '[ -f .claude/agents/researcher.md ]' "agents"
assert '[ -f .claude/rules/memory-protocol.md ]' "rules"
assert '[ -f .claude/commands/init-project.md ]' "commands"
assert '[ -d .claude/skills/code-review ]' "skills"
assert '[ -f .claude/hooks/session-start.sh ]' "hooks"
assert '[ -x .claude/hooks/session-start.sh ]' "hooks executable"
assert '[ -f .claude/.claudeforge-manifest ]' "manifest"
assert 'python3 -c "import json; json.load(open(\".claude/settings.json\"))"' "valid JSON"
assert 'grep -q sonnet .claude/settings.json' "model=sonnet"
assert 'grep -q 10000 .claude/settings.json' "thinking=10K"
assert 'grep -q haiku .claude/settings.json' "subagent=haiku"
cd "$T"

echo "Existing project:"
mkdir -p p2/.claude/agents && echo '{"model":"opus","env":{"X":"1"}}' > p2/.claude/settings.json
echo "custom" > p2/.claude/agents/mine.md && echo "code" > p2/app.js
cd p2 && bash "$T/cf/install.sh" >/dev/null 2>&1
assert 'python3 -c "import json; assert json.load(open(\".claude/settings.json\"))[\"model\"]==\"opus\""' "model preserved"
assert 'python3 -c "import json; assert json.load(open(\".claude/settings.json\"))[\"env\"][\"X\"]==\"1\""' "custom var preserved"
assert 'python3 -c "import json; assert \"MAX_THINKING_TOKENS\" in json.load(open(\".claude/settings.json\"))[\"env\"]"' "forge vars merged"
assert 'python3 -c "import json; assert \"PreCompact\" in json.load(open(\".claude/settings.json\")).get(\"hooks\",{})"' "hooks merged"
assert '[ -f .claude/agents/mine.md ]' "custom agent preserved"
assert '[ "$(cat app.js)" = "code" ]' "source untouched"
cd "$T"

echo "Idempotent:"
cd p2 && b=$(md5sum .claude/settings.json|cut -d" " -f1) && bash "$T/cf/install.sh" >/dev/null 2>&1
assert '[ "$(md5sum .claude/settings.json|cut -d" " -f1)" = "$b" ]' "no change on re-install"
cd "$T"

echo "Agent quality:"
cd p1
for a in .claude/agents/*.md; do n=$(basename "$a" .md)
    assert "grep -q preferences.md '$a'" "$n reads preferences"
    assert "grep -q 'Thinking budget' '$a'" "$n has thinking budget"
done
cd "$T"

echo "Uninstall + rollback:"
cd p2 && bash "$T/cf/install.sh" --uninstall >/dev/null 2>&1
assert '[ ! -f .claude/agents/researcher.md ]' "forge agents removed"
assert '[ -f .claude/agents/mine.md ]' "custom agent survived"
assert '[ "$(cat app.js)" = "code" ]' "source still untouched"
assert 'python3 -c "import json; assert \"MAX_THINKING_TOKENS\" not in json.load(open(\".claude/settings.json\")).get(\"env\",{})"' "settings rolled back"
cd "$T"

rm -rf "$T"
echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -gt 0 ] && exit 1 || exit 0
