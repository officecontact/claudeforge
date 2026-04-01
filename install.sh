#!/bin/bash
set -euo pipefail
VERSION="2.1.0"; DIR=".claude"; CHANGES=0; SKIPPED=0; WARNINGS=0
R='\033[0;31m';G='\033[0;32m';Y='\033[1;33m';C='\033[0;36m';BOLD='\033[1m';DIM='\033[2m';NC='\033[0m'
ok() { echo -e "  ${G}✓${NC} $1"; CHANGES=$((CHANGES+1)); }
skip() { echo -e "  ${DIM}· $1 (exists)${NC}"; SKIPPED=$((SKIPPED+1)); }
merg() { echo -e "  ${Y}~${NC} $1 (merged)"; CHANGES=$((CHANGES+1)); }
warn() { echo -e "  ${Y}⚠${NC} $1"; WARNINGS=$((WARNINGS+1)); }
manifest_add() { [ -f "$MANIFEST" ] && echo "$1" >> "$MANIFEST" || true; }

safe_cp() {
    local src="$1" dst="$2" label="$3"
    if [ ! -f "$dst" ]; then
        mkdir -p "$(dirname "$dst")"
        if cp "$src" "$dst"; then
            ok "$label"
            manifest_add "$dst"
        else
            warn "Failed: $label"
        fi
    else
        skip "$label"
    fi
}

safe_cpdir() {
    local src="$1" dst="$2" label="$3"
    if [ ! -d "$dst" ]; then
        if cp -r "$src" "$dst"; then
            ok "$label"
            manifest_add "$dst"
        else
            warn "Failed: $label"
        fi
    else
        skip "$label"
    fi
}

DRY=false;UNINSTALL=false
for a in "$@";do case $a in --dry-run)DRY=true;;--uninstall)UNINSTALL=true;;--help|-h)
echo "ClaudeForge v${VERSION} — Install into current project"
echo "  ./install.sh              Install"
echo "  ./install.sh --dry-run    Preview only"
echo "  ./install.sh --uninstall  Rollback"
exit 0;;esac;done

echo ""
echo -e "${C}╔═══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${NC}  ${BOLD}⚒️  ClaudeForge v${VERSION}${NC}                            ${C}║${NC}"
echo -e "${C}║${NC}  Token optimizer for Claude Code                    ${C}║${NC}"
echo -e "${C}╚═══════════════════════════════════════════════════╝${NC}"
echo ""
$DRY&&echo -e "${Y}${BOLD}DRY RUN — no changes${NC}"&&echo ""

if $UNINSTALL;then
echo -e "${Y}${BOLD}Uninstalling ClaudeForge...${NC}";echo ""
if [ -f "$DIR/.claudeforge-manifest" ];then
backup_dir=$(sed -n '2p' "$DIR/.claudeforge-manifest"|sed 's/^# Backup: //')
        removed=0
        while IFS= read -r file; do
            [[ "$file" =~ ^#.* ]] && continue
            [ -z "$file" ] && continue
            if [ -f "$file" ]; then
                rm "$file" && removed=$((removed+1))
            elif [ -d "$file" ]; then
                rm -rf "$file" && removed=$((removed+1))
            fi
        done < "$DIR/.claudeforge-manifest"
echo -e "  ${G}Removed $removed files${NC}"
if [ -n "$backup_dir" ]&&[ -d "$backup_dir" ];then
[ -f "$backup_dir/settings.json" ]&&cp "$backup_dir/settings.json" "$DIR/settings.json"&&echo -e "  ${G}✓${NC} settings.json restored"
[ -f "$backup_dir/CLAUDE.md.bak" ]&&cp "$backup_dir/CLAUDE.md.bak" "CLAUDE.md"&&echo -e "  ${G}✓${NC} CLAUDE.md restored"
fi
rm -f "$DIR/.claudeforge-manifest";[ -n "$backup_dir" ]&&[ -d "$backup_dir" ]&&rm -rf "$backup_dir"
else
echo -e "${Y}No manifest. Removing known files...${NC}"
for a in researcher architect implementer reviewer tester marketer docs-writer devops debugger optimizer;do [ -f "$DIR/agents/$a.md" ]&&rm "$DIR/agents/$a.md";done
for r in memory-protocol consistency model-routing token-efficiency skill-discovery safety;do [ -f "$DIR/rules/$r.md" ]&&rm "$DIR/rules/$r.md";done
for c in checkpoint handoff resume status savings optimize new-agent scan uninstall-project init-project;do [ -f "$DIR/commands/$c.md" ]&&rm "$DIR/commands/$c.md";done
for h in pre-compact post-compact session-start;do [ -f "$DIR/hooks/$h.sh" ]&&rm "$DIR/hooks/$h.sh";done
fi
echo "";echo -e "${G}${BOLD}✅ ClaudeForge uninstalled.${NC}"
echo -e "${DIM}Source code and docs/preferences.md preserved.${NC}";exit 0;fi

echo -e "${BOLD}Pre-flight...${NC}"
[ ! -w "." ]&&echo -e "${R}❌ Directory not writable${NC}"&&exit 1
avail=$(df "." 2>/dev/null|tail -1|awk '{print $4}'||echo "999999")
[ "${avail:-999999}" -lt 1024 ] 2>/dev/null&&echo -e "${R}❌ No disk space${NC}"&&exit 1
echo -e "  ${G}Passed${NC}";echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC=""
for try in "$SCRIPT_DIR" "$SCRIPT_DIR/..";do
[ -f "$try/source/settings.json" ]&&[ -d "$try/source/agents" ]&&SRC="$try"&&break
done
[ -z "$SRC" ]&&echo -e "${R}❌ Source not found. Run from claudeforge directory.${NC}"&&exit 1

BACKUP_DIR="$DIR/.claudeforge-backup-$(date +%Y%m%d-%H%M%S)"
MANIFEST="$DIR/.claudeforge-manifest"
if ! $DRY; then
    mkdir -p "$DIR" "$BACKUP_DIR"
    echo "# Manifest v$VERSION" > "$MANIFEST"
    echo "# Backup: $BACKUP_DIR" >> "$MANIFEST"
    [ -f "$DIR/settings.json" ] && cp "$DIR/settings.json" "$BACKUP_DIR/settings.json"
    [ -f "CLAUDE.md" ] && cp "CLAUDE.md" "$BACKUP_DIR/CLAUDE.md.bak"
fi





if ! $DRY; then
    mkdir -p "$DIR"/{agents,commands,rules,skills,hooks} status docs skills-registry
fi

echo -e "${BOLD}⚙️  Settings:${NC}"
if [ -f "$DIR/settings.json" ]; then
    # Try python3 first (best merge), fall back to node, then pure bash
    merge_done=false

    if ! $merge_done && command -v python3 &>/dev/null; then
        result=$(python3 -c "
import json,sys
p='$DIR/settings.json'
try: d=json.load(open(p))
except json.JSONDecodeError: print('INVALID_JSON');sys.exit(0)
except: d={}
nenv={'MAX_THINKING_TOKENS':'10000','CLAUDE_AUTOCOMPACT_PCT_OVERRIDE':'50','CLAUDE_CODE_SUBAGENT_MODEL':'haiku','DISABLE_NON_ESSENTIAL_MODEL_CALLS':'1'}
nhooks={'PreCompact':[{'matcher':'','hooks':[{'type':'command','command':'bash .claude/hooks/pre-compact.sh'}]}],'SessionStart':[{'matcher':'','hooks':[{'type':'command','command':'bash .claude/hooks/session-start.sh'}]}],'PostCompact':[{'matcher':'','hooks':[{'type':'command','command':'bash .claude/hooks/post-compact.sh'}]}]}
d.setdefault('env',{});d.setdefault('hooks',{})
a=[]
for k,v in nenv.items():
 if k not in d['env']:d['env'][k]=v;a.append(k)
for ev,hs in nhooks.items():
 if ev not in d['hooks']:d['hooks'][ev]=hs;a.append('hook:'+ev)
 else:
  existing_str=json.dumps(d['hooks'][ev])
  if 'pre-compact' not in existing_str and 'claudeforge' not in existing_str:
   d['hooks'][ev].extend(hs);a.append('hook:'+ev)
if 'model' not in d:d['model']='sonnet';a.append('model')
json.dump(d,open(p,'w'),indent=2)
print('MERGED:'+','.join(a) if a else 'NONE')
" 2>&1)
        case "$result" in
            INVALID_JSON) warn "Invalid JSON — backed up, not modified" ;;
            NONE) skip "settings.json" ;;
            MERGED:*) merg "settings.json (${result#MERGED:})" ;;
        esac
        merge_done=true
    fi

    if ! $merge_done && command -v node &>/dev/null; then
        result=$(node -e "
const fs=require('fs');
let d;
try{d=JSON.parse(fs.readFileSync('$DIR/settings.json','utf8'))}catch(e){console.log('INVALID_JSON');process.exit(0)}
if(!d.env)d.env={};if(!d.hooks)d.hooks={};
const a=[];
const nenv={MAX_THINKING_TOKENS:'10000',CLAUDE_AUTOCOMPACT_PCT_OVERRIDE:'50',CLAUDE_CODE_SUBAGENT_MODEL:'haiku',DISABLE_NON_ESSENTIAL_MODEL_CALLS:'1'};
for(const[k,v]of Object.entries(nenv)){if(!(k in d.env)){d.env[k]=v;a.push(k)}}
const nhooks={PreCompact:[{matcher:'',hooks:[{type:'command',command:'bash .claude/hooks/pre-compact.sh'}]}],SessionStart:[{matcher:'',hooks:[{type:'command',command:'bash .claude/hooks/session-start.sh'}]}],PostCompact:[{matcher:'',hooks:[{type:'command',command:'bash .claude/hooks/post-compact.sh'}]}]};
for(const[ev,hs]of Object.entries(nhooks)){if(!(ev in d.hooks)){d.hooks[ev]=hs;a.push('hook:'+ev)}else{const existing=JSON.stringify(d.hooks[ev]);const adding=JSON.stringify(hs);if(existing.indexOf('claudeforge')===-1&&existing.indexOf('pre-compact')===-1){d.hooks[ev]=d.hooks[ev].concat(hs);a.push('hook:'+ev)}}}
if(!d.model){d.model='sonnet';a.push('model')}
fs.writeFileSync('$DIR/settings.json',JSON.stringify(d,null,2));
console.log(a.length?'MERGED:'+a.join(','):'NONE');
" 2>&1)
        case "$result" in
            INVALID_JSON) warn "Invalid JSON — backed up, not modified" ;;
            NONE) skip "settings.json" ;;
            MERGED:*) merg "settings.json via node (${result#MERGED:})" ;;
        esac
        merge_done=true
    fi

    if ! $merge_done; then
        # Pure bash fallback — can only add env vars, not merge hooks safely
        # But this guarantees the core token optimizations are applied
        added=""
        for pair in "MAX_THINKING_TOKENS:10000" "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE:50" "CLAUDE_CODE_SUBAGENT_MODEL:haiku" "DISABLE_NON_ESSENTIAL_MODEL_CALLS:1"; do
            key="${pair%%:*}"
            val="${pair##*:}"
            if ! grep -q "\"$key\"" "$DIR/settings.json" 2>/dev/null; then
                # Insert before the last } in the env block
                sed -i "s/\"env\": {/\"env\": {\n    \"$key\": \"$val\",/" "$DIR/settings.json" 2>/dev/null
                added="$added $key"
            fi
        done
        # Add hooks block if not present
        if ! grep -q "hooks" "$DIR/settings.json" 2>/dev/null; then
            # Insert hooks with correct matcher+hooks array format
            sed -i '$ s/}/,\n  "hooks": {\n    "PreCompact": [{"matcher":"","hooks":[{"type":"command","command":"bash .claude\/hooks\/pre-compact.sh"}]}],\n    "SessionStart": [{"matcher":"","hooks":[{"type":"command","command":"bash .claude\/hooks\/session-start.sh"}]}],\n    "PostCompact": [{"matcher":"","hooks":[{"type":"command","command":"bash .claude\/hooks\/post-compact.sh"}]}]\n  }\n}/' "$DIR/settings.json" 2>/dev/null
            added="$added hooks"
        fi
        if [ -n "$added" ]; then
            merg "settings.json via bash ($added)"
        else
            skip "settings.json (already configured)"
        fi
    fi
else
    if ! $DRY; then
        cp "$SRC/source/settings.json" "$DIR/settings.json"
    fi
    ok "settings.json"
    manifest_add "$DIR/settings.json"
fi

echo -e "${BOLD}🤖 Agents:${NC}"
for f in "$SRC"/source/agents/*.md;do [ -f "$f" ]||continue;$DRY||safe_cp "$f" "$DIR/agents/$(basename "$f")" "$(basename "$f")";done
echo -e "${BOLD}📏 Rules:${NC}"
for f in "$SRC"/source/rules/*.md;do [ -f "$f" ]||continue;$DRY||safe_cp "$f" "$DIR/rules/$(basename "$f")" "$(basename "$f")";done
echo -e "${BOLD}⚡ Commands:${NC}"
for f in "$SRC"/source/commands/*.md;do [ -f "$f" ]||continue;$DRY||safe_cp "$f" "$DIR/commands/$(basename "$f")" "$(basename "$f")";done
echo -e "${BOLD}🔧 Skills:${NC}"
for d in "$SRC"/source/skills/*/;do [ -d "$d" ]||continue;n=$(basename "$d");[ "$n" = "auto-installed" ]&&continue;$DRY||safe_cpdir "$d" "$DIR/skills/$n" "$n";done
mkdir -p "$DIR/skills/auto-installed" 2>/dev/null
echo -e "${BOLD}🪝 Hooks:${NC}"
for f in "$SRC"/source/hooks/*.sh; do
    [ -f "$f" ] || continue
    n=$(basename "$f")
    if [ ! -f "$DIR/hooks/$n" ]; then
        if ! $DRY; then
            sed 's/\r$//' "$f" > "$DIR/hooks/$n"
            chmod +x "$DIR/hooks/$n"
        fi
        ok "$n"
        manifest_add "$DIR/hooks/$n"
    else
        skip "$n"
    fi
done

echo -e "${BOLD}📝 CLAUDE.md:${NC}"
if [ -f "CLAUDE.md" ]; then
    lines=$(wc -l < "CLAUDE.md")
    if grep -q "ClaudeForge" "CLAUDE.md" 2>/dev/null; then
        skip "CLAUDE.md"
    elif [ "$lines" -gt 200 ]; then
        # Large CLAUDE.md — don't append text, just add @import for preferences
        # This adds ~1 line instead of 6, avoiding degradation
        if ! grep -q "@./docs/preferences.md" "CLAUDE.md" 2>/dev/null; then
            if ! $DRY; then
                printf '\n@./docs/preferences.md\n' >> "CLAUDE.md"
            fi
            merg "CLAUDE.md (added @import only — file is $lines lines, kept lean)"
        else
            skip "CLAUDE.md (@import already present)"
        fi
        # Create the protocol as a separate rule file instead
        if ! $DRY && [ ! -f "$DIR/rules/session-protocol.md" ]; then
            cat > "$DIR/rules/session-protocol.md" << 'SPROTO'
---
name: session-protocol
description: Session start/end protocol. Read handoff on start, checkpoint before compact.
---

## Session Protocol
**Start:** Read status/handoff.md then docs/preferences.md.
**Before /compact or /clear:** Run /checkpoint first.
**End:** Run /handoff for next session continuity.
SPROTO
            ok "session-protocol rule (CLAUDE.md too large for append)"
            manifest_add "$DIR/rules/session-protocol.md"
        fi
    else
        if ! $DRY; then
            printf '\n# ClaudeForge Protocol\n- Session start: read status/handoff.md + docs/preferences.md\n- Before /compact or /clear: /checkpoint first\n- Grep before Read. No filler. Batch edits.\n@./docs/preferences.md\n' >> "CLAUDE.md"
        fi
        merg "CLAUDE.md"
    fi
else
    if ! $DRY; then
        cp "$SRC/CLAUDE.md" "CLAUDE.md"
    fi
    ok "CLAUDE.md"
    manifest_add "CLAUDE.md"
fi

echo -e "${BOLD}📂 Project files:${NC}"
for f in preferences.md ARCHITECTURE.md CONVENTIONS.md PROMPT-CHEATSHEET.md;do $DRY||safe_cp "$SRC/docs/$f" "docs/$f" "docs/$f";done
for f in current-task.md session-log.md handoff.md;do $DRY||safe_cp "$SRC/status/$f" "status/$f" "status/$f";done
$DRY||safe_cp "$SRC/claudeignore-template" ".claudeignore" ".claudeignore"
$DRY||safe_cp "$SRC/CLAUDE.local.md" "CLAUDE.local.md" "CLAUDE.local.md"

echo -e "${BOLD}📦 Registry:${NC}"
if ! $DRY; then cp -r "$SRC/skills-registry/"* skills-registry/ 2>/dev/null; ok "Registry (20 skills)"; manifest_add "skills-registry"; fi

if [ -f ".gitignore" ] && ! grep -q "claudeforge" ".gitignore" 2>/dev/null; then
    if ! $DRY; then
        printf '\n# ClaudeForge\nCLAUDE.local.md\nstatus/session-log.md\nstatus/handoff.md\n.claude/skills/auto-installed/\n.claude/.claudeforge-*\n' >> ".gitignore"
    fi
    merg ".gitignore"
fi

[ -d "$BACKUP_DIR" ]&&[ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]&&rm -rf "$BACKUP_DIR"

echo "";echo -e "${BOLD}🔍 Verifying...${NC}"
pass=0;total=0
for f in "$DIR/settings.json" "$DIR/agents/researcher.md" "$DIR/agents/architect.md" "$DIR/rules/memory-protocol.md" "$DIR/rules/safety.md" "$DIR/commands/init-project.md" "$DIR/skills/code-review/SKILL.md" "$DIR/hooks/session-start.sh";do
total=$((total+1));[ -f "$f" ]&&pass=$((pass+1))||warn "Missing: $f";done
echo -e "  ${G}$pass/$total verified${NC}"

echo ""
echo -e "${C}═══════════════════════════════════════════════════${NC}"
$DRY&&echo -e "${Y}${BOLD}DRY RUN — $CHANGES would change, $SKIPPED preserved${NC}"||echo -e "${G}${BOLD}✅ ClaudeForge v${VERSION} installed${NC}
${DIM}   $CHANGES added · $SKIPPED preserved · $WARNINGS warnings${NC}"
echo -e "${C}═══════════════════════════════════════════════════${NC}"
echo ""
echo -e "  🤖 10 agents · 🔧 12 skills · 📏 6 rules · ⚡ 10 commands · 🪝 3 hooks"
echo ""
echo -e "${BOLD}${Y}Next → in Claude Code run: /init-project${NC}"
echo -e "  Then edit ${BOLD}docs/preferences.md${NC} with your style."
echo ""
echo -e "${DIM}Undo: ./install.sh --uninstall | Preview: ./install.sh --dry-run${NC}"
echo ""
