#!/bin/sh

set -euo pipefail

env=${1:-}

if [[ "$env" == "dev" ]]; then
    echo "Deploy to local dev"
    docker-compose run api rails db:setup
    docker-compose up
fi
