# Workflow: Changelog from git history

**Goal:** Turn recent commits into a clean, human-readable changelog entry.

**Inputs:**
- Commit range or count (default: last 10 commits)
- Output target (default: a new entry at the top of `CHANGELOG.md`)

## Pipeline

1. **[jedi-archivist]** Read `git log` for the requested range. Collect commit
   subjects, bodies, and any referenced PR/issue numbers. Report them grouped by
   raw commit, with `commit_hash` sources.

2. **[jedi-sentinel]** Structure the commits into Keep-a-Changelog sections:
   **Added / Changed / Fixed / Removed / Deprecated / Security**. Drop noise
   (merge commits, formatting-only, `chore` with no user impact).

3. **[jedi-artificer]** Draft the changelog entry in the project's existing
   `CHANGELOG.md` format and version/date convention. If no `CHANGELOG.md` exists,
   propose a Keep-a-Changelog scaffold.

4. **[jedi-watchman]** Review for accuracy (does each line match a real commit?),
   completeness (anything user-facing missed?), and tone. Verdict required.

5. **[jedi-diplomat]** (optional) Reformat the approved entry for a GitHub Release
   body or a Slack announcement.

## Gates

```
⚠ GATE: jedi-artificer wants to write CHANGELOG.md
   Target: ./CHANGELOG.md
   Content: <the drafted entry>
   Approve? (y / n / edit)
```

No file is written until you approve. Publishing a GitHub Release or posting to
Slack is a separate gate handled by the Diplomat.

## Output

A reviewed changelog entry, written to `CHANGELOG.md` only after your approval —
plus, optionally, a release/Slack-formatted version you can send.
