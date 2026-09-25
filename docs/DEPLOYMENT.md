# Deployment

## Networks

The repository does not claim a mainnet deployment.

### Testnet procedure

1. Create a dedicated deployer wallet.
2. Fund it only with testnet ETH.
3. Configure `RPC_URL` and deployment environment variables locally.
4. Run the deployment script.
5. Record the deployment transaction and contract address.
6. Verify source code with the relevant block explorer.
7. Run post-deployment read-only checks.
8. Record the deployment in release notes.

## Required environment

```
PRIVATE_KEY
RPC_URL
NFT_NAME
NFT_SYMBOL
NFT_BASE_URI
NFT_MAX_SUPPLY
NFT_ROYALTY_BPS
```

Never commit these values.

## Production

Mainnet deployment requires independent security review, secure admin control, verified source, pinned build configuration, metadata availability, and incident procedures.
