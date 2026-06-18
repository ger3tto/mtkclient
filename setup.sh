#!/bin/bash

set -e

echo "[*] Copying udev rules..."
sudo cp Setup/Linux/52-mtk.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
echo "[+] udev rules installed."

echo "[*] Installing dependencies system-wide with uv..."
if ! command -v uv &>/dev/null; then
    echo "[!] uv not found, installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    . "$HOME/.cargo/env" 2>/dev/null || true
fi

uv sync --system
echo "[+] Setup complete. Run: sudo python3 mtk.py da seccfg unlock ..."
