# [Project Name] — Lessons Learned

<!-- Organize by topic so "scan headers" works. Add new sections as needed.
     Entry format: Mistake → Root cause → Rule → Example
     When a lesson proves itself, graduate it: add a one-liner to CLAUDE.md,
     mark the entry [Graduated], and trim to rule-only. -->

## [Topic 1]

<!-- Example:
### Parameter removal requires checking ALL call sites
- **Mistake:** Removed `gradient` param from `Button` but missed call in `EmptyView.swift`
- **Root cause:** Grepped for the type but not all call sites
- **Rule:** Always grep for the parameter name across the entire project before removing
- **Example:** `Button(... gradient: ...)` was in EmptyView, not just the file being edited
-->

## [Topic 2]

## [Topic 3]
