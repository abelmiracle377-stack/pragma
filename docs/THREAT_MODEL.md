# Threat Model

## Assets

- NFT ownership records
- token balances and approvals
- collection metadata URI
- collection mint authority
- owner/admin authority

## Threats and mitigations

| Threat | Mitigation |
|---|---|
| Unauthorized minting | `onlyOwner` |
| Unauthorized transfer | owner/approval/operator checks |
| Approval persistence after transfer | approval is cleared |
| Zero-address ownership | explicit address validation |
| Invalid token references | `ownerOf` existence check |
| Malicious safe-transfer recipient | ERC-721 receiver handshake |
| Metadata redirection | owner-controlled URI is documented as a trust boundary |
| Lost admin key | operational key management required before deployment |
| Reentrancy through receiver | state is updated before receiver callback |
| Secret leakage | credentials excluded from repository |

## Deployment assumptions

The contract is **not production-audited**. Before mainnet deployment, perform fuzz/invariant testing, static analysis, dependency review, key-management review and an independent audit.

## Known design tradeoffs

The current contract uses owner-controlled minting and base URI updates. This is intentionally simple for the first release. A production collection may require multisig administration, immutable metadata, supply limits, royalties, pausing, or a different mint authorization model.
