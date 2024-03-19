import { expect } from "chai";
import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { MerkleTree } from "../shared/merkle-tree/MerkleTree";
// @ts-ignore
import { buildPoseidon } from "circomlibjs";
import * as snarkjs from "snarkjs";

const deployContract = async (
  contractName: string,
  constructorArgs: unknown[] = []
) => {
  const ContractFactory = await ethers.getContractFactory(contractName);
  return ContractFactory.deploy(...constructorArgs);
};

describe("test multi-token swap", () => {
  let poseidonHash: any;
  let poseidonFunction: any;
  const nContracts = 6;
  before(async () => {
    const poseidon = await buildPoseidon();
    poseidonHash = (...args: unknown[]) =>
      poseidon.F.toString(poseidon([...args]));

    poseidonFunction = (...args: any[]) =>
      BigInt(poseidon.F.toString(poseidon(args)));
  });

  function initializeArray(n: number, m: number) {
    const arr = [];
    for (let i = 0; i < n; i++) {
      const row = [];
      for (let j = 0; j < m; j++) {
        row.push(BigInt(Math.floor(Math.random() * 100)));
      }
      arr.push(row);
    }
    return arr;
  }

  // build inputs for the circuit
  async function buildInputs(
    inTokenCount: number,
    inputCount: number,
    outTokenCount: number,
    treeDepth: bigint,
    shieldedPrivateKey: bigint = 0n,
    inAmounts: bigint[][] = initializeArray(inTokenCount, inputCount),
    inErc20TokenAddresses: bigint[] = Array(inTokenCount).fill(0n),
    inBlindings: bigint[][] = Array(inTokenCount)
      .fill()
      .map(() => Array(inputCount).fill(0)),
    outAmounts: bigint[] = Array(inTokenCount).fill(0n),
    outBlindings: bigint[] = Array(inTokenCount).fill(0n),
    // swap all input tokens
    inSwapAmounts: bigint[] = inAmounts.map((e) =>
      e.reduce((a, b) => a + b, 0n)
    ),
    outErc20TokenAddresses = Array(outTokenCount).fill(0n),
    // generate random swap amounts
    outSwapAmounts: bigint[] = Array.from({ length: outTokenCount }, () =>
      BigInt(Math.floor(Math.random() * 100))
    ),
    outSwapBlindings: bigint[] = Array(outTokenCount).fill(0n)
  ) {
    const publicKey = poseidonHash(shieldedPrivateKey);
    const merkleTree = MerkleTree.create(poseidonFunction, treeDepth, 0n);

    const commitments: any = [];
    const inNullifiers: any = [];

    for (let i = 0; i < inTokenCount; i++) {
      commitments[i] = [];
      inNullifiers[i] = [];
      for (let j = 0; j < inputCount; j++) {
        commitments[i][j] = poseidonHash(
          inAmounts[i][j],
          inErc20TokenAddresses[i],
          publicKey,
          inBlindings[i][j]
        );
        const signature = poseidonHash(shieldedPrivateKey, commitments[i][j]);
        inNullifiers[i][j] = poseidonHash(commitments[i][j], signature);
        merkleTree.insert(
          commitments[i][j],
          merkleTree.getStartIndex() + BigInt(i * inputCount + j)
        );
      }
    }

    const inCommitmentSiblings: any = [];
    for (let i = 0; i < inTokenCount; i++) {
      inCommitmentSiblings[i] = [];
      for (let j = 0; j < inputCount; j++) {
        inCommitmentSiblings[i][j] = merkleTree
          .getSiblingHashesForVerification(commitments[i][j])
          .map((member: any) => member.toString());
      }
    }

    const inCommitmentSiblingSides: any = [];
    for (let i = 0; i < inTokenCount; i++) {
      inCommitmentSiblingSides[i] = [];
      for (let j = 0; j < inputCount; j++) {
        inCommitmentSiblingSides[i][j] = merkleTree
          .getSiblingSides(commitments[i][j])
          .map((e: any) => e.toString());
      }
    }

    const outCommitments: any = [];
    for (let i = 0; i < inTokenCount; i++) {
      // outAmount, inErc20TokenAddresses, publicKey, outBlinding
      outCommitments[i] = poseidonHash(
        outAmounts[i],
        inErc20TokenAddresses[i],
        publicKey,
        outBlindings[i]
      );
    }

    for (let i = inTokenCount; i < inTokenCount + outTokenCount; i++) {
      // outSwapAmounts, outErc20TokenAddresses, publicKey, outBlinding
      outCommitments[i] = poseidonHash(
        outSwapAmounts[i - inTokenCount],
        outErc20TokenAddresses[i - inTokenCount],
        publicKey,
        outBlindings[i - inTokenCount]
      );
    }

    const accessToken = poseidonHash(shieldedPrivateKey, publicKey);

    const inputs = {
      rootHash: merkleTree.getRootHash(),
      shieldedPrivateKey: shieldedPrivateKey,
      inAmounts: inAmounts,
      inErc20TokenAddresses: inErc20TokenAddresses,
      inBlindings: inBlindings,
      inNullifiers: inNullifiers,
      inCommitmentSiblings: inCommitmentSiblings,
      inCommitmentSiblingSides: inCommitmentSiblingSides,
      outAmounts: outAmounts,
      outBlindings: outBlindings,

      inSwapAmounts: inSwapAmounts,

      outErc20TokenAddresses: outErc20TokenAddresses,
      outSwapAmounts: outSwapAmounts,
      outSwapBlindings: outSwapBlindings,

      outCommitments: outCommitments,

      rootHashAccessToken: accessToken,
      accessTokenSiblings: Array(Number(treeDepth)).fill(0n),
      accessTokenSiblingSides: Array(Number(treeDepth)).fill(0n),

      fee: 0n,
      relay: 0n,
      relayFee: 0n,
    };

    const { proof, publicSignals } = await snarkjs.groth16.fullProve(
      inputs,
      `${__dirname}/circuits/swapperM.wasm`,
      `${__dirname}/circuits/swapperM_final.zkey`
    );

    let zkCallData = await snarkjs.groth16.exportSolidityCallData(
      proof,
      publicSignals
    );
    zkCallData = JSON.parse(`[${zkCallData}]`);

    return { inputs, zkCallData };
  }

  async function deployContractsFixture() {
    const [mark, alice, bob] = await ethers.getSigners();
    const verifier = await deployContract("Groth16SwapperM");
    const pool = await deployContract("MockOdosRouter", [verifier.address]);
    let USDCs = [];
    let USDTs = [];
    for (let i = 0; i < nContracts; i++) {
      USDCs.push(await deployContract("MockUSDC"));
      USDTs.push(await deployContract("MockUSDT"));

      // transfer all USDT to alice
      await USDTs[i].transfer(alice.address, USDTs[i].totalSupply());

      // transfer all USDC to pool
      await USDCs[i].transfer(pool.address, USDCs[i].totalSupply());
    }

    return { mark, alice, bob, pool, USDCs, USDTs, verifier };
  }

  describe("deployment", () => {
    it("pool should own all USDCs", async () => {
      const { pool, USDCs } = await loadFixture(deployContractsFixture);
      for (const usdc of USDCs) {
        const totalSupply = await usdc.totalSupply();
        const balance = await usdc.balanceOf(pool.address);
        expect(balance).to.equal(totalSupply);
      }
    });
    it("alice should own all USDTs", async () => {
      const { alice, USDTs } = await loadFixture(deployContractsFixture);

      for (const usdt of USDTs) {
        const totalSupply = await usdt.totalSupply();
        const balance = await usdt.balanceOf(alice.address);
        expect(balance).to.equal(totalSupply);
      }
    });
  });

  describe("vanilla swap", () => {
    it("alice swap 5 USDT to 3 USDC", async () => {
      const { alice, pool, USDCs, USDTs } = await loadFixture(
        deployContractsFixture
      );
      const inputs = [
        [USDTs[0].address, 3],
        [USDTs[1].address, 2],
      ];

      const outputs = [
        [USDCs[0].address, 2],
        [USDCs[1].address, 1],
      ];

      // alice approve USDTs to pool
      await USDTs[0].connect(alice).approve(pool.address, 3);
      await USDTs[1].connect(alice).approve(pool.address, 2);

      const beforeAliceUSDTBalance = BigInt(
        await USDTs[0].balanceOf(alice.address)
      );
      await pool.connect(alice).swap(inputs, outputs);

      expect(await USDTs[0].balanceOf(alice.address)).to.equal(
        beforeAliceUSDTBalance - 3n
      );
      expect(await USDTs[1].balanceOf(alice.address)).to.equal(
        beforeAliceUSDTBalance - 2n
      );
      expect(await USDCs[0].balanceOf(alice.address)).to.equal(2n);
      expect(await USDCs[1].balanceOf(alice.address)).to.equal(1n);
    });
  });

  describe("verify proof", () => {
    it("is valid", async () => {
      const { verifier, USDTs } = await loadFixture(deployContractsFixture);
      const inErc20TokenAddresses = USDTs.map((usdt) => BigInt(usdt.address));
      const { zkCallData } = await buildInputs(
        6,
        2,
        6,
        25n,
        0n,
        initializeArray(6, 2),
        inErc20TokenAddresses
      );

      expect(await verifier.verifyProof(...zkCallData)).to.equal(true);
    });
  });

  describe("zk swap", () => {
    it("is valid", async () => {
      const { mark, alice, pool, USDCs, USDTs } = await loadFixture(
        deployContractsFixture
      );
      // assume mark owns 1000 USDTs
      for (const usdt of USDTs) {
        await usdt.connect(alice).transfer(mark.address, 1000);
      }
      // Bob ownes some USDTs in pool
      // Bob wants to swap 5 USDTs to 3 USDCs
      // Mark acts as a relayer

      const bobPrivateKey = 0n;
      const inErc20TokenAddresses = USDTs.map((usdt) => BigInt(usdt.address));
      const outErc20TokenAddresses = USDCs.map((usdc) => BigInt(usdc.address));

      // the sum of inAmounts[i] should be equal to outAmounts[i](refund) + inSwapAmounts[i]
      const { zkCallData } = await buildInputs(
        6,
        2,
        6,
        25n,
        bobPrivateKey,
        // inAmounts
        [
          [5n, 2n],
          [1n, 1n],
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
        ],
        inErc20TokenAddresses,
        // inBlindings
        [
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
          [0n, 0n],
        ],
        // outAmounts
        [4n, 0n, 0n, 0n, 0n, 0n],
        // outBlindings
        [0n, 0n, 0n, 0n, 0n, 0n],
        // inSwapAmounts
        [3n, 2n, 0n, 0n, 0n, 0n],
        outErc20TokenAddresses,
        // outSwapAmounts
        [2n, 1n, 0n, 0n, 0n, 0n],
        // outSwapBlindings
        [0n, 0n, 0n, 0n, 0n, 0n]
      );

      const inTokens = [
        [USDTs[0].address, 3],
        [USDTs[1].address, 2],
      ];

      const outTokens = [
        [USDCs[0].address, 2],
        [USDCs[1].address, 1],
      ];

      // mark approve USDTs to pool
      for (const usdt of USDTs) {
        const balance = await usdt.balanceOf(mark.address);
        await usdt.connect(mark).approve(pool.address, balance);
      }

      await pool.connect(mark).zk_swap(inTokens, outTokens, ...zkCallData);

      expect(await USDTs[0].balanceOf(pool.address)).to.equal(3n);
      expect(await USDTs[1].balanceOf(pool.address)).to.equal(2n);

      expect(await USDCs[0].balanceOf(mark.address)).to.equal(2n);
      expect(await USDCs[1].balanceOf(mark.address)).to.equal(1n);
    });
  });
});
