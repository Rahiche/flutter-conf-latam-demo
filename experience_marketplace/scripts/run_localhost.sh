#!/bin/bash

# Run the Experience Marketplace app with localhost server
echo "🔧 Starting Experience Marketplace with LOCALHOST server..."
echo "📍 Server: http://localhost:8080/"
echo "⚠️  Make sure your local Serverpod server is running!"
echo ""

flutter run --dart-define=USE_LOCALHOST=true