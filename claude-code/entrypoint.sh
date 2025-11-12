#!/usr/bin/env bash
set -e

# Configure SSH to accept unknown hosts
mkdir -p /root/.ssh
cat > /root/.ssh/config <<EOF
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
chmod 600 /root/.ssh/config

# Merge host .claude config with built-in config
# This allows host agents/skills to override defaults while keeping built-ins
if [ -d "/tmp/.claude" ]; then
    echo "Merging host .claude config with built-in config..."
    rsync -av \
        --include='settings.json' \
        --include='.credentials.json' \
        --include='agents/' \
        --include='agents/**' \
        --include='skills/' \
        --include='skills/**' \
        --exclude='*' \
        /tmp/.claude/ /root/.claude/
fi

# Merge essential fields from .claude.json (prevents account/onboarding prompts)
if [ -f "/tmp/.claude.json" ]; then
    echo "Merging essential fields from .claude.json..."
    # Extract only the fields needed to skip onboarding and authentication
    jq '{
        oauthAccount: .oauthAccount,
        hasCompletedOnboarding: .hasCompletedOnboarding,
        userID: .userID
    }' /tmp/.claude.json > /root/.claude.json
fi

# Merge default settings with host settings using jq
DEFAULT_SETTINGS='{
  "permissions": {
    "defaultMode": "bypassPermissions"
  },
  "theme": "dark"
}'

if [ -f "/root/.claude/settings.json" ]; then
    echo "Merging default settings with host settings..."
    echo "$DEFAULT_SETTINGS" | jq -s '.[0] * .[1]' - /root/.claude/settings.json > /root/.claude/settings.json.tmp
    mv /root/.claude/settings.json.tmp /root/.claude/settings.json
else
    echo "Creating default settings.json..."
    echo "$DEFAULT_SETTINGS" | jq '.' > /root/.claude/settings.json
fi

# Clone repository if REPO_URL environment variable is provided
if [ -n "$REPO_URL" ]; then
    echo "Cloning repository: $REPO_URL"
    git clone "$REPO_URL" /workspace
fi

cd /workspace

# Build Claude CLI command with authentication and system prompt
# Uses .credentials.json for OAuth (copied via rsync) or ANTHROPIC_API_KEY if provided
SYSTEM_PROMPT="Read /tmp/CLAUDE_ENVIRONMENT.md for details about your environment."

if [ -n "$ANTHROPIC_API_KEY" ]; then
    CLAUDE_CMD="npx -y @anthropic-ai/claude-code --api-key $ANTHROPIC_API_KEY --dangerously-skip-permissions --system-prompt \"$SYSTEM_PROMPT\""
else
    CLAUDE_CMD="npx -y @anthropic-ai/claude-code --dangerously-skip-permissions --system-prompt \"$SYSTEM_PROMPT\""
fi

# Launch Claude Code inside Nix flake development shell if flake.nix exists,
# otherwise launch directly. This ensures all project dependencies are available.
if [ -f flake.nix ]; then
    exec nix develop --command $CLAUDE_CMD "$@"
else
    exec $CLAUDE_CMD "$@"
fi
