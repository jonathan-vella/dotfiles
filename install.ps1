#!/usr/bin/env pwsh
# install.ps1 — create symlinks for all dotfiles (Windows / cross-platform PowerShell)
#Requires -Version 7

$ErrorActionPreference = 'Stop'
$DotfilesDir = $PSScriptRoot

function New-Symlink {
    param([string]$Src, [string]$Dst)
    $dir = Split-Path $Dst
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if ((Test-Path $Dst) -and -not ((Get-Item $Dst).LinkType)) {
        Write-Host "  [backup] $Dst -> $Dst.bak"
        Move-Item $Dst "$Dst.bak" -Force
    }
    if (Test-Path $Dst) { Remove-Item $Dst -Force }
    New-Item -ItemType SymbolicLink -Path $Dst -Target $Src | Out-Null
    Write-Host "  linked: $Dst"
}

# VS Code settings path
$VsCodeSettings = Join-Path $env:APPDATA 'Code\User\settings.json'

Write-Host '==> Linking git'
New-Symlink "$DotfilesDir\git\.gitconfig" "$HOME\.gitconfig"

Write-Host '==> Linking PowerShell profile'
New-Symlink "$DotfilesDir\powershell\Microsoft.PowerShell_profile.ps1" $PROFILE

Write-Host '==> Linking VS Code settings'
New-Symlink "$DotfilesDir\vscode\settings.json" $VsCodeSettings

Write-Host ''
Write-Host 'Done! Restart your shell or run: . $PROFILE'
