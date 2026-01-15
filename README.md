# Linear Ralph

> **⚠️ Experimental:** This project is a proof of concept and may not work perfectly in all scenarios.

A bash script that uses Claude CLI with the "Ralph Wiggum" approach to autonomously work through Linear tickets and their sub-issues.

Inspired by [Getting Started with Ralph](https://www.aihero.dev/getting-started-with-ralph).

## What is the Ralph Wiggum Approach?

The Ralph Wiggum approach is an iterative AI coding methodology where Claude works on one issue at a time in a loop until all tasks are complete. Instead of trying to solve everything at once, it breaks down work into manageable pieces and tackles them sequentially.

## How It Works

1. Takes a Linear ticket ID as input
2. Reads the ticket and checks for sub-issues
3. Works through each issue one at a time (oldest first)
4. Implements, tests, commits, and marks each issue as done
5. Tracks progress in a local file
6. Continues until all issues are complete or max iterations reached

## Recommended Workflow

For best results, structure your Linear tickets as follows:

1. **Create a parent issue as a spec document** - Write a detailed description of the feature or task, including context, requirements, and acceptance criteria

2. **Break it down into sub-issues** - Each sub-issue should be a small, focused task that Claude can complete in a single iteration. Examples:
   - "Add UserProfile component with avatar and name"
   - "Create API endpoint for fetching user data"
   - "Write unit tests for UserProfile component"

3. **Run linear-ralph with the parent issue ID** - The script will work through each sub-issue in order, marking them as done

**Tips:**
- Keep sub-issues small and specific
- Order sub-issues by dependency (create before use)
- Include enough context in the parent issue for Claude to understand the bigger picture

## Prerequisites

- [Claude Code](https://claude.com/product/claude-code) installed and configured
- [Linear MCP](https://linear.app/docs/mcp#claude) configured in Claude Code
- Git configured for your project

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/relferreira/linear-ralph/main/install.sh | bash
```

## Usage

Run from **within your project directory** so Claude has the correct context:

```bash
cd /path/to/your/project
linear-ralph <linear-ticket-id> [iterations]
```

### Example

```bash
cd ~/mycompany/my-app
linear-ralph PROJ-123

# With a custom iteration limit
linear-ralph PROJ-123 5
```

## Progress Tracking

The script creates a progress file (`<ticket-id>-progress.txt`) to track what has been accomplished across iterations. This allows Claude to resume work and avoid repeating completed tasks.

## License

MIT
