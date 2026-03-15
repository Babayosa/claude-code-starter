# Claude Code Rules

## Safety Rules

- NEVER use `rm`. Always use `trash` (or your OS equivalent).
- NEVER add lint suppression comments (`swiftlint:disable`, `eslint-disable`, `biome-ignore`, etc). Fix the actual issue.
- NEVER fabricate fallbacks, swallow errors, or weaken tests to pass. Fail fast.
- NEVER skip hooks (`--no-verify`, `--no-gpg-sign`). Fix the underlying issue.
- Before changing any method signature, grep ALL directories (source + tests) for call sites.

## Session Startup

At session start:
1. Read the current project's `CLAUDE.md` for project-specific conventions
2. Scan `tasks/lessons.md` **topic headers only** — read sections relevant to the current task
3. Check `tasks/todo.md` for in-progress work

## Workflow

### Plan First
- For ANY non-trivial task (3+ steps, multiple files, architectural decisions), plan before code.
- If something goes sideways, STOP and re-plan. Do not push forward blindly.
- Write detailed specs up front (inputs, outputs, constraints, acceptance criteria).

### Subagent Strategy
- Use subagents liberally. One subagent per focused task. Do not mix tasks.
- **Default model: Sonnet** — always use `model: "sonnet"` for subagents. Opus = orchestrator only.

### Self-Improvement Loop
- After ANY correction or bug: update `tasks/lessons.md` (Mistake → Root cause → Rule → Example).
- **Routing**: project-specific → `<project>/tasks/lessons.md`. Cross-project → `~/tasks/lessons.md`.
- **Graduation**: distill one-liner rules into the project's CLAUDE.md. Mark lesson `[Graduated]` and trim.

### Prompt Reframing
- Before non-trivial requests, silently reframe: replace vague terms, identify implicit requirements, infer acceptance criteria. Never show the rewrite.

### Bug Fix Protocol
- For non-trivial bugs: write a failing test (unit > integration > e2e) BEFORE the fix. Fix minimally. Confirm pass.

## Task Management + Definition of Done

For every task:
1. Write plan to `tasks/todo.md` as a checklist. Verify plan before implementing.
2. Track progress — mark items complete as you go.
3. Add "Review / Evidence" section with proof (test runs, outputs).
4. Update `tasks/lessons.md` after corrections or discoveries.

A task is DONE only when: checklist complete, verification evidence exists, lessons recorded.

## Cross-Project Tech Stack

<!-- Replace this section with your languages, frameworks, and conventions.
     Only include rules that Claude would get wrong without — not general best practices.
     Examples for TypeScript, Python, Go, and Swift are in the README. -->

### [Your Language]
- [Framework rule that Claude commonly gets wrong]
- [Pattern you always use but Claude wouldn't guess]
- [API/library gotcha that wastes time when missed]

## Trigger Rules

<!-- Point to docs that should load before working on specific areas.
     These keep CLAUDE.md small while scaling domain knowledge. -->

Load the relevant doc BEFORE starting work in these areas:

- **[Area 1]** → read `docs/[relevant-guide].md`
- **[Area 2]** → read `docs/[relevant-guide].md`

## Engineering Preferences

- **DRY** — flag repetition aggressively. Same logic in two places will diverge.
- **Well-tested** — rather too many tests than too few.
- **Engineered enough** — not fragile/hacky, not prematurely abstracted.
- **Edge cases** — handle more, not fewer. Thoughtfulness > speed.
- **Explicit over clever** — if a reader must pause to decode, it's too clever.

## Reasoning

- Always use extended thinking for all non-trivial tasks. Prefer deeper reasoning over faster responses.

## Core Principles

- **Simplicity First:** Minimal code. Minimal surface area.
- **No Laziness:** Fix root causes. No temporary fixes. Senior dev standards.
- **Minimal Impact:** Touch only what's necessary.
