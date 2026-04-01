Scan the current project and update docs/preferences.md with detected patterns. Safe to run anytime.
1. Detect project type: package.json, requirements.txt, Cargo.toml, go.mod, etc.
2. Read 5 existing source files to detect: naming conventions, import patterns, error handling, test patterns, CSS approach.
3. Read package.json/pyproject.toml for dependencies and scripts.
4. Check config files: .eslintrc, .prettierrc, tsconfig.json, tailwind.config, etc.
5. Update docs/preferences.md with DETECTED values, preserving any user-set values.
   Only fill fields that are still placeholder text (contain '[e.g.,' or '[your').
   Never overwrite values the user has already customized.
6. Report: "Scanned [X] files. Updated: [list]. [Y] user-set values preserved."