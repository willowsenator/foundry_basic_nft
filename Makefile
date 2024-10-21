-include .env

.PHONY: deploy test clean install
all: clean remove install update build

# Clean the repo
clean:
	 forge clean

# Remove modules
remove: 
	rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install: 
	forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.9.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update: 
	forge update

build: 
	forge build

test: 
	forge test 

NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --account ANVIL_DEFAULT --broadcast

ifeq ($(findstring sepolia,$(ARGS)),sepolia)
    NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account SEPOLIA_ACCOUNT --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy: 
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT $(NETWORK_ARGS)

deploy_moodNFT:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT $(NETWORK_ARGS)

mint: 
	@forge script script/Interactions.s.sol:MintBasicNFT $(NETWORK_ARGS)

mint_moodNFT: 
	@forge script script/MintMoodNFT.s.sol:MintMoodNFT $(NETWORK_ARGS)

flip_moodNFT: 
	@forge script script/FlipMoodNFT.s.sol:FlipMoodNFT $(NETWORK_ARGS)