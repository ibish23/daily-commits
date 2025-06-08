#!/bin/bash

cd "$(dirname "$0")"

# Check if there are changes
if ! git diff-index --quiet HEAD --; then
    git add .
    git commit -m "Automated commit on $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
else
    echo "No changes to commit on $(date)"
fi

