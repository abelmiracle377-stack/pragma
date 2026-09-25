# Security Policy

## Scope

This policy covers Solidity source code, tests, build configuration, deployment scripts, and repository automation.

## Reporting a vulnerability

Do **not** open a public issue for an undisclosed security vulnerability.

Use GitHub's private vulnerability reporting feature when available. If private reporting is unavailable, contact the repository owner through a private channel and provide:

- affected file and function
- affected commit or release
- vulnerability description
- reproduction steps or proof of concept
- potential impact
- suggested remediation, if known

Do not include private keys, seed phrases, API credentials, or other secrets in a report.

## Security expectations

Before a production deployment, maintainers should complete:

- threat modeling
- access-control review
- reentrancy and external-call review
- arithmetic and accounting review
- invariant/property testing
- dependency review
- deployment configuration review
- independent audit for material contracts

## Secret handling

Private keys, mnemonics, RPC credentials, API keys, and deployment secrets must never be committed to Git.

Use environment variables or a dedicated secret manager for local and CI deployments.

## Disclosure

Security issues should be coordinated privately until a fix or mitigation is available. Public disclosure should include the affected versions, impact, remediation, and any relevant migration guidance.
