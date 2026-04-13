# Career Coach Plugin

A career development assistant for Claude Code. Helps you manage Personal Development Plans and draft self-reviews using any company's performance framework.

## Skills

- **`/pdp`** — Create, review, and maintain your Personal Development Plan
- **`/self-review`** — Draft and polish self-review responses with quality scoring

## Setup

Run the setup script to scaffold the local directory with starter files:

```bash
bash path/to/career-coach/scripts/setup.sh
```

Or create the structure manually:

```bash
mkdir -p ~/career-coach/pdp/archive ~/career-coach/self-review/archive ~/career-coach/context
```

The setup script creates starter templates for your PDP and self-review, plus a guide in `context/` explaining what files to add. It's safe to re-run — it won't overwrite existing files.

### Required files

| File | Purpose |
|------|---------|
| `~/career-coach/pdp/current.md` | Your active PDP |
| `~/career-coach/self-review/current.md` | Your active self-review draft |

### Context files (private, never published)

Place any company-specific or private reference material in `~/career-coach/context/`:

| File | Purpose |
|------|---------|
| `context/pdp-template.md` | Your company's PDP template — the coach adapts to it |
| `context/self-review-template.md` | Your company's self-review questions/format |
| `context/roles.md` | Career lattice, role expectations, or level definitions |
| `context/projects.md` | Project descriptions, deliverables, key results |
| `context/team.md` | Colleague names, roles, collaboration context |
| `context/*.md` | Any other reference material you want the coach to use |

The coach reads everything in `context/` to inform its guidance. These files stay on your machine — they are never committed to this repository.

### Archives

Past PDPs and self-reviews are stored in archive directories:

```
~/career-coach/pdp/archive/2026-H1.md
~/career-coach/self-review/archive/2026-Q1.md
```

## How it works

1. You provide your company's templates and context locally
2. The coach adapts to your company's format — not the other way around
3. Writing advice is universal (outcome-focused, evidence-based, dimension-aligned)
4. Sensitive details (names, projects, proprietary info) never leave your machine

## Example usage

```
> /pdp
> Review my PDP

> /self-review
> Score my responses
> Polish Q3
> Prep for submission
```
