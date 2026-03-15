# claude-code-starter

An opinionated Claude Code configuration built around one principle: **every line in your config should answer "would Claude do something wrong without this?"**

Most CLAUDE.md files tell Claude how to think. This one tells Claude what to know — safety constraints, tech stack rules, project context, and trigger-based loading so domain knowledge appears exactly when needed.

## What's Different

| Pattern | What It Does |
|---|---|
| **Safety-first rules** | Hard constraints (`trash` over `rm`, no lint suppression, fail-fast) that fire before any action |
| **Self-improvement loop** | `lessons.md` captures mistakes with structured entries that graduate into CLAUDE.md rules |
| **Trigger-based loading** | Architecture docs load only when relevant keywords appear — scales to large codebases |
| **Codex orchestration** | `AGENTS.md` files give headless agents project-specific rules for parallel dispatch |
| **Cross-project memory** | `MEMORY.md` indexes project build commands, tech stacks, and pointers in one place |
| **Commit skill** | File-based commit messages that avoid shell escaping issues |

## Quick Start

```bash
# Clone the repo
git clone https://github.com/Babayosa/claude-code-starter.git
cd claude-code-starter

# Run the install script
./install.sh
```

The install script copies templates to the right locations. It won't overwrite existing files — you'll be prompted before any replacement.

After install:
1. Edit `~/CLAUDE.md` — replace the tech stack section with your languages/frameworks
2. Edit `~/.claude/projects/*/memory/MEMORY.md` — fill in your project table
3. Create project-level `CLAUDE.md` files using the template

## File Guide

```
templates/
  CLAUDE.md              # Global rules — copy to ~/CLAUDE.md
  project-CLAUDE.md      # Per-project rules — copy to <project>/CLAUDE.md
  AGENTS.md              # Codex agent rules — copy to <project>/AGENTS.md
  MEMORY.md              # Memory index — copy to ~/.claude/projects/*/memory/
  lessons.md             # Lessons template — copy to <project>/tasks/lessons.md
skills/
  commit/SKILL.md        # Git commit skill with safe temp-file workflow
hooks/
  safety-hook.sh         # Blocks rm, lint suppression, and hook-skipping
install.sh               # Copies everything to the right places
```

## The System

### 1. Safety Rules (always loaded)

Your `~/CLAUDE.md` is always in context. Safety rules go here so they fire before any action:

```markdown
- NEVER use `rm`. Always use `trash`.
- NEVER add lint suppression comments. Fix the actual issue.
- NEVER skip hooks (`--no-verify`). Fix the underlying issue.
```

### 2. Self-Improvement Loop

When Claude makes a mistake or you correct it, the lesson gets captured in `tasks/lessons.md`:

```
Mistake → Root cause → Rule → Example
```

Once a pattern is proven, it **graduates** — a one-liner rule gets added to the project's `CLAUDE.md`, and the lesson entry is marked `[Graduated]`. This way your config gets smarter over time without growing unbounded.

### 3. Trigger-Based Loading

Instead of stuffing everything into `CLAUDE.md`, point to docs that load on demand:

```markdown
## Trigger Rules
- **iOS app submission** → read `memory/ios-launch-checklist.md`
- **Database migrations** → read `docs/migration-guide.md`
- **API design** → read `docs/api-conventions.md`
```

Claude reads the relevant doc before starting work. Your main config stays small, and domain knowledge scales with your project.

### 4. Codex Orchestration

For headless agent dispatch (Codex, background agents), each project gets an `AGENTS.md` that combines:
- Build/test commands
- Architecture rules from the project CLAUDE.md
- Validation requirements and failure protocol

Agents get injected with `AGENTS.md` as `developer-instructions`, so they follow project conventions without access to your global config.

### 5. Cross-Project Memory

`MEMORY.md` is an index file that points to individual memory files:

```markdown
## Projects
| Name | Path | Build | Test |
|------|------|-------|------|
| myapp | ~/myapp | `npm run build` | `npm test` |
```

Memory files store user preferences, project context, and reference pointers. The index stays under 80 lines; details live in individual files.

## Customizing

**Tech stack** — Replace the `Cross-Project Tech Stack` section in `~/CLAUDE.md` with your own. Examples:

<details>
<summary>TypeScript / React</summary>

```markdown
### TypeScript (all projects)
- Strict mode, no `any` unless explicitly justified
- Functional components, hooks only (no class components)
- `zod` for runtime validation at system boundaries
- `react-query` for server state, `zustand` for client state

### Package Management
- `pnpm` exclusively. No `npm` or `yarn`.
- Pin exact versions in `package.json`
```
</details>

<details>
<summary>Python</summary>

```markdown
### Python (all projects)
- Type hints on all function signatures
- `ruff` for linting and formatting
- `pytest` for testing, `pytest-cov` for coverage
- `pydantic` for data validation
- `uv` for package management

### Project Structure
- `src/` layout with `pyproject.toml`
- No `setup.py` or `requirements.txt`
```
</details>

<details>
<summary>Go</summary>

```markdown
### Go (all projects)
- `golangci-lint` with default config
- Table-driven tests, `testify` for assertions
- Interface-first design, accept interfaces return structs
- `context.Context` as first parameter on all public functions
- No `init()` functions. Explicit initialization only.
```
</details>

**Trigger rules** — Add your own domain docs. Any markdown file works.

**Safety rules** — Add constraints specific to your environment. If you have a footgun, put a rule against it.

## License

MIT
