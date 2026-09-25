# PRAGMA

**PRAGMA** is a security-first Ethereum NFT engineering project built in Solidity with Foundry.

> **Status:** Research/development project. The contract is not represented as audited or production-deployed.

## What it demonstrates

- ERC-721-compatible NFT ownership and transfer flows
- ERC-165 interface detection
- owner-controlled sequential minting
- approvals and operator approvals
- safe NFT transfers
- burning
- metadata URI generation
- ownership administration
- custom Solidity errors
- unit and fuzz-oriented testing
- automated CI and static security analysis

## Architecture

See:
- [Architecture](docs/ARCHITECTURE.md)
- [Threat Model](docs/THREAT_MODEL.md)
- [Testing Strategy](docs/TESTING.md)
- [Security Policy](SECURITY.md)
- [Changelog](CHANGELOG.md)

## Quick start

Install Foundry, then:

```bash
forge install foundry-rs/forge-std --no-commit
forge fmt --check
forge build
forge test -vvv
```

Or use:

```bash
make check
```

## Metadata

The current contract constructs:

```
<baseURI><tokenId>.json
```

For production, content-addressed metadata such as IPFS should be reviewed and pinned before deployment.

## Deployment

A deployment script is provided in `script/Deploy.s.sol`. It reads deployment credentials and collection settings from environment variables. **Never commit a private key or RPC credential.**

Example:

```bash
export PRIVATE_KEY=...
export RPC_URL=...
export NFT_NAME="Pragma NFT"
export NFT_SYMBOL="PRAGMA"
export NFT_BASE_URI="ipfs://your-cid/"
forge script script/Deploy.s.sol --rpc-url "$RPC_URL" --broadcast
```

Use a dedicated deployment wallet and testnet first. Mainnet deployment requires a security review and operational key-management plan.

## Quality and security

Every change should be small, reproducible, and test-backed. CI performs formatting, compilation, tests, and static security analysis.

The current implementation intentionally does **not** include a public mint sale, royalties, upgradeability, marketplace integration, or production deployment.

## Repository layout

```text
src/                 Solidity contracts
test/                Unit and fuzz tests
script/              Deployment scripts
docs/                Architecture, threat model, testing
.github/workflows/   CI and security automation
foundry.toml         Reproducible compiler/build settings
Makefile             Local quality commands
SECURITY.md          Vulnerability policy
CHANGELOG.md         Release history
```

## License

MIT


## Web3 Dashboard

PRAGMA includes a GitHub Pages-ready NFT analytics dashboard with crypto-style charts, collection analytics, portfolio views, network statistics, market activity, and a demo mint interface.

**Dashboard:** `docs/index.html`  
**Source:** [GitHub repository](https://github.com/abelmiracle377-stack/pragma)

The dashboard uses clearly labeled illustrative NFT metrics. ETH price can be refreshed from CoinGecko when the browser permits the public API request. It does not submit blockchain transactions or expose private keys.
