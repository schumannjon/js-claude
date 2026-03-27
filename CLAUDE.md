# Claude Marketplace

A personal collection of Claude Code plugins following the official Claude Code plugin marketplace format.

**Official docs:**
- [Plugin Marketplaces](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)
- [Create Plugins](https://docs.anthropic.com/en/docs/claude-code/plugins)
- [Skills](https://docs.anthropic.com/en/docs/claude-code/skills)

## Repository Structure

```
.claude-plugin/
  marketplace.json      ← marketplace catalog (lists all plugins)
plugins/
  <plugin-name>/
    .claude-plugin/
      plugin.json       ← plugin manifest (name, version, description, author)
    skills/
      <skill-name>/
        SKILL.md        ← skill instructions (required)
        [other files]   ← supporting files referenced from SKILL.md
    agents/             ← custom subagent definitions
    hooks/
      hooks.json        ← lifecycle event hooks
    .mcp.json           ← MCP server configurations
```

> **Important:** Only `plugin.json` goes inside `.claude-plugin/`. All other directories (`skills/`, `agents/`, `hooks/`, `.mcp.json`) must be at the plugin root level.

## Adding a New Plugin

1. Create the plugin directory and manifest:
   ```bash
   mkdir -p plugins/<name>/.claude-plugin
   ```

2. Create `plugins/<name>/.claude-plugin/plugin.json`:
   ```json
   {
     "name": "<name>",
     "description": "What this plugin does",
     "version": "1.0.0",
     "author": { "name": "schumannjon" },
     "keywords": ["tag1", "tag2"]
   }
   ```

3. Add the plugin's content (skills, hooks, MCP servers, agents) at the plugin root level.

4. Add an entry to `.claude-plugin/marketplace.json` under `"plugins"`:
   ```json
   {
     "name": "<name>",
     "source": "./plugins/<name>",
     "description": "What this plugin does",
     "keywords": ["tag1", "tag2"]
   }
   ```

5. Update the README.md table for the relevant category.

## Adding a Skill to a Plugin

Each skill is a directory inside the plugin's `skills/` folder containing a `SKILL.md`:

```
plugins/<plugin-name>/skills/<skill-name>/SKILL.md
```

`SKILL.md` structure:
```markdown
---
name: skill-name
description: What the skill does and when Claude should use it
disable-model-invocation: true   # optional: only invoke manually
---

Skill instructions here...
```

## Versioning

Use semver. Update `version` in `plugin.json` when the plugin changes:
- **patch** — content edits, wording fixes
- **minor** — new capabilities, non-breaking additions
- **major** — breaking changes

## Testing Locally

```bash
claude --plugin-dir ./plugins/<name>
```

Reload without restarting:
```
/reload-plugins
```

Validate the marketplace:
```
/plugin validate .
```

## Installing This Marketplace

```
/plugin marketplace add schumannjon/js-claude
/plugin install <name>@js-claude
```
