# Claude Marketplace

A personal collection of Claude Code plugins following the official [Claude Code plugin marketplace](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces) format.

**Reference docs:**
- [Plugin Marketplaces](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)
- [Create Plugins](https://docs.anthropic.com/en/docs/claude-code/plugins)
- [Skills](https://docs.anthropic.com/en/docs/claude-code/skills)

---

## Getting Started

### 1. Add the marketplace

Run this inside Claude Code:

```
/plugin marketplace add schumannjon/js-claude
```

### 2. Install a plugin

```
/plugin install <plugin-name>@js-claude
```

### 3. Use the plugin

Skills are invoked with a `/` slash command:

```
/<plugin-name> <your request>
```

For example, after installing `blinko`:

```
/blinko list my recent notes
/blinko create a note: "Remember to update dependencies"
```

### Updating plugins

```
/plugin marketplace update js-claude
```

### Removing a plugin

```
/plugin uninstall <plugin-name>@js-claude
```

---

## Plugins

### Skills

| Plugin | Invoke | Description |
|--------|--------|-------------|
| [blinko](plugins/blinko/README.md) | `/blinko` | Make direct API calls to a self-hosted Blinko instance. Covers notes, tags, file uploads, user info, config, and analytics. |

### Hooks

| Plugin | Description |
|--------|-------------|
| — | — |

### MCP Servers

| Plugin | Description |
|--------|-------------|
| — | — |

### Agents

| Plugin | Description |
|--------|-------------|
| — | — |

---

## Contributing

See [CLAUDE.md](CLAUDE.md) for plugin structure conventions and how to add new plugins.
