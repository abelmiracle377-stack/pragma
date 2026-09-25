# Architecture

## Components

### PragmaNFT

`src/PragmaNFT.sol` is the core NFT contract.

Responsibilities:
- maintain token ownership and balances
- authorize transfers
- mint sequential token IDs
- burn tokens
- expose ERC-721 metadata
- expose ERC-165 interface detection
- manage the collection owner and base metadata URI

### Metadata

The contract constructs token URIs as:

`baseURI + tokenId + ".json"`

Metadata should be immutable or content-addressed (for example, IPFS CIDs) before production deployment.

## Trust boundaries

1. **Collection owner** can mint and update the base URI.
2. **Token owners/operators** can transfer and burn tokens according to approval rules.
3. **External recipient contracts** are called during safe transfers.
4. **Off-chain metadata** is outside the Solidity contract's trust boundary.

## Security invariants

- The zero address never owns a live token.
- Every live token has exactly one owner.
- Balances equal the number of live tokens owned by each address.
- Total supply equals the number of live tokens.
- Token approvals are cleared after transfer and burn.
- Only the owner can mint or change the base URI.
- Burning reduces supply and removes ownership.
