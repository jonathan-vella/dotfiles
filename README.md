# dotfiles

Cross-platform dotfiles for shell (bash/zsh), git, VS Code, and PowerShell — managed with symlinks.

---

## Contents

| Path | What it configures |
|---|---|
| `git/.gitconfig` | Git aliases, colours, default branch, push behaviour, global gitignore |
| `git/.gitignore_global` | Global gitignore — secrets, OS files, editors, common build output |
| `shell/.profile` | Login shell: XDG dirs, `$PATH` |
| `shell/.bashrc` | Bash: history, prompt, aliases, `mkcd()` |
| `shell/.zshrc` | Zsh: history, completion, prompt, aliases, `mkcd()` |
| `vscode/settings.json` | VS Code editor, terminal, git, and Dev Containers settings |
| `powershell/Microsoft.PowerShell_profile.ps1` | PowerShell prompt, PSReadLine, `touch`/`which`/`mkcd` |
| `install.sh` | Symlink installer — Linux & macOS |
| `install.ps1` | Symlink installer — Windows (PowerShell 7+) |

---

## Security (public repo)

This repo is public. Keep the following in mind:

- **No secrets, tokens, or passwords** should ever be committed here. The repo-level `.gitignore` and the global `.gitignore_global` both guard against the most common cases, but they are not a substitute for care.
- **Use local override files** (see [Local overrides](#local-overrides)) for anything machine-specific or sensitive.
- **`git/.gitconfig` contains your name and email.** This is intentional for a personal dotfiles repo — your identity is already public on GitHub. If you fork this for someone else or a work context, update those values.
- If you ever accidentally commit a secret, assume it is compromised. Rotate the credential immediately, then remove it from git history with `git filter-repo` or BFG.

---

## First-time setup

### 1. Clone the repo

**Linux / macOS**
```bash
git clone https://github.com/jonathan-vella/dotfiles.git ~/dotfiles
```

**Windows**
```powershell
git clone https://github.com/jonathan-vella/dotfiles.git $HOME\dotfiles
```

---

### 2. Check your git identity

`git/.gitconfig` already contains a name and email. If you're setting this up on a new machine for yourself, you're good. If you forked this repo, update those values before running the installer:

```ini
[user]
    name  = Your Name
    email = you@example.com
```

---

### 3. Run the installer

The installer creates symlinks from your home directory into the repo. It also wires up `~/.gitignore_global` so your global gitignore is active in every repo on the machine.  
Any file that already exists is backed up to `<file>.bak` before being replaced.

**Linux / macOS**
```bash
cd ~/dotfiles
chmod +x install.sh   # only needed once; or run: git update-index --chmod=+x install.sh && git push
./install.sh
```

**Windows — PowerShell 7+ (run as Administrator _or_ enable Developer Mode first)**
```powershell
cd $HOME\dotfiles
.\install.ps1
```

> **Windows symlink note:** Symlinks require either **Developer Mode** (`Settings → System → For developers → Developer Mode`) or an **elevated (Administrator) shell**. Developer Mode is the easier option — it lets any process create symlinks without elevation.

---

### 4. Apply the VS Code settings (first machine only)

The installer symlinks `vscode/settings.json` into VS Code's user config directory, but this only takes effect after the symlink is in place. If you want to apply the settings immediately without re-opening VS Code, reload the window:

```
Ctrl+Shift+P → Developer: Reload Window
```

---

## Dev Containers — automatic dotfiles in every container

VS Code Dev Containers can clone and install your dotfiles automatically every time a container is created. The settings are already included in `vscode/settings.json`:

```jsonc
"dotfiles.repository": "https://github.com/jonathan-vella/dotfiles",
"dotfiles.targetPath": "~/dotfiles",
"dotfiles.installCommand": "bash ~/dotfiles/install.sh"
```

**What these do:**
- `dotfiles.repository` — the repo Dev Containers clones inside every new container.
- `dotfiles.targetPath` — where it's cloned inside the container (`~/dotfiles`).
- `dotfiles.installCommand` — the script Dev Containers runs after cloning.

**To activate this on your local VS Code right now** (before the symlink is applied), open your user `settings.json` (`Ctrl+Shift+P` → *Open User Settings (JSON)*) and paste the three lines above.

**Important — keep `install.sh` executable in git:**  
If the executable bit is not tracked, Dev Containers will fail to run the script silently. Set it once:

```bash
cd ~/dotfiles
git update-index --chmod=+x install.sh
git commit -m "chore: mark install.sh executable"
git push
```

After this, every dev container you open will automatically have your:
- Git aliases, global gitignore, and config
- Bash / zsh aliases, prompt, and helper functions
- Shell history settings

> PowerShell and VS Code editor settings do not apply inside Linux containers (no PowerShell by default; VS Code settings come from the host, not the container). Everything shell- and git-related will work.

---

## Local overrides

Use local override files for machine-specific config that should **never be committed** (work proxies, private tokens, machine-specific paths, etc.).  
These filenames are listed in `.gitignore`.

| Override file | Loaded by |
|---|---|
| `~/.bashrc.local` | `shell/.bashrc` |
| `~/.zshrc.local` | `shell/.zshrc` |
| `profile.local.ps1` (same dir as `$PROFILE`) | `powershell/Microsoft.PowerShell_profile.ps1` |

Example — add a work-only alias in `~/.bashrc.local`:
```bash
export HTTP_PROXY="http://proxy.corp.example.com:8080"
alias vpn='sudo openconnect vpn.corp.example.com'
```

---

## Keeping dotfiles up to date

Pull the latest changes on any machine:

```bash
cd ~/dotfiles && git pull
```

No re-linking needed — symlinks always point to the repo files, so updates take effect immediately (reload your shell for shell config changes).

---

## Adding a new dotfile

1. Copy the file into the appropriate subfolder (or create a new one).
2. Add a `link` / `New-Symlink` call in `install.sh` **and** `install.ps1`.
3. Commit and push.
4. Run the installer (or just `ln -sf` / `New-Item -ItemType SymbolicLink` manually) on any existing machine.

---

## Repo structure

```
dotfiles/
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── shell/
│   ├── .profile
│   ├── .bashrc
│   └── .zshrc
├── vscode/
│   └── settings.json
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1
├── install.sh          ← Linux / macOS installer
├── install.ps1         ← Windows / pwsh installer
├── .gitignore
├── LICENSE
└── README.md
```
