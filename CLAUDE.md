# CLAUDE.md — Jedi Council

> **Template.** Copy this file to your own project's root and edit the *Conventions*
> section to match your actual stack before running `/council` for the first time.
> The roster below is the always-on reference; the full mission protocol lives in
> `.claude/skills/council/SKILL.md` and only loads when you invoke `/council`.

## What this is

A human-in-the-loop multi-agent system built entirely on Claude Code's native
`.claude/agents/`, `.claude/commands/`, and `.claude/skills/` primitives. No
framework, no infrastructure beyond your Anthropic subscription. Six specialized
agents coordinate on complex tasks; you (the Jedi Master) approve every meaningful
decision.

## The council roster

| Role | Agent file | Model | Owns |
|---|---|---|---|
| Jedi Master | You (human) | — | Intent, gates, all irreversible actions |
| Grand Master | `grand-master` | claude-opus-4-8 | Orchestration, routing, synthesis |
| Jedi Archivist | `jedi-archivist` | claude-haiku-4-5-20251001 | Research, search, read-only context |
| Jedi Artificer | `jedi-artificer` | claude-sonnet-4-6 | Code, files, tests, builds |
| Jedi Sentinel | `jedi-sentinel` | claude-sonnet-4-6 | Planning, task breakdown, mission tracking |
| Jedi Diplomat | `jedi-diplomat` | claude-haiku-4-5-20251001 | Drafts, messages, external comms |
| Jedi Watchman | `jedi-watchman` | claude-sonnet-4-6 | Quality review, veto power |

Invoke a coordinated mission with `/council <your task>`. Invoke a single agent
directly when you only need one (e.g. "use the jedi-archivist to find X").

## The three laws

1. **Human gates all irreversible actions** — no file writes, git ops, API calls, or
   message sends without explicit approval on the exact action.
2. **No black boxes** — every agent returns a structured report; every decision is
   explained.
3. **Watchman has veto power** — a REJECTED verdict blocks delivery.

## What the Jedi Master always handles personally

`git commit` · `git push` · `git merge` · merging/approving PRs · deploying to any
environment · approving any draft before it's sent · any architectural decision
spanning more than one module.

## Conventions (EDIT THIS for your project)

<!-- Replace the placeholders below with your real stack and rules. -->

- **Language / runtime:** <e.g. TypeScript 5, Node 20 / Python 3.12>
- **Package manager:** <e.g. pnpm / uv>
- **Test command:** <e.g. `pnpm test` / `pytest`>
- **Lint / format:** <e.g. `biome check` / `ruff`>
- **Style rules:** <e.g. no untyped functions; prefer composition over inheritance>
- **Anything an agent must never do:** <e.g. never touch `infra/` without approval>
