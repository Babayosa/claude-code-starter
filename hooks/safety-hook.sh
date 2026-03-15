#!/usr/bin/env bash
# Claude Code safety hook — blocks dangerous commands before execution.
# Install: Add to your Claude Code settings as a Bash tool hook,
# or use as a pre-commit hook template.
#
# Blocks:
#   - rm (use trash instead)
#   - lint suppression comments
#   - hook-skipping flags (--no-verify, --no-gpg-sign)
#   - force pushes to main/master
#
# Usage in Claude Code settings (~/.claude/settings.json):
# {
#   "hooks": {
#     "Bash": {
#       "pre": "bash /path/to/safety-hook.sh \"$COMMAND\""
#     }
#   }
# }

set -euo pipefail

COMMAND="${1:-}"

# Block rm (use trash instead)
if echo "$COMMAND" | grep -qE '(^|[;&|]\s*)rm\s'; then
  echo "BLOCKED: Use 'trash' instead of 'rm'."
  exit 1
fi

# Block lint suppression comments
if echo "$COMMAND" | grep -qE '(swiftlint:disable|eslint-disable|biome-ignore|nolint|noqa|rubocop:disable|stylelint-disable)'; then
  echo "BLOCKED: No lint suppression comments. Fix the actual issue."
  exit 1
fi

# Block hook-skipping
if echo "$COMMAND" | grep -qE '\-\-no-verify|\-\-no-gpg-sign'; then
  echo "BLOCKED: Never skip hooks. Fix the underlying issue."
  exit 1
fi

# Block force push to main/master
if echo "$COMMAND" | grep -qE 'git\s+push\s+.*--force.*\s+(main|master)'; then
  echo "BLOCKED: Never force push to main/master."
  exit 1
fi

exit 0
