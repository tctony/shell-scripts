#!/bin/sh

# copy_current_git_commit_hash.sh - Copy current git commit hash to clipboard
# Usage: ./copy_current_git_commit_hash.sh [--short]

set -e

# Parse command line arguments
USE_SHORT=false
while [ $# -gt 0 ]; do
  case "$1" in
    --short|-s)
      USE_SHORT=true
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--short|-s] [--help|-h]"
      echo "Copy current git commit hash to clipboard"
      echo ""
      echo "Options:"
      echo "  --short, -s    Use short commit hash (7 characters)"
      echo "  --help, -h     Show this help message"
      exit 0
      ;;
    *)
      echo "Error: Unknown option '$1'"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Check if git is available
if ! command -v git >/dev/null 2>&1; then
  echo "Error: git is required but not installed. Please install git first."
  exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Error: Not in a git repository"
  exit 1
fi

# Get commit hash
if [ "$USE_SHORT" = true ]; then
  COMMIT_HASH=$(git rev-parse --short HEAD)
  echo "Short commit hash: $COMMIT_HASH"
else
  COMMIT_HASH=$(git rev-parse HEAD)
  echo "Full commit hash: $COMMIT_HASH"
fi

# Copy to clipboard based on platform
case "$(uname -s)" in
  Darwin)
    # macOS
    echo "$COMMIT_HASH" | pbcopy
    echo "✓ Copied to clipboard (macOS)"
    ;;
  Linux)
    # Linux - try different clipboard utilities
    if command -v xclip >/dev/null 2>&1; then
      echo "$COMMIT_HASH" | xclip -selection clipboard
      echo "✓ Copied to clipboard (Linux/xclip)"
    elif command -v xsel >/dev/null 2>&1; then
      echo "$COMMIT_HASH" | xsel --clipboard --input
      echo "✓ Copied to clipboard (Linux/xsel)"
    else
      echo "Error: No clipboard utility found. Please install xclip or xsel"
      echo "Commit hash: $COMMIT_HASH"
      exit 1
    fi
    ;;
  CYGWIN*|MINGW*|MSYS*)
    # Windows
    echo "$COMMIT_HASH" | clip
    echo "✓ Copied to clipboard (Windows)"
    ;;
  *)
    echo "Error: Unsupported platform $(uname -s)"
    echo "Commit hash: $COMMIT_HASH"
    exit 1
    ;;
esac
