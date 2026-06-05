# Contributing to claude-code-starter

Thank you for improving this starter kit. Contributions that sharpen safety rules, add stack-specific templates, or fix bugs in the install script are all welcome.

## Getting Started

```bash
git clone https://github.com/Babayosa/claude-code-starter.git
cd claude-code-starter
```

No build step or package manager is needed. The repo is plain shell scripts and Markdown files.

## Running the Safety Hook

Test the hook directly before wiring it into settings:

```bash
bash hooks/safety-hook.sh "rm -rf foo"          # should exit 1 (BLOCKED)
bash hooks/safety-hook.sh "git status"           # should exit 0
```

## Testing the Installer

Run a dry-run against a temp home directory to confirm `install.sh` copies to the right locations and skips existing files:

```bash
HOME=/tmp/test-install bash install.sh
ls /tmp/test-install/.claude/hooks/safety-hook.sh   # should exist
ls /tmp/test-install/CLAUDE.md                       # should exist
```

Clean up with `rm -rf /tmp/test-install` after (outside Claude Code, where `rm` is permitted).

## What to Contribute

| Area | Where to look |
|------|--------------|
| New language stack template | Add a section to `templates/CLAUDE.md` under `## Cross-Project Tech Stack` |
| New project-level pattern | `templates/project-CLAUDE.md` |
| Safety hook rule | `hooks/safety-hook.sh` — add a guarded `grep -qE` block with a clear BLOCKED message |
| New Claude Code skill | `skills/<name>/SKILL.md` — follow the existing `commit` skill as a reference |
| Install script fix | `install.sh` — keep it POSIX-compatible (`#!/usr/bin/env bash`, `set -euo pipefail`) |

## Code Style

- Shell scripts: `#!/usr/bin/env bash` shebang, `set -euo pipefail`, 2-space indent.
- Markdown: ATX headings (`#`), fenced code blocks with language tags, no trailing whitespace.
- No lint-suppression comments. Fix the root cause instead.
- Keep templates lean — only include rules that Claude would get wrong without them.

## Opening Issues

Before opening a bug report, check that:
1. You are on the latest commit from `main`.
2. The hook exit code matches the expected behavior described in `hooks/safety-hook.sh`.
3. The install script was run without `sudo` (it targets `$HOME`, not system paths).

Include: OS, shell version (`bash --version`), and the exact command that failed.

## Pull Requests

1. Fork the repo and create a feature branch off `main`.
2. Make your change, test it (see above).
3. Open a PR with a short title describing what changed and why.
4. One logical change per PR — keep diffs easy to review.

No CLA required. Contributions are accepted under the project's MIT license.
