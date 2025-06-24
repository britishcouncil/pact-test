#!/bin/bash

# Pact Broker Startup Script
# This script starts the Pact Broker and verifies it's working correctly

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$(dirname "$SCRIPT_DIR")/docker-compose.pact-broker.yml"

echo "🚀 Starting Pact Broker Infrastructure..."
echo "📍 Using compose file: $COMPOSE_FILE"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Start the services
echo "📦 Starting Pact Broker and PostgreSQL..."
docker-compose -f "$COMPOSE_FILE" up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check PostgreSQL health
echo "🔍 Checking PostgreSQL health..."
max_attempts=30
attempt=1

while [ $attempt -le $max_attempts ]; do
    if docker-compose -f "$COMPOSE_FILE" exec -T pact-broker-db pg_isready -U postgres; then
        echo "✅ PostgreSQL is ready!"
        break
    fi
    
    if [ $attempt -eq $max_attempts ]; then
        echo "❌ PostgreSQL failed to start after $max_attempts attempts"
        docker-compose -f "$COMPOSE_FILE" logs pact-broker-db
        exit 1
    fi
    
    echo "⏳ Attempt $attempt/$max_attempts - PostgreSQL not ready yet..."
    sleep 2
    ((attempt++))
done

# Check Pact Broker health
echo "🔍 Checking Pact Broker health..."
max_attempts=30
attempt=1

while [ $attempt -le $max_attempts ]; do
    if curl -s -f http://localhost:9292/diagnostic/status/heartbeat > /dev/null; then
        echo "✅ Pact Broker is ready!"
        break
    fi
    
    if [ $attempt -eq $max_attempts ]; then
        echo "❌ Pact Broker failed to start after $max_attempts attempts"
        docker-compose -f "$COMPOSE_FILE" logs pact-broker
        exit 1
    fi
    
    echo "⏳ Attempt $attempt/$max_attempts - Pact Broker not ready yet..."
    sleep 2
    ((attempt++))
done

# Test authentication
echo "🔐 Testing authentication..."
auth_response=$(curl -s -w "%{http_code}" -u "pact_broker:pact_broker_password" http://localhost:9292/ -o /dev/null)

if [ "$auth_response" = "200" ]; then
    echo "✅ Authentication working correctly!"
else
    echo "❌ Authentication test failed (HTTP $auth_response)"
    exit 1
fi

# Display status
echo ""
echo "🎉 Pact Broker is now running successfully!"
echo ""
echo "📊 Access Information:"
echo "   🌐 Broker URL: http://localhost:9292"
echo "   👤 Admin Login: pact_broker / pact_broker_password"
echo "   👁️  Viewer Login: viewer / viewer_password"
echo ""
echo "📋 Useful Commands:"
echo "   📊 View logs: docker-compose -f $COMPOSE_FILE logs -f"
echo "   🛑 Stop broker: docker-compose -f $COMPOSE_FILE down"
echo "   🗑️  Remove data: docker-compose -f $COMPOSE_FILE down -v"
echo ""
echo "✅ Pact Broker running on http://localhost:9292" 