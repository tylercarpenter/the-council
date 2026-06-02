# The Council

**NOTE:** These are my personal sub-agents and workflows for personal and professional software development. I'm consistently fine-tuning and modifying this system and it not yet a proven implementation. That being said, it's getting better as time goes on and is quite fun to tweak!

<img width="1200" height="675" alt="image" src="https://github.com/user-attachments/assets/2b36013c-f577-448f-b32c-8349b412bc11" />


A **human-in-the-loop multi-agent system for [Claude Code](https://claude.com/claude-code)**,
built entirely on native `.claude/` primitives — no framework, no Python, no
infrastructure beyond your Anthropic subscription.

Six specialized agents coordinate on complex tasks. You — the **Jedi Master** —
approve every meaningful decision. The whole point is that there are **no black
boxes**: every agent reports what it did, and nothing irreversible happens without
your explicit `y`.

```
/council write a changelog from the last 10 commits
```

```
╔══════════════════════════════╗
║   COUNCIL MISSION BRIEF      ║
╚══════════════════════════════╝

Mission: Generate a changelog from recent git history.

Steps:
  1 → [archivist]  Read git log for the last 10 commits
  2 → [sentinel]   Group commits into Added / Changed / Fixed
  3 → [artificer]  Draft the CHANGELOG.md entry
  4 → [watchman]   Review for accuracy and completeness

Side effects requiring your approval:
  ⚠ Writing CHANGELOG.md

Awaiting your command, Master. (y / redirect / abort)
```

## Why this exists

The Council was assembled to build an agentic framework that works for me.

The goal is to increase productivity by allowing agents take the reigns 
on doing trivial work, while keeping me in the loop for difficult technical 
and design decisions. 

## The council

| Role | Model | Owns |
|---|---|---|
| **Jedi Master** (you) | — | Intent, gates, all irreversible actions |
| **Grand Master** | Opus 4.8 | Orchestration, routing, synthesis |
| **Jedi Archivist** | Haiku 4.5 | Research, search — *read-only* |
| **Jedi Artificer** | Sonnet 4.6 | Code, files, tests, builds |
| **Jedi Sentinel** | Sonnet 4.6 | Planning, task breakdown |
| **Jedi Diplomat** | Haiku 4.5 | Drafts, messages — *draft-then-approve* |
| **Jedi Watchman** | Sonnet 4.6 | Quality review — *veto power* |

Tool lockdowns are enforced, not suggested: the Archivist and Watchman cannot write
files; the Diplomat cannot send without an approved command.

## The three laws

1. **Human gates all irreversible actions** — no file writes, git ops, API calls, or
   message sends without explicit approval on the exact action.
2. **No black boxes** — every agent returns a structured report; every decision is
   explained.
3. **Watchman has veto power** — a REJECTED verdict blocks delivery. The producing
   agent fixes and resubmits; you never receive failed output.

## Install

```bash
git clone https://github.com/tylercarpenter/the-council
cd the-council
make install        # installs to ~/.claude by default
```

Install into a specific project instead:

```bash
make install DEST=/path/to/your/project/.claude
```

Other targets:

| Target | What it does |
|---|---|
| `make preview` | Show exactly what would be copied where (no changes) |
| `make install` | Copy agents, command, and skill into the target `.claude/` |
| `make uninstall` | Remove the installed council files |
| `make check` | Verify the install is present and complete |

## Usage

```bash
cd your-repo
claude
```

```
/council plan the auth module refactor
/council review the PR diff in pr-123.diff and draft a description
/council run the changelog workflow for the last 10 commits
```

Or summon a single agent when you only need one:

```
use the jedi-archivist to find every call site of getUser()
```

See [`workflows/`](workflows/) for ready-to-run example missions (changelog, issue
triage, code review) and a guide to writing your own.

## Customizing the council

**The Star Wars names are cosmetic.** To use neutral names in a professional context,
rename the agent files and update the `name:` field in each one's frontmatter —
nothing else needs to change. (Also update the references in `CLAUDE.md` and
`.claude/skills/council/SKILL.md` so routing still resolves.)

**`CLAUDE.md` is a template.** Copy it to your own project's root and edit the
*Conventions* section to match your real stack before your first `/council` run.

**Models are defaults, not hard locks.** Change the `model:` field in any agent file,
or override mid-session ("use Opus for this one"). When an agent struggles, raise its
effort before switching models — see the escalation ladder in `SKILL.md`.

## How it's structured

```
the-council/
├── CLAUDE.md                  always-on ambient context (lean, template)
├── CONTEXT.md                 design rationale + open work
├── workflows/                 ready-to-run example missions
└── .claude/
    ├── agents/                the six council members
    ├── commands/council.md    the /council slash command
    └── skills/council/        the full mission protocol playbook
```

Want the full design rationale — why `.claude/agents/` over LangGraph, why the
Watchman has veto, the model-assignment reasoning? Read [`CONTEXT.md`](CONTEXT.md).

## License

MIT — see [LICENSE](LICENSE).
