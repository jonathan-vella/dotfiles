# PowerShell profile — cross-platform
# Symlinked to $PROFILE on install

# ── Prompt ──────────────────────────────────────────────────────────────────
function prompt {
    $cwd = (Get-Location).Path.Replace($HOME, '~')
    $branch = ''
    if (Test-Path '.git') {
        $b = git rev-parse --abbrev-ref HEAD 2>$null
        if ($b) { $branch = " `e[33m($b)`e[0m" }
    }
    "`e[1;32m$env:USERNAME`e[0m@`e[1;36m$env:COMPUTERNAME`e[0m `e[1;34m$cwd`e[0m$branch`n> "
}

# ── Aliases ──────────────────────────────────────────────────────────────────
Set-Alias -Name ll  -Value Get-ChildItem
Set-Alias -Name vi  -Value vim
Set-Alias -Name g   -Value git

# ── Functions ────────────────────────────────────────────────────────────────
function mkcd ([string]$Path) {
    New-Item -ItemType Directory -Path $Path -Force | Set-Location
}

function which ([string]$cmd) {
    Get-Command $cmd | Select-Object -ExpandProperty Source
}

function touch ([string]$File) {
    if (Test-Path $File) { (Get-Item $File).LastWriteTime = Get-Date }
    else { New-Item -ItemType File -Path $File | Out-Null }
}

# ── PSReadLine (if available) ─────────────────────────────────────────────────
if (Get-Module -ListAvailable -Name PSReadLine) {
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Tab       -Function MenuComplete
}

# ── Local overrides ──────────────────────────────────────────────────────────
$localProfile = Join-Path (Split-Path $PROFILE) 'profile.local.ps1'
if (Test-Path $localProfile) { . $localProfile }
