#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <linear-ticket-id> [iterations]"
  echo "Example: $0 FAS-123 5"
  exit 1
fi

TICKET_ID="$1"
ITERATIONS="${2:-10}"  # Default to 10 iterations if not specified
PROGRESS_FILE="${TICKET_ID}-progress.txt"

echo "Processing Linear ticket: $TICKET_ID"
echo "Max iterations: $ITERATIONS"
echo "Progress file: $PROGRESS_FILE"
echo ""

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "=== Progress for $TICKET_ID ===" > "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "" >> "$PROGRESS_FILE"
fi

for ((i=1; i<=$ITERATIONS; i++)); do
  echo "=== Iteration $i/$ITERATIONS ==="

  result=$(claude --dangerously-skip-permissions -p "Linear Ticket: $TICKET_ID

    Read @$PROGRESS_FILE to see what has been done.

    1. Read ticket $TICKET_ID using Linear MCP (if not already done)
    2. Check if this ticket has sub-issues using list_issues(parentId=...) (if not already done)
    3. Create a git worktree for this ticket (if not already done):
       - Path: ../\$(basename \$(pwd))-linear-$TICKET_ID
       - Branch: <developer-name>/$TICKET_ID-<brief-description>
       - Use: git worktree add <path> -b <branch> (creates worktree and branch together)
       - Then cd into the worktree to do all work there
    4. Select which issue to work on:
       - If sub-issues exist: use list_issues(parentId=..., orderBy='createdAt') to get them ordered oldest to newest, then work through them in that order, skipping any marked as 'Done' or 'Completed'
       - If no sub-issues: work on the parent ticket directly
    5. Implement the selected issue completely following project conventions
    6. Run tests and type checks, then build the project
    7. Commit changes with message referencing the issue's ticket ID
    8. Update the issue status to 'Done' or 'Completed' using Linear MCP update_issue
    9. Append what you accomplished to @$PROGRESS_FILE

    ONLY WORK ON A SINGLE ISSUE.

    If all issues are complete (parent + all sub-issues marked as Done):
    1. cd back to the original repo
    2. Remove the worktree with: git worktree remove <worktree-path>
    3. Output <promise>COMPLETE</promise>")

  echo "$result"
  echo ""

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "✓ Ticket $TICKET_ID completed after $i iterations."
    exit 0
  fi
done

echo "⚠ Reached maximum iterations ($ITERATIONS) without completing ticket $TICKET_ID"
exit 1
