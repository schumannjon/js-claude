# Claude Marketplace

A personal collection of Claude Code extensions — skills, hooks, MCP servers, prompts, settings snippets, and agents. Organized as plain YAML/JSON manifests with no build step required.

> **Reference:** [Claude Code Skills Documentation](https://docs.anthropic.com/en/docs/claude-code/skills)

## Installing an Item

| Type | Steps |
|------|-------|
| **skill** | Copy the `.md` file to `~/.claude/skills/<name>/` |
| **hook** | Copy the script to `~/.claude/hooks/`, `chmod +x` it, merge `settings-snippet.json` into your `settings.json` under `"hooks"` |
| **mcp** | Merge `settings-snippet.json` into your `settings.json` under `"mcpServers"` |
| **agent** | Copy the `.md` file to `~/.claude/agents/` |
| **prompt** | Paste directly into your conversation or reference from `CLAUDE.md` |
| **settings** | Merge `snippet.json` into your `settings.json` at the path noted in the manifest's `merge_key` |

Each item's directory contains a `manifest.yaml` with full install instructions.

---

## Skills

| Name | Description |
|------|-------------|
| [blinko](skills/blinko/) | Make direct API calls to a self-hosted Blinko instance. Covers notes, tags, file uploads, user info, config, and analytics endpoints. |

## Hooks

| Name | Event | Description |
|------|-------|-------------|
| — | — | — |

## MCP Servers

| Name | Description |
|------|-------------|
| — | — |

## Prompts

| Name | Description |
|------|-------------|
| — | — |

## Settings

| Name | Description |
|------|-------------|
| — | — |

## Agents

| Name | Description |
|------|-------------|
| — | — |

---

## Adding Items

See [CLAUDE.md](CLAUDE.md) for conventions, manifest schemas, and registry integrity rules.
