---
name: pdp
description: "Manage a Personal Development Plan — create commitments, track progress, align to performance dimensions, and prepare for manager check-ins. Works with any company's performance framework."
userInvocable: true
---

# Personal Development Plan (PDP) Assistant

Help the user create, review, update, and maintain their Personal Development Plan. A PDP is a forward-looking career document that defines what you'll accomplish in the next review cycle and how you'll grow.

## Local Context

All PDP content and company-specific materials are stored locally — never in this plugin repository.

### Required files

```bash
cat ~/career-coach/pdp/current.md
```

This is the user's active PDP. If it doesn't exist, run the setup script to scaffold starter files:

```bash
bash {SKILL_DIR}/../../scripts/setup.sh
```

### Optional context files

Check for these and use them when available:

```bash
# Company-provided PDP template — adapt to this format
cat ~/career-coach/context/pdp-template.md

# Role expectations, career lattice, or level definitions
cat ~/career-coach/context/roles.md

# Projects, colleagues, org context — private reference material
cat ~/career-coach/context/projects.md

# Any other context the user has added
ls ~/career-coach/context/
```

The `~/career-coach/context/` directory is the user's private reference vault. Read everything in it to inform your coaching, but never suggest committing these files to any repository.

### Archive

Past PDPs are stored in `~/career-coach/pdp/archive/`. Reference them when the user asks about prior cycles or wants to show progression.

## Adapting to the User's Framework

Every company structures PDPs differently. Some use OKRs, some use commitments, some use goals with key results. The user's template (`context/pdp-template.md`) defines the structure — adapt to it.

If no template exists, use this general framework for each commitment:

1. **Performance Dimension** — Which area of growth this targets
2. **Focus / Change** — One sentence: what you're doing and why it matters
3. **Planned Experience** — Phased plan with concrete milestones
4. **Success Signals** — Observable evidence that the commitment was met
5. **Target Date** — When the full commitment completes
6. **Manager Support** — What you need from your manager to succeed
7. **Checkpoints** — Periodic status updates

If a template IS provided, map your coaching to its specific fields and terminology.

## Writing Principles

**Frame around skills and outcomes, not implementation details:**
- Good: "Deliver automated coverage across product areas, progressing from zero to continuous test suites running in CI"
- Bad: "Implement a recursive schema sanitizer for the provider boundary in the orchestration layer"

A PDP is a career document, not a technical design doc. Describe what you'll accomplish and what skills you'll apply, not how the code works.

**Show progression, not just completion:**
- Phase 1: Prove the approach works on one case
- Phase 2: Apply the proven approach to early targets
- Phase 3: Scale with increasing autonomy/efficiency
- Phase 4: The system works without you as the bottleneck

**Success signals should be verifiable:**
- Good: "At least 8 of 13 product areas with automated tests in CI by end of cycle"
- Bad: "Tests are better"

Someone other than you should be able to confirm whether the signal was met.

**Manager support should be specific and actionable:**
- Good: "Protect sprint time during the June wave when 6 deliverables overlap"
- Bad: "Help me when I need it"

### Dimension Alignment

If the user has role expectations or a career lattice (`context/roles.md`), use dimension weights to guide commitment priority:

- Higher-weighted dimensions at the target level deserve stronger commitments
- If targeting a promotion, note where weights shift between current and target level
- A commitment can span multiple dimensions but should have a primary alignment

## Checkpoint Updates

When updating checkpoints:

1. Read the current PDP
2. Add a new row to the checkpoint table for the relevant commitment
3. Status should be: On Track, At Risk, Blocked, or Complete
4. Notes should be brief but evidence-based — what shipped, what changed, what's next
5. If status changes, explain why

## Commands

- **"Review my PDP"** — Read current.md and context files, check alignment, flag gaps, suggest improvements
- **"Update checkpoint"** — Add a status update to one or more commitments
- **"Draft a new commitment"** — Walk through the commitment structure interactively, using the template if available
- **"Align to role"** — Compare commitments against roles.md dimension weights
- **"Prep for 1:1"** — Summarize current PDP status for a manager check-in
- **"Archive and start new cycle"** — Move current.md to archive/{cycle-name}.md, create new from template

## Anti-Patterns to Flag

- Commitments that describe activity instead of outcomes ("attend meetings" vs "ship coverage")
- Success signals that only you can verify ("I felt more confident")
- Missing manager support section (signals you haven't thought about dependencies)
- All commitments in one dimension (shows narrow focus, not growth)
- No phased plan (suggests a wish list, not a strategy)
- Technical implementation details that belong in a design doc, not a PDP
- Proprietary system details that shouldn't appear in a career document
