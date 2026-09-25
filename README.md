# PRAGMA

A security-first Solidity project foundation designed for auditable, reproducible smart-contract development.

> **Status:** Early-stage repository foundation. No production contract behavior is claimed yet.

## Goals

- Keep Solidity builds reproducible and compiler versions explicit.
- Make security review and testing part of the normal development workflow.
- Keep production deployments separate from local development and tests.
- Prefer small, reviewable, test-backed changes.
- Document assumptions and security-sensitive decisions.

## Development

This repository uses [Foundry](https://book.getfoundry.sh/) for compilation, testing, formatting, and static checks.

### Prerequisites

- Foundry
- Git

### Verify locally

```bash
forge --version
forge fmt --check
forge build
forge test -vvv
```

## Security model

This project is intended to evolve with security controls from the beginning. Before production deployment, contract-specific threat modeling, invariant tests, access-control review, dependency review, and an independent security assessment should be completed.

See [SECURITY.md](SECURITY.md) for the vulnerability-reporting policy.

## Quality gates

Pull requests should pass:

1. Solidity formatting
2. Compilation with the pinned compiler
3. Unit tests
4. Static analysis where configured
5. No committed secrets or deployment credentials
6. Documentation updates for security-sensitive behavior

## Repository structure

```text
.
├── .github/workflows/ci.yml
├── src/                 # Solidity contracts
├── test/                # Unit and invariant tests
├── script/              # Deployment/maintenance scripts
├── SECURITY.md
├── CONTRIBUTING.md
├── foundry.toml
└── README.md
```

## License

License terms will be defined before production distribution.
