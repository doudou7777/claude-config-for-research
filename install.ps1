# Claude Code Research Pack — One-Click Deploy (Windows PowerShell)
# Usage: .\install.ps1
# Adapted from everything-claude-code, curated for scientific/research workflows.

$ErrorActionPreference = "Stop"

$CLAUDE_DIR = "$env:USERPROFILE\.claude"
$PACK_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$BACKUP_DIR = "$CLAUDE_DIR\backups\research-pack-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Claude Code Research Pack Installer" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will install curated agents, commands,"
Write-Host "skills, and rules for scientific research."
Write-Host ""

function Backup-IfExists {
    param([string]$Target)
    if (Test-Path $Target) {
        New-Item -ItemType Directory -Force -Path $BACKUP_DIR | Out-Null
        $name = Split-Path -Leaf $Target
        Copy-Item -Recurse $Target "$BACKUP_DIR\$name"
        Write-Host "  [BACKUP] $Target -> $BACKUP_DIR\" -ForegroundColor Yellow
    }
}

function Install-Dir {
    param(
        [string]$Source,
        [string]$Dest,
        [string]$Label
    )

    Write-Host ""
    Write-Host "▶ Installing $Label..." -ForegroundColor Green

    New-Item -ItemType Directory -Force -Path $Dest | Out-Null

    Get-ChildItem $Source | ForEach-Object {
        $target = "$Dest\$($_.Name)"
        Backup-IfExists $target
        Copy-Item -Recurse $_.FullName $Dest
        $typeIndicator = if ($_.PSIsContainer) { " (directory)" } else { "" }
        Write-Host "  ✓ $($_.Name)$typeIndicator" -ForegroundColor White
    }
}

# ---------- Install ----------

Install-Dir "$PACK_DIR\agents"      "$CLAUDE_DIR\agents"      "Agents"
Install-Dir "$PACK_DIR\commands"    "$CLAUDE_DIR\commands"    "Commands"
Install-Dir "$PACK_DIR\skills"      "$CLAUDE_DIR\skills"      "Skills"
Install-Dir "$PACK_DIR\contexts"    "$CLAUDE_DIR\contexts"    "Contexts"
Install-Dir "$PACK_DIR\mcp-servers" "$CLAUDE_DIR\mcp-servers" "MCP Servers"
Install-Dir "$PACK_DIR\scripts"     "$CLAUDE_DIR\scripts"     "Scripts"
Install-Dir "$PACK_DIR\templates"   "$CLAUDE_DIR\templates"   "Templates"
Install-Dir "$PACK_DIR\rules\common" "$CLAUDE_DIR\rules" "Rules (common)"

# Install Python-specific rules
New-Item -ItemType Directory -Force -Path "$CLAUDE_DIR\rules" | Out-Null
Get-ChildItem "$PACK_DIR\rules\python" -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
    $target = "$CLAUDE_DIR\rules\$($_.Name)"
    Backup-IfExists $target
    Copy-Item $_.FullName $target
    Write-Host "  ✓ $($_.Name)" -ForegroundColor White
}

# Install hooks
Install-Dir "$PACK_DIR\hooks" "$CLAUDE_DIR\hooks" "Hooks"

# Install CLAUDE.md
Write-Host ""
Write-Host "▶ Installing CLAUDE.md..." -ForegroundColor Green
Backup-IfExists "$CLAUDE_DIR\CLAUDE.md"
Copy-Item "$PACK_DIR\CLAUDE.md" "$CLAUDE_DIR\CLAUDE.md"
Write-Host "  ✓ CLAUDE.md"
if (Test-Path "$PACK_DIR\CLAUDE.zh-CN.md") {
    Backup-IfExists "$CLAUDE_DIR\CLAUDE.zh-CN.md"
    Copy-Item "$PACK_DIR\CLAUDE.zh-CN.md" "$CLAUDE_DIR\CLAUDE.zh-CN.md"
    Write-Host "  ✓ CLAUDE.zh-CN.md"
}

# Install plugins config
Write-Host ""
Write-Host "▶ Installing Plugins config..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path "$CLAUDE_DIR\plugins" | Out-Null
Get-ChildItem "$PACK_DIR\plugins" -Filter "*.json" -ErrorAction SilentlyContinue | ForEach-Object {
    $target = "$CLAUDE_DIR\plugins\$($_.Name)"
    Backup-IfExists $target
    Copy-Item $_.FullName $target
    Write-Host "  ✓ plugins\$($_.Name)" -ForegroundColor White
}
Get-ChildItem "$PACK_DIR\plugins" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $target = "$CLAUDE_DIR\plugins\$($_.Name)"
    Backup-IfExists $target
    Copy-Item -Recurse $_.FullName $target
    Write-Host "  ✓ plugins\$($_.Name) (directory)" -ForegroundColor White
}

# Install settings template
Write-Host ""
Write-Host "▶ Copying settings template..."
Copy-Item "$PACK_DIR\settings.template.json" "$CLAUDE_DIR\settings.template.json"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Installation Complete" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed to $CLAUDE_DIR:"
Write-Host "  $(Get-ChildItem $PACK_DIR\agents | Measure-Object | Select-Object -ExpandProperty Count) agents"
Write-Host "  $(Get-ChildItem $PACK_DIR\commands | Measure-Object | Select-Object -ExpandProperty Count) commands"
Write-Host "  $(Get-ChildItem $PACK_DIR\skills | Measure-Object | Select-Object -ExpandProperty Count) skills"
Write-Host "  $(Get-ChildItem $PACK_DIR\contexts | Measure-Object | Select-Object -ExpandProperty Count) contexts"
Write-Host "  $(Get-ChildItem $PACK_DIR\mcp-servers | Measure-Object | Select-Object -ExpandProperty Count) mcp-servers"
Write-Host ""

Write-Host "Key commands to try:" -ForegroundColor White
Write-Host "  /plan         — Plan analysis pipeline before coding"
Write-Host "  /code-review  — Review analysis scripts for bugs"
Write-Host "  /learn        — Extract patterns from sessions"
Write-Host "  /verify       — Verify code correctness"
Write-Host ""
Write-Host "Restart Claude Code for changes to take effect."
