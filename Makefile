.PHONY: fmt build test check

fmt:
	forge fmt

build:
	forge build

test:
	forge test -vvv

check:
	forge fmt --check
	forge build
	forge test
