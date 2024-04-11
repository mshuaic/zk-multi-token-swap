#  private ERC-20 tokens swap protocol

1. install circom and SnarkJS globally (https://docs.circom.io/getting-started/installation/)
2. installh [hardhat](https://hardhat.org/)

3. make circuits
   ```bash
   cd circom
   make
   ```

4. test
   ```bash
   npx hardhat test
   ```
It's important to note that this demo protocol is a key component of a larger, currently private project. The published repository features circom circuits and some mock Solidity smart contracts. These are designed to verify zero-knowledge proofs and facilitate private multi-token swaps, showcasing the core functionalities. However, it doesn't include certain features like Merkle tree root hash verification, KYC token checks, and a front-end interface.
