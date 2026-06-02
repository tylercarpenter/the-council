# Workflow: Code review

**Goal:** Produce a thorough, honest review of a diff or PR — and post it only after
you approve.

**Inputs:**
- A diff (path to a `.diff` file, a PR number via `gh`, or `git diff` of the branch)
- Review focus (default: correctness, security, style, test coverage)

## Pipeline

1. **[jedi-archivist]** Read the diff and the surrounding code it touches. Establish
   context: what each changed function does, who calls it, what tests cover it.
   Report findings with `file_path:line` sources.

2. **[jedi-watchman]** Perform the full review — correctness, security, error
   handling, edge cases, test coverage, and style consistency with the codebase.
   Produce a verdict and a scored list of findings (blocking vs. nit).

3. **[jedi-artificer]** For each actionable finding, draft a concrete inline
   suggestion (the corrected code), so the review is fix-ready, not just critical.

4. **[jedi-diplomat]** Assemble the findings + suggestions into a single PR review
   comment in GitHub's format (summary + inline notes). Present the full draft.

## Gates

```
⚠ GATE: jedi-diplomat wants to post a PR review
   Target: PR #<n> on <repo>
   Content: <the full review body + inline suggestions>
   Approve? (y / n / edit)
```

Nothing is posted to GitHub until you approve. You may approve the summary but drop
specific inline notes.

## Output

A reviewed, fix-ready PR review — delivered to you for approval, then posted via
`gh pr review` only on your go-ahead.

## Note

This is the council's own dogfood loop: the Watchman that gates every other mission
is the same role doing the reviewing here.
