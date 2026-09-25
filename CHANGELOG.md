# Changelog

## Unreleased

### Added
- ERC-721-compatible NFT implementation
- ERC-165 support
- owner-controlled sequential minting
- transfers, approvals and safe transfers
- token burning
- metadata URI support
- Foundry unit and fuzz tests
- security and architecture documentation
- CI quality gates

### Security
- custom errors for validation failures
- approval clearing on transfer and burn
- state update before external safe-transfer callback
- secret-safe repository configuration

## Release policy

A production release requires passing CI, documented security review, and a tagged version.
