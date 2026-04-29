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

Install-Dir "$PACK_DIR\agents"   "$CLAUDE_DIR\agents"   "Agents"
Install-Dir "$PACK_DIR\commands" "$CLAUDE_DIR\commands" "Commands"
Install-Dir "$PACK_DIR\skills"   "$CLAUDE_DIR\skills"   "Skills"
Install-Dir "$PACK_DIR\rules\common" "$CLAUDE_DIR\rules" "Rules (common)"

# Install Python-specific rules
New-Item -ItemType Directory -Force -Path "$CLAUDE_DIR\rules" | Out-Null
Get-ChildItem "$PACK_DIR\rules\python" -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
    $target = "$CLAUDE_DIR\rules\$($_.Name)"
    Backup-IfExists $target
    Copy-Item $_.FullName $target
    Write-Host "  ✓ $($_.Name)" -ForegroundColor White
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Installation Complete" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed to $CLAUDE_DIR:"
Write-Host "  $(Get-ChildItem $PACK_DIR\agents | Measure-Object | Select-Object -ExpandProperty Count) agents"
Write-Host "  $(Get-ChildItem $PACK_DIR\commands | Measure-Object | Select-Object -ExpandProperty Count) commands"
Write-Host "  $(Get-ChildItem $PACK_DIR\skills | Measure-Object | Select-Object -ExpandProperty Count) skills"
Write-Host ""

Write-Host "Key commands to try:" -ForegroundColor White
Write-Host "  /plan         — Plan analysis pipeline before coding"
Write-Host "  /code-review  — Review analysis scripts for bugs"
Write-Host "  /learn        — Extract patterns from sessions"
Write-Host "  /verify       — Verify code correctness"
Write-Host ""
Write-Host "Restart Claude Code for changes to take effect."
