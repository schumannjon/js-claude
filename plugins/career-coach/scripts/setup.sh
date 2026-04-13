#!/usr/bin/env bash
# setup.sh — Scaffold the ~/career-coach directory structure
# Run once to create directories and starter files.
# Safe to re-run — will not overwrite existing files.
#
# Usage: bash setup.sh

set -euo pipefail

COACH_DIR="${CAREER_COACH_DIR:-$HOME/career-coach}"

echo "=== Career Coach Setup ==="
echo "Directory: $COACH_DIR"
echo ""

# Create directory structure
mkdir -p "$COACH_DIR/pdp/archive"
mkdir -p "$COACH_DIR/self-review/archive"
mkdir -p "$COACH_DIR/context"

# --- PDP starter ---
if [ ! -f "$COACH_DIR/pdp/current.md" ]; then
    cat > "$COACH_DIR/pdp/current.md" << 'EOF'
# Personal Development Plan

**Owner:** [Your Name]
**Cycle:** [e.g., 2026-H1 (April – September)]
**Manager:** [Manager Name]
**Created:** [Date]
**Last Updated:** [Date]

---

## Commitment 1

**Performance Dimension:** [e.g., Results & Business Impact]

**Focus / Change:**
[One sentence: what you're doing and why it matters]

**Planned Experience:**
- **Phase 1 (Month 1-2):** [Prove the approach]
- **Phase 2 (Month 3-4):** [Apply and expand]
- **Phase 3 (Month 5-6):** [Scale and hand off]

**Success Signals:**
- [Observable, verifiable evidence]
- [Something someone else could confirm]

**Target Date:** [Date]

### Manager Support
- [Specific, actionable ask]

### Checkpoints

| Date | Status | Notes |
|------|--------|-------|

---

## Commitment 2

**Performance Dimension:** [e.g., Mastery & Craft]

**Focus / Change:**
[One sentence]

**Planned Experience:**
- **Phase 1:** [...]
- **Phase 2:** [...]
- **Phase 3:** [...]

**Success Signals:**
- [...]

**Target Date:** [Date]

### Manager Support
- [...]

### Checkpoints

| Date | Status | Notes |
|------|--------|-------|

---

## Commitment 3 (Optional)

**Performance Dimension:** [e.g., Amplifying Others]

**Focus / Change:**
[One sentence]

**Planned Experience:**
- [...]

**Success Signals:**
- [...]

**Target Date:** [Date]

### Manager Support
- [...]

### Checkpoints

| Date | Status | Notes |
|------|--------|-------|
EOF
    echo "[CREATED] pdp/current.md (starter template)"
else
    echo "[EXISTS]  pdp/current.md"
fi

# --- Self-review starter ---
if [ ! -f "$COACH_DIR/self-review/current.md" ]; then
    cat > "$COACH_DIR/self-review/current.md" << 'EOF'
# Self-Review

**Owner:** [Your Name]
**Review Cycle:** [e.g., R&D April 2026]
**Period:** [e.g., October 2025 – March 2026]
**Created:** [Date]
**Last Updated:** [Date]

---

<!--
  Replace the sections below with your company's actual self-review
  questions. If you have a template, copy it into:
    ~/career-coach/context/self-review-template.md
  and use /self-review to get coaching adapted to your format.
-->

## [Question 1 — e.g., Results and Impact]

**Prompt:** [Paste your company's question here]

**Response:**

[Your draft response]

---

## [Question 2 — e.g., Collaboration]

**Prompt:** [Paste your company's question here]

**Response:**

[Your draft response]

---

<!-- Add more sections as needed for your company's review format -->
EOF
    echo "[CREATED] self-review/current.md (starter template)"
else
    echo "[EXISTS]  self-review/current.md"
fi

# --- Context README ---
if [ ! -f "$COACH_DIR/context/README.md" ]; then
    cat > "$COACH_DIR/context/README.md" << 'EOF'
# Career Coach — Private Context

This directory holds company-specific and private reference material.
Files here are read by the career-coach skills but are NEVER committed
to any repository.

## Suggested files

| File | Purpose |
|------|---------|
| `pdp-template.md` | Your company's PDP template or format guide |
| `self-review-template.md` | Your company's self-review questions |
| `roles.md` | Career lattice, role expectations, or level definitions |
| `projects.md` | Project names, descriptions, key deliverables |
| `team.md` | Colleague names, roles, collaboration notes |

## How to populate

1. Copy your company's PDP template into `pdp-template.md`
2. Copy your company's self-review form into `self-review-template.md`
3. If your company publishes a career lattice, save it as `roles.md`
4. Add any other context that helps the coach give better advice

The coach reads all `.md` files in this directory automatically.
EOF
    echo "[CREATED] context/README.md (guide for adding context files)"
else
    echo "[EXISTS]  context/README.md"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit ~/career-coach/pdp/current.md with your actual PDP"
echo "  2. Edit ~/career-coach/self-review/current.md with your review questions"
echo "  3. Add company templates to ~/career-coach/context/"
echo "     - pdp-template.md (your company's PDP format)"
echo "     - self-review-template.md (your company's review questions)"
echo "     - roles.md (career lattice or role expectations)"
echo "  4. Run /pdp or /self-review in Claude Code"
