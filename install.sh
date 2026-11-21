
#!/usr/bin/env bash
set -e

if ! command -v python3 >/dev/null 2>&1; then
    echo "Python 3 is required."
    exit 1
fi

INSTALL_DIR="$HOME/.local/share/meet-launcher"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR" "$BIN_DIR"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR/meet.py" "$INSTALL_DIR/meet.py"

cat > "$BIN_DIR/meet" <<EOF
#!/usr/bin/env bash
exec python3 "$INSTALL_DIR/meet.py" "\$@"
EOF

chmod +x "$BIN_DIR/meet"

echo "Installed successfully!"

