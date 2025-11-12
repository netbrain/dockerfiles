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
        --include='CLAUDE.md' \
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
  "theme": "dark",
  "includeCoAuthoredBy": false
}'

if [ -f "/root/.claude/settings.json" ]; then
    echo "Merging default settings with host settings..."
    echo "$DEFAULT_SETTINGS" | jq -s '.[0] * .[1]' - /root/.claude/settings.json > /root/.claude/settings.json.tmp
    mv /root/.claude/settings.json.tmp /root/.claude/settings.json
else
    echo "Creating default settings.json..."
    echo "$DEFAULT_SETTINGS" | jq '.' > /root/.claude/settings.json
fi

# Clone repository as bare repo if REPO_URL environment variable is provided
if [ -n "$REPO_URL" ]; then
    echo "Cloning repository as bare repo: $REPO_URL"
    git clone --bare "$REPO_URL" /workspace/git
    cd /workspace

    # Detect default branch (try common names in order)
    DEFAULT_BRANCH=""
    for branch in main master develop; do
        if git --git-dir=git show-ref --verify --quiet "refs/heads/$branch"; then
            DEFAULT_BRANCH="$branch"
            break
        fi
    done

    # If no common branch found, use the first available branch
    if [ -z "$DEFAULT_BRANCH" ]; then
        DEFAULT_BRANCH=$(git --git-dir=git branch -r | head -n 1 | sed 's@^[[:space:]]*origin/@@' | sed 's@HEAD.*@@')
    fi

    echo "Creating default worktree from branch: $DEFAULT_BRANCH"
    git --git-dir=git worktree add "$DEFAULT_BRANCH" "$DEFAULT_BRANCH"

    # Make the worktree read-only to prevent accidental commits
    cd "$DEFAULT_BRANCH"
    git config core.fileMode false
    chmod -R a-w .git
else
    cd /workspace
fi

# Execute command or launch interactive shell
# If flake.nix exists, wrap in nix develop environment
if [ -f flake.nix ]; then
    exec nix develop --command "$@"
else
    exec "$@"
fi
