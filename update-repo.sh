#!/bin/bash

# 1. Pull the latest changes (in case you edited from another machine)
git pull origin main

# 2. Add everything
git add .

# 3. Only commit and push if there are actually changes
if ! git diff-index --quiet HEAD --; then
    git commit -m "Auto-sync: $(date)"
    git push origin main
    echo "Changes synced successfully!"
else
    echo "No changes detected. Nothing to sync."
fi
