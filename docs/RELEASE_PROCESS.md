# Release Process

1. Update tests and documentation.
2. Run `make check`.
3. Run the security workflow locally where possible.
4. Review privileged functions and deployment configuration.
5. Record the compiler/toolchain versions.
6. Deploy to a testnet using a dedicated deployer.
7. Verify the contract source.
8. Record the deployed address and network in release notes.
9. Tag the reviewed commit.
10. For mainnet, complete an independent audit and multisig/key-management review.
