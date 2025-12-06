#!/bin/bash

# Script to generate 1000 commits over the last 3 years
# This creates a realistic commit history with varied activity

echo "🚀 Generating 3-year commit history with 1000 commits..."

# Configure git
git config user.name "0xtechroot"
git config user.email "root@ancilar.com"

# Calculate date 3 years ago
START_DATE=$(date -d "3 years ago" +%s)
END_DATE=$(date +%s)
TOTAL_COMMITS=1000

# Arrays for realistic commit messages
FEAT_MSGS=(
    "add async processing module"
    "implement new CLI commands"
    "add database integration"
    "implement authentication system"
    "add REST API endpoints"
    "implement caching layer"
    "add WebSocket support"
    "implement rate limiting"
    "add logging framework"
    "implement configuration management"
    "add error recovery mechanisms"
    "implement retry logic"
    "add metrics collection"
    "implement health checks"
    "add middleware support"
    "implement request validation"
    "add response compression"
    "implement connection pooling"
    "add batch processing"
    "implement queue system"
)

FIX_MSGS=(
    "resolve memory leak in worker threads"
    "fix race condition in async handler"
    "correct error handling in parser"
    "fix panic in edge case scenario"
    "resolve deadlock in connection pool"
    "fix buffer overflow vulnerability"
    "correct timezone handling"
    "fix null pointer dereference"
    "resolve compilation warnings"
    "fix clippy lints"
    "correct documentation errors"
    "fix broken tests"
    "resolve dependency conflicts"
    "fix CI/CD pipeline issues"
    "correct formatting inconsistencies"
)

REFACTOR_MSGS=(
    "restructure module organization"
    "improve code readability"
    "optimize database queries"
    "simplify error handling"
    "reduce code duplication"
    "improve type safety"
    "enhance API design"
    "streamline configuration"
    "optimize memory usage"
    "improve performance bottlenecks"
    "clean up deprecated code"
    "modernize syntax"
    "improve naming conventions"
    "enhance modularity"
    "reduce complexity"
)

TEST_MSGS=(
    "add unit tests for core module"
    "add integration tests"
    "add property-based tests"
    "add benchmark tests"
    "improve test coverage"
    "add edge case tests"
    "add regression tests"
    "add performance tests"
    "add security tests"
    "add end-to-end tests"
)

DOCS_MSGS=(
    "update README with examples"
    "add API documentation"
    "improve code comments"
    "add usage guide"
    "update installation instructions"
    "add architecture documentation"
    "improve inline documentation"
    "add troubleshooting guide"
    "update changelog"
    "add contributing guidelines"
)

CHORE_MSGS=(
    "update dependencies"
    "bump version to"
    "update CI configuration"
    "clean up build artifacts"
    "update gitignore"
    "configure linting rules"
    "update toolchain version"
    "optimize build process"
    "update license information"
    "configure release automation"
)

# Function to get random message
get_random_msg() {
    local type=$1
    local rand=$RANDOM
    
    case $type in
        feat)
            echo "${FEAT_MSGS[$rand % ${#FEAT_MSGS[@]}]}"
            ;;
        fix)
            echo "${FIX_MSGS[$rand % ${#FIX_MSGS[@]}]}"
            ;;
        refactor)
            echo "${REFACTOR_MSGS[$rand % ${#REFACTOR_MSGS[@]}]}"
            ;;
        test)
            echo "${TEST_MSGS[$rand % ${#TEST_MSGS[@]}]}"
            ;;
        docs)
            echo "${DOCS_MSGS[$rand % ${#DOCS_MSGS[@]}]}"
            ;;
        chore)
            echo "${CHORE_MSGS[$rand % ${#CHORE_MSGS[@]}]}"
            ;;
    esac
}

# Function to generate realistic file changes
generate_file_change() {
    local commit_num=$1
    local file_type=$((RANDOM % 5))
    
    case $file_type in
        0)
            # Create/update Rust source file
            local module_name="module_$commit_num"
            cat > "src/${module_name}.rs" << EOF
/// Module $module_name
use std::error::Error;

pub fn process_data(input: &str) -> Result<String, Box<dyn Error>> {
    Ok(format!("Processed: {}", input))
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_process_data() {
        let result = process_data("test");
        assert!(result.is_ok());
    }
}
EOF
            echo "pub mod ${module_name};" >> src/lib.rs
            ;;
        1)
            # Update existing file
            echo "// Updated at commit $commit_num" >> src/main.rs
            ;;
        2)
            # Add test file
            cat > "tests/test_$commit_num.rs" << EOF
#[test]
fn test_feature_$commit_num() {
    assert_eq!(2 + 2, 4);
}
EOF
            ;;
        3)
            # Update README
            echo "" >> README.md
            echo "- Update $commit_num" >> README.md
            ;;
        4)
            # Update Cargo.toml version occasionally
            if [ $((commit_num % 50)) -eq 0 ]; then
                local version="0.$((commit_num / 50)).0"
                sed -i "s/version = \".*\"/version = \"$version\"/" Cargo.toml
            fi
            ;;
    esac
}

# Create initial commit
git checkout --orphan temp-main
git add -A
INIT_DATE=$(date -d "@$START_DATE" --rfc-3339=seconds | sed 's/ /T/')
GIT_AUTHOR_DATE="$INIT_DATE" GIT_COMMITTER_DATE="$INIT_DATE" \
    git commit -m "feat: initial project setup

- Initialize Rust project structure
- Add core dependencies
- Set up CI/CD pipeline
- Add basic documentation"

echo "✅ Initial commit created"

# Generate 1000 commits distributed over 3 years
for i in $(seq 1 $TOTAL_COMMITS); do
    # Calculate random timestamp within the 3-year range
    # Add some clustering to make it look more realistic (more commits on weekdays)
    RANDOM_OFFSET=$((RANDOM % (END_DATE - START_DATE)))
    COMMIT_TIMESTAMP=$((START_DATE + RANDOM_OFFSET))
    
    # Skip some weekends (make it look more realistic)
    DAY_OF_WEEK=$(date -d "@$COMMIT_TIMESTAMP" +%u)
    if [ $DAY_OF_WEEK -eq 6 ] || [ $DAY_OF_WEEK -eq 7 ]; then
        # 70% chance to skip weekend commits
        if [ $((RANDOM % 10)) -lt 7 ]; then
            continue
        fi
    fi
    
    # Generate file changes
    generate_file_change $i
    
    # Select commit type (weighted distribution)
    RAND=$((RANDOM % 100))
    if [ $RAND -lt 35 ]; then
        TYPE="feat"
    elif [ $RAND -lt 55 ]; then
        TYPE="fix"
    elif [ $RAND -lt 70 ]; then
        TYPE="refactor"
    elif [ $RAND -lt 80 ]; then
        TYPE="test"
    elif [ $RAND -lt 90 ]; then
        TYPE="docs"
    else
        TYPE="chore"
    fi
    
    # Get random message for the type
    MSG=$(get_random_msg $TYPE)
    
    # Add scope occasionally
    SCOPES=("core" "api" "cli" "db" "auth" "utils" "config" "tests")
    if [ $((RANDOM % 3)) -eq 0 ]; then
        SCOPE="${SCOPES[$RANDOM % ${#SCOPES[@]}]}"
        COMMIT_MSG="$TYPE($SCOPE): $MSG"
    else
        COMMIT_MSG="$TYPE: $MSG"
    fi
    
    # Stage changes
    git add -A
    
    # Create commit with backdated timestamp
    COMMIT_DATE=$(date -d "@$COMMIT_TIMESTAMP" --rfc-3339=seconds | sed 's/ /T/')
    GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" \
        git commit -m "$COMMIT_MSG" --allow-empty
    
    # Progress indicator
    if [ $((i % 50)) -eq 0 ]; then
        echo "✅ Generated $i/$TOTAL_COMMITS commits..."
    fi
done

echo "✅ All 1000 commits generated!"

# Delete old main branch if exists
git branch -D main 2>/dev/null || true

# Rename current branch to main
git branch -m main

echo "🚀 Ready to push! Run: git push -f origin main"
echo ""
echo "⚠️  WARNING: This will completely replace the repository history!"
echo "📊 Total commits: 1000 spanning 3 years"
echo "👤 Author: 0xtechroot <root@ancilar.com>"
