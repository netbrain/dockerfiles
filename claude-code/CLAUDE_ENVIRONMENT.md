# NixOS Container Environment

You're running in a NixOS Docker container with Nix package management.

## Key Tools
- **Nix packages**: `nix-shell -p <package>` (temporary) or `nix-env -iA nixpkgs.<package>` (permanent)
- **Nix flakes**: Auto-activated if `flake.nix` exists in workspace
- **Pre-installed**: git, openssh, nodejs, npx, rsync, jq, gh (GitHub CLI)

## Environment
- **Workspace**: `/workspace` (repo cloned as bare repo here if REPO_URL provided)
- **SSH keys**: `/root/.ssh` (read-only from host)
- **Git config**: `/root/.gitconfig` (from host)
- **GitHub CLI config**: `/root/.config/gh` (from host `~/.config/gh`, mount with `-v ~/.config/gh:/root/.config/gh:ro`)
- **Claude config**: Synced from host `~/.claude` (agents, skills, settings, credentials)

## Git Worktree Workflow
When REPO_URL is provided, the repository is cloned as a **bare repository** at `/workspace/.bare` to support parallel work on multiple issues.

### Working with Worktrees
- **Default worktree**: Automatically created from the main branch at `/workspace/<branch-name>`
- **Create new worktree**: `git --git-dir=/workspace/.bare worktree add <path> <branch>`
  - Example: `git --git-dir=/workspace/.bare worktree add ../issue-123 -b feature/issue-123`
- **List worktrees**: `git --git-dir=/workspace/.bare worktree list`
- **Remove worktree**: `git --git-dir=/workspace/.bare worktree remove <path>`

### Best Practices
- Create a separate worktree for each issue/feature you're working on
- This allows you to work on multiple issues simultaneously without branch switching
- Each worktree is a separate working directory but shares the same `.bare` repository
- Use descriptive names for worktree paths (e.g., `issue-123`, `feature-auth`, `bugfix-login`)

## Nix Best Practices
- Use `nix-shell -p` for one-off commands
- Add project dependencies to `flake.nix` (not global installs)
- All Nix installs are isolated and reproducible
