Create a new specialized agent interactively.
1. Ask: role, model (haiku/sonnet/opus), tools needed.
2. Generate .claude/agents/[name].md with: YAML frontmatter (name, description with triggers, tools, model), preferences instruction, thinking budget, focused system prompt.
3. Check if matching skill exists in registry.
4. Confirm: "Agent created. Auto-delegates on matching requests."
Guidelines: default sonnet, haiku for read-only, opus for complex reasoning. Minimal tools. Under 30 lines.