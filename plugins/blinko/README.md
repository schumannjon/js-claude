# blinko

Make direct API calls to a self-hosted [Blinko](https://github.com/blinko-space/blinko) instance via curl. Covers notes, tags, file uploads, user info, config, and analytics endpoints.

## Install

```
/plugin install blinko@js-claude
```

## Setup

### 1. Set your instance URL

Edit `~/.claude/plugins/cache/js-claude/blinko/skills/blinko/config.json`:

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

### 2. Store your API token

Get a token from your Blinko instance under **Settings > Access Token**, then store it:

```powershell
[System.Environment]::SetEnvironmentVariable('BLINKO_API_KEY', 'your-token-here', 'User')
```

## Usage

Invoke the skill from Claude Code:

```
/blinko list my recent notes
/blinko create a note: "Remember to update dependencies"
/blinko search for notes tagged #work
/blinko show my daily review
```

## What It Covers

| Area | Operations |
|------|-----------|
| Notes | Create, update, list, search, share, trash, delete, batch operations |
| Tags | List, rename, set icon, delete |
| Files | Upload, upload from URL, delete |
| User | Get profile, regenerate token |
| Config | Get settings, update settings |
| Analytics | Daily note counts, monthly stats |
