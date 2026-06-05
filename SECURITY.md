# Security Policy

## Reporting a Vulnerability

Please report security vulnerabilities **privately** — do not open a public issue.

Use GitHub's private vulnerability reporting: open this repository's **Security**
tab and click **Report a vulnerability**. If that is unavailable, contact the
maintainer through their GitHub profile: https://github.com/Babayosa

When reporting, please include:
- A description of the vulnerability and its impact
- Steps to reproduce, or a proof of concept
- The affected version or commit

You can expect an initial response within a few days. Once a fix is ready, it
will be released on the latest `main`.

## Scope

This project ships shell scripts (an install script and a Bash safety hook) and
Markdown templates. The most security-relevant component is `hooks/safety-hook.sh`,
which is intended to *block* destructive commands — reports of bypasses or false
negatives in that hook are especially welcome.

## Supported Versions

This project is maintained on a best-effort basis. Security fixes are applied to
the latest `main`.
