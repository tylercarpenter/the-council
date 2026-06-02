# Jedi Council — Design Session Context

This file captures the decisions, rationale, and open work from the design session
that produced this repo. Read it once at the start of a Claude Code session to get
oriented without re-explaining everything.

## What this is

A human-in-the-loop multi-agent system built entirely on Claude Code's native
`.claude/agents/` and `.claude/commands/` primitives. No LangGraph, no Python
framework, no infrastructure beyond an Anthropic subscription. Six specialized
agents coordinate on complex tasks, with the developer (Jedi Master) approving every
meaningful decision.

The Star Wars naming is cosmetic and memorable — the architecture is the point.
Agents can be renamed for professional contexts without changing anything that
matters.

## Core philosophy (non-negotiable)

1. **Human gates all irreversible actions.** Any file write, git op, API call, or
   message send surfaces to the user for explicit y/n approval before executing.
   Hard-coded into the mission protocol in `SKILL.md`, not a guideline agents can
   reason around.

2. **No black boxes.** Every agent produces a structured report. Every delegation is
   logged. Every decision is explained. The developer can read the full trace in
   Claude Code's transcript and understand exactly what happened and why.

3. **Watchman veto is absolute.** A REJECTED verdict from the Jedi Watchman blocks
   delivery unconditionally. The producing agent fixes and resubmits. The user never
   receives output that failed its own quality gate.

## Architecture decisions and why

**Why `.claude/agents/` instead of LangGraph.** LangGraph was the original plan — it
gives typed state, explicit graph nodes, and Langfuse tracing. But `.claude/agents/`
is simpler, zero-infrastructure, and ships immediately. The agent files are readable
markdown that anyone can understand and modify. LangGraph is the graduation path if
the project outgrows this approach.

**Why a slash command + SKILL.md instead of everything in CLAUDE.md.** `CLAUDE.md` is
always-on ambient context — loaded on every session including quick one-line
questions. Putting the full mission protocol there wastes context budget. The
`/council` command only loads `SKILL.md` when explicitly invoked. `CLAUDE.md` stays
lean: just the agent roster and repo conventions.

**Why the Watchman has veto power.** Without a hard quality gate, the temptation is to
deliver output directly from the producing agent and let the user catch problems.
That reintroduces black-box behavior. The Watchman's veto forces quality to be
verified before it reaches the user — not after.

## Model assignments and rationale

| Agent | Model | Why |
|---|---|---|
| Grand Master | `claude-opus-4-8` | Orchestration needs the deepest reasoning — wrong routing wastes every subsequent call |
| Jedi Archivist | `claude-haiku-4-5-20251001` | Read-only, high volume, speed matters more than depth |
| Jedi Artificer | `claude-sonnet-4-6` | Built for coding + agents; extended thinking available for hard problems |
| Jedi Sentinel | `claude-sonnet-4-6` | Structured planning; doesn't need Opus-level depth for most breakdowns |
| Jedi Diplomat | `claude-haiku-4-5-20251001` | Drafting is low-complexity; upgrade to Sonnet for high-stakes comms |
| Jedi Watchman | `claude-sonnet-4-6` | Needs to catch subtle bugs and security issues — Haiku is not enough here |

**Effort escalation ladder before switching models:**

- Artificer on Sonnet stuck → effort `high` → effort `max` → escalate to Opus
- Archivist on Haiku stuck → effort `high` → escalate to Sonnet
- Never switch models silently — tell the user when escalating

## Productization context

The repo was designed with three paths to market in mind:

1. **Agency / services** — deploy the council for client projects, deliver outcomes.
   Fastest path to revenue. Recommended starting point.
2. **Developer tooling** — sell to developers building their own agentic systems. OSS
   core + paid cloud/managed version. Natural fit given the builder background.
3. **Vertical SaaS** — configure the council for one industry's painful workflows.
   Highest ceiling, slowest sales cycle.

Recommendation: use agency engagements to fund development and validate problems,
then productize the patterns that keep recurring.

## Honest critique from the design session

**Must fix (done in this build):**

- ✅ Note in `CLAUDE.md` that it's a template — copy to your project root and edit the
  conventions section.
- ✅ Note in `README.md` that the Star Wars names are cosmetic and agents can be
  renamed for professional contexts.
- ✅ `workflows/` directory with example missions.

**Nice to have (future):**

- `CONTRIBUTING.md` if the repo gets traction.
- Version the agent files so users can track changes between releases.
- Feed real workflow patterns back into the repo as a growing playbook.

## File map

```
the-council/
├── README.md                          public-facing docs
├── Makefile                           install / uninstall / check / preview
├── LICENSE                            MIT
├── CLAUDE.md                          always-on ambient context (lean, template)
├── CONTEXT.md                         this file
├── workflows/
│   ├── README.md                      how to write a workflow
│   ├── changelog.md                   changelog from git history
│   ├── issue-triage.md                triage open GitHub issues
│   └── code-review.md                 review a diff / PR
└── .claude/
    ├── agents/
    │   ├── grand-master.md            Opus 4.8 — orchestrator
    │   ├── jedi-archivist.md          Haiku 4.5 — researcher (read-only)
    │   ├── jedi-artificer.md          Sonnet 4.6 — coder
    │   ├── jedi-sentinel.md           Sonnet 4.6 — planner
    │   ├── jedi-diplomat.md           Haiku 4.5 — communicator (draft-then-approve)
    │   └── jedi-watchman.md           Sonnet 4.6 — critic (veto power)
    ├── commands/
    │   └── council.md                 /council slash command
    └── skills/
        └── council/
            └── SKILL.md               full mission protocol playbook
```
