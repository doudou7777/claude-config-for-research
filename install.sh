#!/usr/bin/env bash
# Claude Code Research Pack — One-Click Deploy
# Usage: bash install.sh
# Adapted from everything-claude-code, curated for scientific/research workflows.

set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
PACK_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="${CLAUDE_DIR}/backups/research-pack-$(date +%Y%m%d-%H%M%S)"

echo "============================================"
echo " Claude Code Research Pack Installer"
echo "============================================"
echo ""
echo "This will install curated agents, commands,"
echo "skills, and rules for scientific research."
echo ""

# Platform detection
case "$(uname -s)" in
  Linux*)   PLATFORM="linux" ;;
  Darwin*)  PLATFORM="macos" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *)        PLATFORM="unknown" ;;
esac

# Backup existing if any
backup_if_exists() {
  local target="$1"
  if [ -e "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -r "$target" "$BACKUP_DIR/$(basename "$target")"
    echo "  [BACKUP] $target → $BACKUP_DIR/"
  fi
}

install_dir() {
  local src="$1"
  local dest="$2"
  local label="$3"

  echo ""
  echo "▶ Installing $label..."

  mkdir -p "$dest"

  for item in "$src"/*; do
    local name=$(basename "$item")
    backup_if_exists "$dest/$name"
    if [ -d "$item" ]; then
      cp -r "$item" "$dest/"
      echo "  ✓ $name/ (directory)"
    else
      cp "$item" "$dest/"
      echo "  ✓ $name"
    fi
  done
}

# ---------- Install ----------

install_dir "$PACK_DIR/agents"   "$CLAUDE_DIR/agents"   "Agents"
install_dir "$PACK_DIR/commands" "$CLAUDE_DIR/commands" "Commands"
install_dir "$PACK_DIR/skills"   "$CLAUDE_DIR/skills"   "Skills"
install_dir "$PACK_DIR/rules/common" "$CLAUDE_DIR/rules" "Rules (common)"

# Install Python-specific rules if Python rules dir exists
mkdir -p "$CLAUDE_DIR/rules"
for f in "$PACK_DIR/rules/python"/*.md; do
  if [ -f "$f" ]; then
    name=$(basename "$f")
    backup_if_exists "$CLAUDE_DIR/rules/$name"
    cp "$f" "$CLAUDE_DIR/rules/"
    echo "  ✓ $name"
  fi
done

echo ""
echo "============================================"
echo " Installation Complete"
echo "============================================"
echo ""
echo "Installed to ~/.claude/:"
echo "  $(ls "$PACK_DIR/agents"   | wc -l) agents"
echo "  $(ls "$PACK_DIR/commands" | wc -l) commands"
echo "  $(ls "$PACK_DIR/skills"   | wc -l) skills"
echo "  $(find "$PACK_DIR/rules" -name '*.md' | wc -l) rules"
echo ""
echo "Key commands to try:"
echo "  /plan         — Plan analysis pipeline before coding"
echo "  /code-review  — Review analysis scripts for bugs"
echo "  /learn        — Extract patterns from sessions"
echo "  /verify       — Verify code correctness"
echo ""
echo "Restart Claude Code for changes to take effect."

if [ "$PLATFORM" = "windows" ]; then
  echo ""
  echo "NOTE: On Windows, also run 'install.ps1' in PowerShell"
  echo "      if you use Claude Code outside WSL."
fi
