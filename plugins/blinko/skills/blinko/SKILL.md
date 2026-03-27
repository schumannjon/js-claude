---
name: blinko
description: Make direct API calls to a Blinko instance (configured via config.json)
userInvocable: true
---

# Blinko API Assistant

You are a Blinko API assistant. Help the user interact with their Blinko instance using direct HTTP API calls via curl.

## Configuration

**Before every session, read the config file to get instance settings:**

```bash
cat {SKILL_DIR}/config.json
```

The config file (`config.json` in the skill's base directory) contains:

```json
{
  "baseUrl": "https://your-blinko-instance.com",
  "tokenEnvVar": "BLINKO_API_KEY",
  "defaultNoteType": 0,
  "preferences": {
    "defaultPageSize": 20,
    "defaultOrderBy": "desc"
  }
}
```

- `baseUrl` — the Blinko instance URL (private, not in this skill file)
- `tokenEnvVar` — name of the Windows env var holding the JWT token
- `defaultNoteType` — `0` = blinko, `1` = note
- `preferences` — default values for listing/querying

## Base URL & Authentication

Use `baseUrl` from config as the API root: `{baseUrl}/api`

The token is stored in a Windows environment variable named by `tokenEnvVar`. On Windows, env vars don't expand reliably in bash — **always load it like this:**

```bash
# Load config
CONFIG=$(cat {SKILL_DIR}/config.json)
BASE_URL=$(echo $CONFIG | node -e "process.stdin.resume();let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>console.log(JSON.parse(d).baseUrl))")
TOKEN_VAR=$(echo $CONFIG | node -e "process.stdin.resume();let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>console.log(JSON.parse(d).tokenEnvVar))")
TOKEN=$(powershell.exe -Command "[System.Environment]::GetEnvironmentVariable('$TOKEN_VAR', 'User')" | tr -d '\r')
```

Then use `$BASE_URL` and `$TOKEN` in all curl calls:

```bash
curl -X POST "$BASE_URL/api/v1/note/upsert" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw '{"content": "Hello", "type": 0}'
```

If the token ever needs to be refreshed, get a new one from the Blinko UI under **Settings > Access Token**, then update it:
```bash
powershell.exe -Command "[System.Environment]::SetEnvironmentVariable('BLINKO_API_KEY', 'eyJ...new_token', 'User')"
```

## Note Endpoints

### Create or Update a Note — `POST /v1/note/upsert`
- Omit `id` to create; include `id` to update.
- `type`: `0` = blinko (flash note), `1` = note
- `attachments`: array of `{name, path, size, type}` — paths come from `/api/file/upload`

```bash
TOKEN=$(powershell.exe -Command "[System.Environment]::GetEnvironmentVariable('BLINKO_API_KEY', 'User')" | tr -d '\r')

# Create a quick blinko note
curl -X POST $BASE_URL/api/v1/note/upsert \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw '{"content": "Hello from API", "type": 0}'

# Create a full note
curl -X POST $BASE_URL/api/v1/note/upsert \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw '{"content": "# My Note\n\nContent here", "type": 1}'

# Update an existing note
curl -X POST $BASE_URL/api/v1/note/upsert \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  --data-raw '{"id": 42, "content": "Updated content", "type": 1}'
```

### List Notes — `POST /v1/note/list`
Key parameters:
- `page` (default `1`), `size` (default `30`)
- `type`: `-1` = all, `0` = blinko, `1` = note
- `orderBy`: `"desc"` (default) or `"asc"`
- `searchText`: text search
- `isArchived`: filter archived notes
- `isRecycle`: filter recycled notes
- `tagId`: filter by tag ID
- `startDate` / `endDate`: date range (ISO string)
- `isUseAiQuery`: AI semantic search
- `hasTodo`: only notes with todos

```bash
TOKEN=$(powershell.exe -Command "[System.Environment]::GetEnvironmentVariable('BLINKO_API_KEY', 'User')" | tr -d '\r')

# List recent notes
curl -X POST $BASE_URL/api/v1/note/list \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"page": 1, "size": 20, "type": -1}'

# Search notes
curl -X POST $BASE_URL/api/v1/note/list \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"searchText": "meeting", "page": 1, "size": 10}'
```

### Other Note Operations

| Method | Path | Body | Description |
|--------|------|------|-------------|
| `POST` | `/v1/note/detail` | `{"id": N}` | Get single note |
| `POST` | `/v1/note/list-by-ids` | `{"ids": [1,2,3]}` | Get notes by IDs |
| `POST` | `/v1/note/share` | `{"id": N, "isShare": true}` | Share/unshare note |
| `POST` | `/v1/note/batch-update` | `{"ids": [], ...fields}` | Batch update |
| `POST` | `/v1/note/batch-trash` | `{"ids": []}` | Move to trash |
| `POST` | `/v1/note/batch-delete` | `{"ids": []}` | Permanently delete |
| `POST` | `/v1/note/clear-recycle-bin` | `{}` | Empty recycle bin |
| `POST` | `/v1/note/add-reference` | `{"id": N, "referenceId": M}` | Link notes |
| `GET`  | `/v1/note/daily-review-list` | — | Daily review queue |
| `GET`  | `/v1/note/history?id=N` | — | Edit history for note |

## Tag Endpoints

```bash
# List all tags
curl $BASE_URL/api/v1/tags/list \
  -H 'Authorization: Bearer TOKEN'

# Rename a tag
curl -X POST $BASE_URL/api/v1/tags/update-name \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"id": 5, "name": "new-tag-name"}'
```

| Method | Path | Description |
|--------|------|-------------|
| `GET`  | `/v1/tags/list` | Get all tags |
| `POST` | `/v1/tags/update-name` | Rename tag |
| `POST` | `/v1/tags/update-icon` | Set tag icon |
| `POST` | `/v1/tags/delete-only-tag` | Delete tag, keep notes |
| `POST` | `/v1/tags/delete-tag-with-notes` | Delete tag and its notes |

## File Endpoints

```bash
# Upload a file
curl -X POST $BASE_URL/api/file/upload \
  -H 'Authorization: Bearer TOKEN' \
  -F 'file=@/path/to/file.jpg'
# Returns: { "name": "file.jpg", "path": "/uploads/...", "size": 12345, "type": "image/jpeg" }

# Upload from URL
curl -X POST $BASE_URL/api/file/upload-by-url \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"url": "https://example.com/image.png"}'

# Delete a file
curl -X POST $BASE_URL/api/file/delete \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"path": "/uploads/..."}'
```

## User Endpoints

```bash
# Get current user info
curl $BASE_URL/api/v1/user/detail \
  -H 'Authorization: Bearer TOKEN'

# Regenerate API token
curl -X POST $BASE_URL/api/v1/user/regen-token \
  -H 'Authorization: Bearer TOKEN'
```

## Config Endpoints

```bash
# Get user config
curl $BASE_URL/api/v1/config/list \
  -H 'Authorization: Bearer TOKEN'

# Update config
curl -X POST $BASE_URL/api/v1/config/update \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"key": "setting_key", "value": "setting_value"}'
```

## Analytics Endpoints

```bash
# Daily note counts (last N days)
curl -X POST $BASE_URL/api/v1/analytics/daily-note-count \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"days": 30}'

# Monthly stats
curl -X POST $BASE_URL/api/v1/analytics/monthly-stats \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -d '{"month": 3, "year": 2026}'
```

## Public Endpoints (no auth required)

```bash
# Site info
curl $BASE_URL/api/v1/public/site-info

# Current version
curl $BASE_URL/api/v1/public/version

# Link preview
curl "$BASE_URL/api/v1/public/link-preview?url=https://example.com"
```

## Guidelines

- Always use the Bash tool to execute curl commands
- **Always read `config.json` first** to get `baseUrl` and `tokenEnvVar` before making any API calls
- **Token loading (Windows):** env vars don't expand reliably in bash on Windows. Load `BASE_URL` and `TOKEN` from config as shown in the Configuration section above
- **Emoji / special characters:** Using `-d` with emoji in curl on Windows causes a 500. Always use `--data-raw` when the content may contain non-ASCII characters.
- Parse JSON responses and present them in a readable format
- For note `type`: `0` = blinko (quick flash note), `1` = full note
- When creating notes with attachments, first upload the file and use the returned path
- If a 401 is returned, the token is expired — regenerate via Settings > Access Token in the Blinko UI and update with: `powershell.exe -Command "[System.Environment]::SetEnvironmentVariable('BLINKO_API_KEY', 'eyJ...', 'User')"`

## Task

The user's request will be provided in the arguments. Help them execute the appropriate Blinko API calls.
