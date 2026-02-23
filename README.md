# dotfiles

Cross-platform dotfiles for shell, git, VS Code, and PowerShell, managed with symlinks.

## Structure

```
dotfiles/
├── git/
│   └── .gitconfig              # Git global config
├── shell/
│   ├── .profile                # Login shell env
│   ├── .bashrc                 # Bash interactive config
│   └── .zshrc                  # Zsh interactive config
├── vscode/
│   └── settings.json           # VS Code user settings
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1  # PowerShell profile
├── install.sh                  # Symlink installer (Linux / macOS)
├── install.ps1                 # Symlink installer (Windows / pwsh)
└── .gitignore
```

## Setup

### Linux / macOS

```bash
git clone https://github.com/jonathan-vella/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### Windows (PowerShell 7+, run as Administrator for symlinks)

```powershell
git clone https://github.com/jonathan-vella/dotfiles.git $HOME\dotfiles
Set-Location $HOME\dotfiles
.\install.ps1
```

> **Note:** Windows requires **Developer Mode** to be enabled (or an elevated shell) to create symlinks without admin rights.

## Local overrides

Create a local override file that is **never committed** to customise settings per machine:

| File | Purpose |
|------|--------------------| 
| `~/.bashrc.local` | Machine-specific bash config |
| `~/.zshrc.local` | Machine-specific zsh config |
| `profile.local.ps1` (next to `$PROFILE`) | Machine-specific PowerShell config |

## Updating

```bash
cd ~/dotfiles && git pull
```

No re-linking needed — symlinks always point to the latest files.
