#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
REPO_URL="https://raw.githubusercontent.com/relferreira/linear-ralph/main"

echo "Installing linear-ralph..."

mkdir -p "$INSTALL_DIR"

curl -fsSL "$REPO_URL/linear-ralph.sh" -o "$INSTALL_DIR/linear-ralph"
chmod +x "$INSTALL_DIR/linear-ralph"

echo "Installed linear-ralph to $INSTALL_DIR/linear-ralph"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "Add this to your ~/.zshrc or ~/.bashrc:"
  echo ""
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo ""
  echo "Then restart your terminal or run: source ~/.zshrc"
else
  echo ""
  echo "Run 'linear-ralph <ticket-id>' from your project directory to get started."
fi
