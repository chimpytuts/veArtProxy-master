# VeArtProxy Project

## Overview

The **VeArtProxy** project is a Solidity smart contract designed to generate SVG-based metadata for Voting Escrow NFTs (veNFTs). It interacts with the `IVeSix` contract to fetch locking data, calculate multipliers, and create metadata and images in compliance with ERC-721 standards.

This repository includes a fully functional contract, deployment scripts, and a comprehensive suite of tests to ensure the correctness of the implementation.

---

## Features

- **Metadata Generation**:

  - Generates metadata in a JSON format compliant with ERC-721 standards.
  - Includes token attributes such as lock amount, multiplier, and lock expiration date.

- **SVG Rendering**:

  - Dynamically generates SVG images displaying token-specific details.

- **Error Handling**:

  - Validates token existence.
  - Ensures contract dependencies are properly initialized.

- **Gas Optimization**:
  - Efficient metadata and SVG generation to minimize gas consumption.

---

## Deployment

To deploy the `VeArtProxy` contract, use the provided deployment script.

### Prerequisites

- Install [Foundry](https://book.getfoundry.sh/getting-started/installation).
- Set up environment variables:
  - `PRIVATE_KEY`: Your wallet's private key.
  - `VE_SIX`: The address of the `IVeSix` contract.

### Deployment Steps

1. Clone the repository and navigate to the project folder.
2. Compile the contracts:
   ```bash
   forge build
   ```
3. Deploy using the deployment script:
   ```bash
   forge script script/DeployVeArtProxy.s.sol --rpc-url <RPC_URL> --broadcast --verify --etherscan-api-key <ETHERSCAN_API_KEY>
   ```
4. Verify the deployed contract on Etherscan (optional).

---

## Testing

This project includes a suite of tests written with Foundry to ensure correctness and reliability. The tests cover edge cases, date handling, and gas consumption.

### Running Tests

1. Install [Foundry](https://book.getfoundry.sh/getting-started/installation).
2. Run the test suite:
   ```bash
   forge test
   ```
3. View the test results, including gas usage and success rates.

---

## Test Cases

### Gas Usage

| Test Name                                       | Gas Usage                |
| ----------------------------------------------- | ------------------------ |
| `testGenerateStringData_EdgeCaseZeroMultiplier` | 33,974                   |
| `testGenerateStringData_ExpiredDate`            | 33,497                   |
| `testGenerateStringData_ValidDate`              | 43,958                   |
| `test_default_random_generation`                | 287,094                  |
| `test_generation_fuzz`                          | Avg: 307,386, ~: 308,251 |

### Test Descriptions

1. **`testGenerateStringData_EdgeCaseZeroMultiplier`**:

   - Verifies correct metadata generation for tokens with a zero multiplier.

2. **`testGenerateStringData_ExpiredDate`**:

   - Validates metadata generation for tokens with expired lock periods.

3. **`testGenerateStringData_ValidDate`**:

   - Ensures correct handling of tokens with valid lock expiration dates.

4. **`test_default_random_generation`**:

   - Tests the default generation path for token metadata and SVG rendering.

5. **`test_generation_fuzz(uint256, uint128, uint32, uint128)`**:
   - Fuzz test for metadata generation with randomized inputs to ensure stability and correctness.

---

## Usage

Once deployed, the `VeArtProxy` contract can be used to fetch token metadata by calling the `tokenURI` function with a valid token ID:

```solidity
string memory metadata = veArtProxy.tokenURI(tokenId);
```

---

## Serving Documentation

You can view the project documentation locally by running the following command:

```bash
forge doc --serve --port 4000
```
