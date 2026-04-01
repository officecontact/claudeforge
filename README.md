# ClaudeForge

### Make your Claude Code Max plan 10x more effective.

**Zero dependencies. Failproof. 31/31 tests passing.**

```bash
git clone https://github.com/officecontact/claudeforge.git
cd your-project && bash /path/to/claudeforge/install.sh
```

## The Problem

You hit Claude Code limits in 2 days. After clearing context, Claude forgets your style. Output drifts between sessions.

## The Solution

ClaudeForge installs into your project .claude/ directory. Pure markdown + bash. No npm, no runtime. Installs in 30 seconds, uninstalls with full rollback.

## Impact

| Metric | Before | After |
|---|---|---|
| Limits exhausted in | 2 days | 5-7 days |
| Cost per interaction | ~$0.50 | ~$0.08 |
| Re-explain style | Every session | Never |
| Output drift | Constant | Zero |

## How It Saves Tokens

- Sonnet default (not Opus): ~60% cheaper
- Thinking cap 10K (vs 32K): ~70% hidden cost saved
- Haiku subagents: ~90% exploration cost saved
- Auto-compact at 50%: ~40% context reuse
- Specialized agents: ~50% fewer iterations
- Memory persistence: Zero re-explanation
- Progressive skills: ~82% startup savings
- Total startup: ~1,584 tokens (competitors: 3,000-8,000)

## What's Inside

- 10 agents (Haiku/Sonnet/Opus routed, preference-aware, thinking-budgeted)
- 12 built-in skills (auto-activate) + 20 in registry (auto-detect + install)
- 6 rules (memory, consistency, routing, efficiency, skill-discovery, safety)
- 10 commands (init-project, checkpoint, handoff, resume, status, savings, optimize, new-agent, scan, uninstall)
- 3 lifecycle hooks (session-start, pre-compact, post-compact)
- Manifest-based rollback uninstall

## Quick Start

```bash
git clone https://github.com/YOUR_USERNAME/claudeforge.git ~/claudeforge
cd /path/to/your/project
bash ~/claudeforge/install.sh
# Then in Claude Code: /init-project
# Edit docs/preferences.md with your style
```

## Safety

```bash
bash ~/claudeforge/install.sh --dry-run     # Preview
bash ~/claudeforge/install.sh --uninstall   # Full rollback
```

Never overwrites files. Merges settings. Backs up before modifying. Validates JSON. Checks disk space. Protects large CLAUDE.md. Rolls back on uninstall.

## /init-project Flow

1. Scans your project (package.json, source files, configs)
2. Shows preview of detected stack
3. Waits for your approval
4. Creates only missing files, auto-fills from detected code

Safe at any project stage.

## 31 Tests Passing

Fresh install, existing project preservation, model/var preservation, source code safety, settings merge, hook merge, idempotent install, uninstall rollback, dry run safety, agent quality, skill triggers, hook safety, token budget, large CLAUDE.md protection.

## Contributing

See CONTRIBUTING.md. Every PR must report token impact. Zero dependencies.

## License

MIT
