#!/usr/bin/env bash
# Claude Code Research Pack — One-Click Deploy
# Usage: bash install.sh
# Curated configuration for academic research workflows.

set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
PACK_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="${CLAUDE_DIR}/backups/research-pack-$(date +%Y%m%d-%H%M%S)"

echo "============================================"
echo " Claude Code Research Pack Installer"
echo "============================================"
echo ""
echo "This will install curated agents, commands,"
echo "skills, rules, hooks, and config for"
echo "academic research workflows."
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
install_dir "$PACK_DIR/hooks"    "$CLAUDE_DIR/hooks"    "Hooks"

# Install rules to correct subdirs
echo ""
echo "▶ Installing Rules..."
mkdir -p "$CLAUDE_DIR/rules"
for f in "$PACK_DIR/rules/common"/*.md; do
  if [ -f "$f" ]; then
    name=$(basename "$f")
    backup_if_exists "$CLAUDE_DIR/rules/$name"
    cp "$f" "$CLAUDE_DIR/rules/"
    echo "  ✓ $name"
  fi
done
for f in "$PACK_DIR/rules/python"/*.md; do
  if [ -f "$f" ]; then
    name=$(basename "$f")
    backup_if_exists "$CLAUDE_DIR/rules/$name"
    cp "$f" "$CLAUDE_DIR/rules/"
    echo "  ✓ $name"
  fi
done

# Install CLAUDE.md (global instructions)
echo ""
echo "▶ Installing CLAUDE.md..."
backup_if_exists "$CLAUDE_DIR/CLAUDE.md"
cp "$PACK_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  ✓ CLAUDE.md"

# Copy settings template (user merges manually)
echo ""
echo "▶ Copying settings template..."
cp "$PACK_DIR/settings.template.json" "$CLAUDE_DIR/settings.template.json"
echo "  ✓ settings.template.json (review & merge into settings.json)"

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
echo "  $(ls "$PACK_DIR/hooks"    | wc -l) hooks"
echo ""
echo "── Marketplaces & Plugins ──"
echo ""
echo "This pack uses Claude Code plugins for some skills."
echo "Add these to your settings.json if not already present:"
echo ""
echo "  \"extraKnownMarketplaces\": {"
echo "    \"karpathy-skills\": {"
echo "      \"source\": { \"source\": \"github\", \"repo\": \"forrestchang/andrej-karpathy-skills\" }"
echo "    },"
echo "    \"nature-skills\": {"
echo "      \"source\": { \"source\": \"github\", \"repo\": \"Yuan1z0825/nature-skills\" }"
echo "    }"
echo "  },"
echo "  \"enabledPlugins\": {"
echo "    ..."
echo "    \"andrej-karpathy-skills@karpathy-skills\": true,"
echo "    \"nature-skills@nature-skills\": true"
echo "  }"
echo ""
echo "Then run: claude plugin install nature-skills@nature-skills"
echo ""
echo "Key commands to try:"
echo "  /plan         — Plan implementation before coding"
echo "  /code-review  — Review code for bugs & quality"
echo "  /learn        — Extract patterns from sessions"
echo "  /verify       — Verify code correctness"
echo "  /rebuttal     — Write reviewer response"
echo "  /commit       — Create conventional commits"
echo ""
echo "Restart Claude Code for changes to take effect."

if [ "$PLATFORM" = "windows" ]; then
  echo ""
  echo "NOTE: On Windows, also run 'install.ps1' in PowerShell"
  echo "      if you use Claude Code outside WSL."
fi
