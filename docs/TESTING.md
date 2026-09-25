# Testing Strategy

The project uses layered testing:

1. **Unit tests** for individual behaviors.
2. **Fuzz tests** for variable addresses and token flows.
3. **Invariant tests** for global accounting properties.
4. **CI checks** for formatting and compilation.
5. **Static analysis** through Slither in CI where the analyzer is available.

## Required commands

```bash
forge fmt --check
forge build
forge test -vvv
```

For deeper local review:

```bash
forge test --match-contract PragmaNFTTest -vvv
```

Tests should remain deterministic and should not depend on live RPC endpoints.
