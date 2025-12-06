#!/bin/bash

# Script to clean commit history and rewrite author information
# This will remove all traces of previous commits and start fresh

echo "🧹 Cleaning repository history..."

# Create a new orphan branch
git checkout --orphan clean-main

# Add all files
git add -A

# Configure git with correct author
git config user.name "0xtechroot"
git config user.email "root@ancilar.com"

# Create initial commit
git commit -m "feat: initial Rust CLI application with async support

- Add core application structure
- Implement CLI interface with clap
- Add async capabilities with tokio
- Set up testing framework
- Configure CI/CD pipeline"

# Delete old main branch
git branch -D main

# Rename current branch to main
git branch -m main

# Force push to remote (this will completely replace history)
git push -f origin main

echo "✅ History cleaned! All commits now authored by 0xtechroot <root@ancilar.com>"
echo "⚠️  Note: This has rewritten the repository history"
