# NixOS Container Environment

You're running in a NixOS Docker container with Nix package management.

## Key Tools
- **Nix packages**: `nix-shell -p <package>` (temporary) or `nix-env -iA nixpkgs.<package>` (permanent)
- **Nix flakes**: Auto-activated if `flake.nix` exists in workspace
- **Pre-installed**: git, openssh, nodejs, npx, rsync, jq

## Environment
- **Workspace**: `/workspace` (repo cloned here if REPO_URL provided)
- **SSH keys**: `/root/.ssh` (read-only from host)
- **Git config**: `/root/.gitconfig` (from host)
- **Claude config**: Synced from host `~/.claude` (agents, skills, settings, credentials)

## Best Practices
- Use `nix-shell -p` for one-off commands
- Add project dependencies to `flake.nix` (not global installs)
- All Nix installs are isolated and reproducible
