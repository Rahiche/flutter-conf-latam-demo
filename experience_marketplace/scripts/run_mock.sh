#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Running Experience Marketplace in MOCK mode (no backend)..."
echo "   USE_MOCK_DATA=true"

flutter run -d macos --dart-define=USE_MOCK_DATA=true

