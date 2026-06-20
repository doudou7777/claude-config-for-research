# Claude Scholar Configuration

Personal Claude Code configuration for academic research and software development workflows.

## Structure

```
~/.claude/
├── CLAUDE.md              # Core instructions (auto-loaded)
├── CLAUDE.zh-CN.md        # Chinese-language variant
├── agents/                 # Custom agent definitions
├── rules/                  # Behavioral rules (coding, security, experiments, etc.)
├── commands/               # Slash commands and workflow commands
├── skills/                 # Installed skills
├── hooks/                  # Event hooks (UserPromptSubmit, etc.)
├── templates/              # Templates for various artifacts
├── plugins/                # Plugin registry (marketplaces excluded — reinstall separately)
├── settings.json           # EXCLUDED — contains API tokens (not committed)
├── settings.local.json     # EXCLUDED — local overrides
└── .gitignore
```

## Setup on a new machine

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- Git installed

### Option A: Fresh clone (recommended)

```bash
# 1. Back up any existing config
mv ~/.claude ~/.claude.bak.$(date +%Y%m%d)

# 2. Clone this repo as ~/.claude
git clone https://github.com/doudou7777/research_claude_plan.git ~/.claude

# 3. Create settings.json with your API tokens
#    Copy from backup or create fresh:
cp ~/.claude.bak.*/settings.json ~/.claude/settings.json   # if you have a backup
#    Or let Claude Code regenerate it on first run

# 4. Reinstall plugin marketplaces
#    Run Claude Code and use /plugin to re-add marketplaces,
#    or manually restore from plugins/known_marketplaces.json
```

### Option B: Symlink (keep repo elsewhere)

```bash
git clone https://github.com/doudou7777/research_claude_plan.git ~/code/claude-config
mv ~/.claude ~/.claude.bak
ln -s ~/code/claude-config ~/.claude
# Then restore settings.json as above
```

### Restore settings.json

`settings.json` contains API tokens and is **not committed**. You must recreate it:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk-ant-...",
    "ANTHROPIC_BASE_URL": "https://api.anthropic.com"
  }
}
```

Or let Claude Code generate a fresh one on first run.

## Updating

After making changes on any machine:

```bash
cd ~/.claude
git add -A
git commit -m "feat: describe what changed"
git push
```

On other machines, pull to sync:

```bash
cd ~/.claude
git pull
```

## What is NOT included

| Excluded | Reason |
|----------|--------|
| `settings.json` | API tokens |
| `settings.local.json` | Local overrides and tokens |
| `history.jsonl` | Chat history |
| `sessions/` | Session data |
| `plugins/marketplaces/` | Nested git repos — reinstall via `/plugin` |
| `projects/` | Ephemeral session artifacts |
| `.claude-scholar-backups/` | Auto-backups |
