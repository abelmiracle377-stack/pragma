.PHONY: fmt build test gas check security

fmt:
	forge fmt

build:
	forge build

test:
	forge test -vvv

gas:
	forge test --gas-report

security:
	slither . --exclude-dependencies

check:
	forge fmt --check
	forge build
	forge test -vvv
