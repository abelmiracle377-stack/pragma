# PRAGMA

A security-first Ethereum NFT project built in Solidity with Foundry.

> **Status:** Development/testnet-ready foundation. Review and audit before production deployment.

## NFT contract

`src/PragmaNFT.sol` implements an ERC-721-compatible NFT collection with:

- ERC-165 interface detection
- sequential token IDs
- owner-controlled minting
- transfers and safe transfers
- token approvals and operator approvals
- burning
- metadata `tokenURI`
- configurable base URI
- ownership transfer
- custom errors for gas-efficient failure paths
- zero-address and token-existence validation

### Current design

Minting is intentionally restricted to the contract owner. The initial implementation does **not** include a public mint price, royalties, upgradeability, marketplace logic, or automatic production deployment.

Metadata follows the pattern:

```text
<baseURI>/<tokenId>.json
```

For example, with `ipfs://collection/`, token 1 resolves to `ipfs://collection/1.json`.

## Development

This repository uses [Foundry](https://book.getfoundry.sh/) for compilation, testing, formatting, and static checks.

### Prerequisites

- Foundry
- Git

### Verify locally

```bash
forge install foundry-rs/forge-std --no-commit
forge fmt --check
forge build
forge test -vvv
```

## Security model

Before production deployment, complete:

- threat modeling
- access-control review
- reentrancy and external-call review
- invariant/fuzz testing
- metadata and URI integrity review
- dependency review
- deployment configuration review
- independent smart-contract audit

See [SECURITY.md](SECURITY.md) for vulnerability reporting.

## Repository structure

```text
.
├── src/PragmaNFT.sol
├── test/PragmaNFT.t.sol
├── script/                 # deployment scripts
├── .github/workflows/ci.yml
├── SECURITY.md
├── CONTRIBUTING.md
├── foundry.toml
└── README.md
```

## License

MIT
