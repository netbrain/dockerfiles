# Claude Code Docker Container
#
# Runs Claude Code CLI within a NixOS container with flake-based development environment support.
# Clones a Git repository at runtime and launches Claude Code inside the project's Nix flake environment.
#
# Key Features:
# - Automatic Git repository cloning from REPO_URL
# - Nix flake development environment integration
# - SSH key mounting for private repository access
# - Host git config and .claude directory mounting for user configuration
# - OAuth token authentication (preferred) with API key fallback
#
# Usage:
#   docker run -it --rm \
#     -v ~/.ssh:/root/.ssh:ro \
#     -v ~/.gitconfig:/root/.gitconfig:ro \
#     -v ~/.claude:/tmp/.claude:ro \
#     -v ~/.claude.json:/tmp/.claude.json:ro \
#     -e REPO_URL=git@github.com:user/repo.git \
#     claude-code
#
FROM nixos/nix:latest

# Enable Nix flakes and nix-command experimental features
# Disable sandbox for container compatibility
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
    echo "sandbox = false" >> /etc/nix/nix.conf

# Install Node.js, rsync, and jq using nix profile (modern approach, no channels needed)
RUN nix profile add nixpkgs#nodejs nixpkgs#rsync nixpkgs#jq

# Create workspace directory and SSH directory with proper permissions
RUN mkdir -p /workspace /root/.ssh && \
    chmod 700 /root/.ssh

# Copy environment documentation to /tmp (since ~/.claude will be mounted from host)
COPY CLAUDE_ENVIRONMENT.md /tmp/CLAUDE_ENVIRONMENT.md

# Copy global agents
COPY agents/ /root/.claude/agents/

WORKDIR /workspace

# Environment variables for authentication and configuration
ENV ANTHROPIC_API_KEY="" \
    REPO_URL="" \
    DISABLE_AUTOUPDATER="1" \
    DISABLE_TELEMETRY="1" \
    CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1" \
    IS_SANDBOX="1" \
    NPM_CONFIG_UPDATE_NOTIFIER="false"

# Copy and set up entrypoint script
# Handles: repo cloning, auth selection, flake activation, Claude launch
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
