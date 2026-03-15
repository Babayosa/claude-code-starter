#!/usr/bin/env bash
# claude-code-starter installer
# Copies templates to the right locations. Won't overwrite existing files.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATES="$SCRIPT_DIR/templates"
SKILLS="$SCRIPT_DIR/skills"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }

safe_copy() {
  local src="$1" dst="$2"
  if [ -f "$dst" ]; then
    warn "Exists: $dst (skipped — diff with $src to compare)"
  else
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    info "Copied: $dst"
  fi
}

echo ""
echo "claude-code-starter installer"
echo "=============================="
echo ""

# Global CLAUDE.md
safe_copy "$TEMPLATES/CLAUDE.md" "$HOME/CLAUDE.md"

# Skills
safe_copy "$SKILLS/commit/SKILL.md" "$HOME/.claude/skills/commit/SKILL.md"

# Tasks directory
mkdir -p "$HOME/tasks"
safe_copy "$TEMPLATES/lessons.md" "$HOME/tasks/lessons.md"

# Safety hook
safe_copy "$SCRIPT_DIR/hooks/safety-hook.sh" "$HOME/.claude/hooks/safety-hook.sh"
chmod +x "$HOME/.claude/hooks/safety-hook.sh" 2>/dev/null || true

echo ""
info "Done. Next steps:"
echo "  1. Edit ~/CLAUDE.md — replace the tech stack section with your languages"
echo "  2. Copy templates/project-CLAUDE.md into each project directory"
echo "  3. Copy templates/AGENTS.md into projects that use Codex dispatch"
echo "  4. Copy templates/MEMORY.md to ~/.claude/projects/*/memory/"
echo ""
echo "  Templates are in: $TEMPLATES/"
echo ""
