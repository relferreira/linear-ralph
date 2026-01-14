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

## Prerequisites

- [Claude CLI](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- Linear MCP configured in Claude CLI
- Git configured for your project

## Installation

Clone this repository to a location of your choice:

```bash
git clone https://github.com/relferreira/linear-ralph.git
cd linear-ralph
chmod +x linear-ralph.sh
```

## Usage

Run the script **from within your project directory** so Claude has the correct context. The script path should point to wherever you cloned this repo:

```bash
cd /path/to/your/project
sh /path/to/linear-ralph/linear-ralph.sh <linear-ticket-id> [iterations]
```

### Example

If you cloned to `~/linear-ralph` and your project is at `~/mycompany/my-app`:

```bash
cd ~/mycompany/my-app
sh ~/linear-ralph/linear-ralph.sh PROJ-123
```

Or with a custom iteration limit:

```bash
cd ~/mycompany/my-app
sh ~/linear-ralph/linear-ralph.sh PROJ-123 5
```

## Progress Tracking

The script creates a progress file (`<ticket-id>-progress.txt`) to track what has been accomplished across iterations. This allows Claude to resume work and avoid repeating completed tasks.

## License

MIT
