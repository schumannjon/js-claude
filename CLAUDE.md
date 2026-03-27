# Claude Marketplace Repository

A personal collection of Claude Code extensions organized as a manifest-based registry. No build step required. All items are plain files.

## Repository Structure

- `registry.yaml` — master index of all items; update this when adding items
- `skills/` — `.md` files used as Claude Code slash commands
- `hooks/` — shell scripts triggered by Claude Code lifecycle events
- `mcp/` — MCP server config snippets and setup instructions
- `prompts/` — reusable prompt templates
- `settings/` — reusable settings.json fragments
- `agents/` — custom subagent definition files
- `schemas/` — JSON Schema files for validating manifests

Each item lives in its own subdirectory and has a `manifest.yaml`.

## Working in This Repo

### Adding a New Item

1. Create a subdirectory under the correct category folder. Name it with the item's kebab-case id.
2. Create `manifest.yaml` using the appropriate schema from `schemas/`. Required fields: id, name, type, version, description, author, tags, files, install.
3. Add all files listed in the `files` field to the same directory.
4. Add a corresponding entry to `registry.yaml` with at minimum: id, type, name, version, description, author, tags, path.
5. The `path` in registry.yaml must be relative to the repo root.

### Manifest Validation

```bash
# Validate a single manifest
npx ajv-cli validate -s schemas/manifest-<type>.schema.json -d <path>/manifest.yaml

# Validate all manifests
for f in $(find . -name manifest.yaml); do
  type=$(grep '^type:' "$f" | awk '{print $2}')
  npx ajv-cli validate -s "schemas/manifest-${type}.schema.json" -d "$f"
done
```

### Installing an Item (Manual)

| Type | Install steps |
|------|--------------|
| **skill** | Copy the `.md` file to `~/.claude/skills/` |
| **hook** | Copy `.sh` to `~/.claude/hooks/`, `chmod +x` it, merge `settings-snippet.json` into settings.json under `"hooks"` |
| **mcp** | Merge `settings-snippet.json` into settings.json under `"mcpServers"` |
| **agent** | Copy the `.md` file to `~/.claude/agents/` |
| **prompt** | No copy needed; paste or reference directly |
| **settings** | Merge `snippet.json` into settings.json at the `merge_key` path |

Snippets can be merged with jq:
```bash
jq -s '.[0] * .[1]' ~/.claude/settings.json settings-snippet.json > /tmp/merged.json && mv /tmp/merged.json ~/.claude/settings.json
```

### Versioning

Use semver. Increment:
- **patch** — content edits, wording fixes
- **minor** — new fields or behaviors, non-breaking additions
- **major** — breaking changes to installation procedure

Update `version` in both the item's `manifest.yaml` and in `registry.yaml`.

### Conventions

- IDs are kebab-case and must be unique across all categories in the registry.
- The directory name must match the `id` in manifest.yaml and in registry.yaml.
- Tags are lowercase. Reuse existing tags where possible (check registry.yaml).
- All shell scripts must have a shebang and be POSIX-compatible unless a specific shell is required (document it in the description).
- `settings-snippet.json` files must be valid JSON containing only the fragment to merge, not a full settings.json.
- Never commit secrets, tokens, or personal paths. Use placeholder values like `YOUR_TOKEN_HERE`.

### Registry Integrity Rules

- Every directory under a category folder must have a `manifest.yaml`.
- Every `manifest.yaml` must have a corresponding entry in `registry.yaml`.
- The `id` in `manifest.yaml` must match the directory name and the registry entry id.
- The `path` in registry.yaml must point to the directory containing the `manifest.yaml`.
