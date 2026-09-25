# Gas Benchmarking

Gas usage is environment-dependent and should be measured with the exact compiler and Foundry version used for a release.

Run:

```bash
forge test --gas-report
```

Record the output for release candidates and compare it against the previous tagged release.

## Benchmark targets

- deployment
- mint
- transfer
- safe transfer
- approval
- operator approval
- burn
- ownership transfer
- base URI update

Gas numbers should be treated as measurements for a specific build, not universal guarantees.
