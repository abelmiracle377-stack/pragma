# Contributing

## Workflow

1. Create a focused branch from `main`.
2. Make one logical change at a time.
3. Add or update tests for behavioral changes.
4. Run formatting, build, and tests locally.
5. Update documentation when interfaces or security assumptions change.
6. Open a pull request with a clear description of the risk and validation performed.

## Local checks

```bash
forge fmt --check
forge build
forge test -vvv
```

## Pull requests

A good pull request should explain:

- what changed
- why it changed
- security implications
- tests added or updated
- any known limitations or follow-up work

Avoid unrelated refactors in security-sensitive changes.
