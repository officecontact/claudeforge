Analyze current session for token waste.
1. Check context usage with /context.
2. Look for: large unnecessary file reads, repeated reads, long conversations without compact, main thread doing exploration (should be subagent), wrong model for task.
3. Check config: model=sonnet? auto-compact=50%? subagents=haiku?
4. Report: Optimization Report with Context %, Cost, Waste found, Fixes, What's already good.