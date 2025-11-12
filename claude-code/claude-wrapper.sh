#!/usr/bin/env bash
# Wrapper script to launch Claude Code with proper configuration

SYSTEM_PROMPT="Read /tmp/CLAUDE_ENVIRONMENT.md for details about your environment."

if [ -n "$ANTHROPIC_API_KEY" ]; then
    exec npx -y @anthropic-ai/claude-code --api-key "$ANTHROPIC_API_KEY" --dangerously-skip-permissions --system-prompt "$SYSTEM_PROMPT" "$@"
else
    exec npx -y @anthropic-ai/claude-code --dangerously-skip-permissions --system-prompt "$SYSTEM_PROMPT" "$@"
fi
