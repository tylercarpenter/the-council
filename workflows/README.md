# Workflows

Ready-to-run example missions that demonstrate the full council pipeline end to end.
Each one is a recipe you can paste after `/council`, or hand to the Grand Master
directly.

| Workflow | What it does | Side effects gated |
|---|---|---|
| [changelog.md](changelog.md) | Turn git history into a changelog entry | Writing `CHANGELOG.md` |
| [issue-triage.md](issue-triage.md) | Triage open GitHub issues | Posting issue comments |
| [code-review.md](code-review.md) | Review a diff / PR | Posting the PR review |

## How to run one

```
/council run the changelog workflow for the last 10 commits
```

The Grand Master reads the workflow, produces a mission brief, and waits for your
approval before any step runs. Every file write or external send stops at a gate.

## How to write your own

A workflow is just a markdown file describing a repeatable mission. Keep this shape:

1. **Goal** — one line.
2. **Inputs** — what the user provides (a commit range, a PR number, a diff file).
3. **Pipeline** — the ordered steps, each assigned to a council agent.
4. **Gates** — every side effect that needs human approval, called out explicitly.
5. **Output** — what the Jedi Master ends up with.

Drop the file in this directory and reference it by name in a `/council` mission.
As you build real missions, feed the patterns that work back into this folder — the
goal is for `workflows/` to grow into a playbook, not stay a demo.
