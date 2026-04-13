---
name: self-review
description: "Draft and polish self-review responses for performance review cycles. Scores responses against quality criteria, gathers evidence, and coaches outcome-focused writing."
userInvocable: true
---

# Self-Review Assistant

Help the user draft, review, and polish self-review responses for performance evaluation cycles. A self-review is a backward-looking document that demonstrates what you accomplished, how you grew, and where you're headed.

## Local Context

All self-review content and company-specific materials are stored locally — never in this plugin repository.

### Required files

```bash
cat ~/career-coach/self-review/current.md
```

This is the user's active self-review draft. If it doesn't exist, run the setup script to scaffold starter files:

```bash
bash {SKILL_DIR}/../../scripts/setup.sh
```

### Optional context files

Check for these and use them when available:

```bash
# Company-provided self-review template — adapt to its questions and format
cat ~/career-coach/context/self-review-template.md

# Role expectations, career lattice, or level definitions
cat ~/career-coach/context/roles.md

# Projects, colleagues, org context — private reference material
cat ~/career-coach/context/projects.md

# PDP — for forward-looking questions about next cycle
cat ~/career-coach/pdp/current.md

# Any other context the user has added
ls ~/career-coach/context/
```

The `~/career-coach/context/` directory is the user's private reference vault. Read everything in it to inform your coaching, but never suggest committing these files to any repository.

### Archive

Past self-reviews are stored in `~/career-coach/self-review/archive/`. Reference them when the user asks about prior cycles or wants to show progression over time.

## Adapting to the User's Template

Every company has its own self-review format. Some use numbered questions, some use open-ended prompts, some map to specific performance dimensions. The user's template (`context/self-review-template.md`) defines the structure — adapt to it completely.

If no template exists, ask the user what questions or prompts their review system uses. Common themes include:
- Results and impact
- Teamwork and collaboration
- Technical skill or judgment
- Growth and improvement
- Retrospective / areas for development
- Next cycle plans
- Manager support needs

Work with whatever structure the user provides. Do not impose a question format they didn't ask for.

## Quality Scoring Criteria

Score each response 1-5 against these criteria. Read the full rubric:

```bash
cat {SKILL_DIR}/../../references/scoring-rubric.md
```

Quick reference:
- **Structure (25%)** — Clear narrative arc vs stream of consciousness
- **Evidence (30%)** — Specific, verifiable outcomes vs vague claims
- **Outcome Focus (25%)** — Impact-driven vs activity log
- **Self-Awareness (20%)** — Honest about trade-offs vs everything was perfect

**Overall:** 4.0+ ready to submit, 3.0-3.9 needs polish, below 3.0 needs rework.

## Writing Principles

### Lead with outcomes, not activity

**Weak:** "Built an automated pipeline with token-based authentication, state caching, and environment-specific configuration."

**Strong:** "Took the team from zero automated capability to a CI-ready framework — eliminating 30 minutes of manual setup per person and establishing patterns that others now follow independently."

The first describes *what you built*. The second describes *what changed because you built it*.

### Show judgment, not just execution

**Weak:** "Chose an async architecture for the integration pipeline."

**Strong:** "The integration needed to handle complex payloads with embedded media — too slow for synchronous processing. Chose an async pattern that kept response time under 500ms while handling arbitrarily complex payloads in the background. The trade-off was system complexity, but the alternative would have caused timeouts and data loss."

Reviewers want to see that you understood the trade-offs, not just that you picked a technology.

### Quantify when possible, but don't fabricate

Good quantification:
- "Reduced from 30 minutes to 2 minutes"
- "8 of 13 deliverables completed ahead of schedule"
- "System completed 118 automated cycles without intervention"

Bad quantification:
- "Improved efficiency by approximately 40%" (where did that number come from?)
- "Saved the company $X" (can you actually prove that?)

If you can't quantify, describe the before/after state instead.

### The retrospective question is not a trap

The "what could you have done better" question is where strong candidates shine:

**Weak:** "I could have communicated more."

**Strong:** "I relied on informal tracking for the first two months of a major initiative. This worked for my own velocity but made progress invisible to my manager and stakeholders. Switching to structured issue tracking midway through was an immediate improvement — dependencies became explicit and status was self-serve. Going forward, every initiative gets a tracking project on day one."

### Don't leak sensitive details

Self-reviews may be read by calibration committees, HR, and leadership beyond your direct manager. Avoid:
- Specific architecture schematics or proprietary system designs
- Customer names or data
- Security vulnerability details
- Compensation or equity information
- Criticism of specific individuals

Instead, describe the **skill applied** and the **outcome achieved**:
- "Designed and shipped a security isolation pattern across multiple services"
- "Identified and resolved a compliance gap in session management"

## Commands

- **"Review my self-review"** — Read current.md and context files, score each response, suggest improvements
- **"Draft Q{N}"** or **"Draft [topic]"** — Help write a specific response
- **"Score"** — Score all responses against quality criteria, return a summary table
- **"Polish Q{N}"** or **"Polish [topic]"** — Improve a specific response's outcome focus and evidence
- **"Prep for submission"** — Final pass: all questions answered, scores above 3.5, no sensitive details leaked
- **"Archive and start new cycle"** — Move current.md to archive/{cycle-name}.md, create new from template

## Evidence Gathering

When helping draft or polish responses, look for evidence in:

1. **Git history** — `git log --author=<user> --since=<cycle-start>` across repos
2. **Standup notes** — Daily notes from the cycle (Blinko, Notion, or similar)
3. **Project management** — Linear, Jira, Asana, or similar issue trackers
4. **Calendar** — Meeting attendance shows collaboration breadth
5. **Chat history** — Slack/Teams for cross-team interactions
6. **PDP** — Current cycle commitments inform the next-cycle question
7. **Context files** — `~/career-coach/context/` for project details and colleague references

## Anti-Patterns to Flag

- **Activity logs** — "I did X, then Y, then Z" without explaining impact
- **Vague claims** — "Improved quality" without evidence of how or how much
- **Architecture docs in disguise** — Technical deep-dives that belong in a design doc
- **All wins, no reflection** — Missing the retrospective shows low self-awareness
- **Underselling** — Describing significant achievements as routine work
- **Name-dropping without substance** — Mentioning people without explaining the collaboration
- **Future tense in backward-looking questions** — Questions about results are about what you DID, not what you plan to do
- **Proprietary details** — System internals, customer data, or security specifics that shouldn't be in a review
