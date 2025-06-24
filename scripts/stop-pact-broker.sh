#!/bin/bash

# Pact Broker Stop Script
# Cleanly stops the Pact Broker infrastructure

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$(dirname "$SCRIPT_DIR")/docker-compose.pact-broker.yml"

echo "🛑 Stopping Pact Broker Infrastructure..."
echo "📍 Using compose file: $COMPOSE_FILE"

# Stop the services
docker-compose -f "$COMPOSE_FILE" down

echo "✅ Pact Broker stopped successfully!"
echo ""
echo "📋 Data Status:"
echo "   💾 Database volumes preserved (data will persist)"
echo "   🔄 To remove all data: $0 --remove-data"
echo ""

# Check if user wants to remove data
if [ "$1" = "--remove-data" ] || [ "$1" = "-v" ]; then
    echo "🗑️  Removing all data volumes..."
    docker-compose -f "$COMPOSE_FILE" down -v
    echo "✅ All data removed!"
fi 