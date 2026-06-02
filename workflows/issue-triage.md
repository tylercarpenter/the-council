# Workflow: Issue triage

**Goal:** Triage open GitHub issues — prioritize, label, and draft responses —
without auto-posting anything.

**Inputs:**
- Repository (default: the current repo's `origin`)
- Filter (default: all open, untriaged issues)
- Requires the GitHub CLI (`gh`) authenticated, or the GitHub MCP server.

## Pipeline

1. **[jedi-archivist]** Pull open issues (`gh issue list` or GitHub MCP). For each,
   read title, body, and existing labels. Report a concise summary per issue with
   the issue number as source.

2. **[jedi-sentinel]** Prioritize by severity, effort, and dependencies. Produce a
   ranked table: `#issue → priority (P0–P3) → suggested labels → rationale`.

3. **[jedi-artificer]** For each issue, suggest labels and a likely owner based on
   codebase ownership (who last touched the relevant files). Flag duplicates and
   issues that are actually questions.

4. **[jedi-watchman]** Review the triage for anything miscategorized, mislabeled, or
   wrongly prioritized. Verdict required before anything is drafted.

5. **[jedi-diplomat]** Draft a short, friendly triage comment for each issue
   (acknowledgement + next step). Present all drafts; nothing is posted yet.

## Gates

```
⚠ GATE: jedi-diplomat wants to post triage comments
   Target: <N GitHub issues, listed by number>
   Content: <each drafted comment>
   Approve? (y / n / edit)   — you may approve a subset
```

Applying labels via `gh issue edit` is a separate gate. Nothing touches GitHub until
you approve the exact action.

## Output

A ranked triage table, suggested labels/owners per issue, and approved comments —
posted only after your explicit go-ahead.
