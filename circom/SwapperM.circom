pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/bitify.circom";
include "./MerkleRootCalculator.circom";
include "./Signature.circom";

// inTokenCount: number of token types
// inputCount: number of inputs per token type
// outTokenCount: number of token types
// treeDepth: depth of the merkle tree
template Swapper(inTokenCount,inputCount,outTokenCount,treeDepth) {
	signal input rootHash; // root hash of the merkle tree input[0]

	signal input shieldedPrivateKey; // shielded private key of the sender

  signal input inAmounts[inTokenCount][inputCount];
  signal input inErc20TokenAddresses[inTokenCount]; // zero address for ETH input[1:6]
  signal input inBlindings[inTokenCount][inputCount];  // blinding used to hide amount, and make depositing same amounts possible
  signal input inNullifiers[inTokenCount][inputCount]; // input[7:18]
  signal input inCommitmentSiblings[inTokenCount][inputCount][treeDepth];
  signal input inCommitmentSiblingSides[inTokenCount][inputCount][treeDepth]; // left = 0, right = 1

	signal input outAmounts[inTokenCount];
  signal input outBlindings[inTokenCount];
  signal input inSwapAmounts[inTokenCount]; // input[19:24]

  signal input outErc20TokenAddresses[outTokenCount]; // input[25:30]
	signal input outSwapAmounts[outTokenCount]; // input[31:36]
	signal input outSwapBlindings[outTokenCount];

  signal input outCommitments[inTokenCount+outTokenCount]; // input[37:48]

	signal input rootHashAccessToken; // input[49]
	signal input accessTokenSiblings[treeDepth];
	signal input accessTokenSiblingSides[treeDepth];

 	signal input fee; // fee of the pool input[50]
  signal input relay; // input[51]
	signal input relayFee; // input[52]

	// calculate public key of the sender;
	component publicKeyCalculator = Poseidon(1);
	publicKeyCalculator.inputs[0] <== shieldedPrivateKey;
	signal publicKey <== publicKeyCalculator.out;

	component calcCommitment[inTokenCount][inputCount];
	component calcSignature[inTokenCount][inputCount];
	component calcNullifier[inTokenCount][inputCount];
	component calcTransactionRootHash[inTokenCount][inputCount];
	component calcEqual[inTokenCount][inputCount];

  component calcOutCommitment[inTokenCount+outTokenCount];
  component calcOutBits[inTokenCount+outTokenCount];

	for (var i = 0; i < inTokenCount; i++) {
      // 0) iterate over all token types
      var inTotal = 0;

      for(var j=0; j< inputCount; j++) {
        // 1) Calculating Commitments for Input UTXOs
        calcCommitment[i][j] = Poseidon(4);
        calcCommitment[i][j].inputs[0] <== inAmounts[i][j];
        calcCommitment[i][j].inputs[1] <== inErc20TokenAddresses[i];
        calcCommitment[i][j].inputs[2] <== publicKey;
        calcCommitment[i][j].inputs[3] <== inBlindings[i][j];

        // log("commitment",i,j, calcCommitment[i][j].out);

        // 2) Calculating Signature for Nullifier:
        // signature is included in nullifier in order for only owner to know hash it nullifies
        calcSignature[i][j] = Signature();
        calcSignature[i][j].shieldedPrivateKey <== shieldedPrivateKey;
        calcSignature[i][j].commitment <== calcCommitment[i][j].out;


        // 3) Calculating Nullifier from commitment and signature
        calcNullifier[i][j] = Poseidon(2);
        calcNullifier[i][j].inputs[0] <== calcCommitment[i][j].out;
        calcNullifier[i][j].inputs[1] <== calcSignature[i][j].out;

        // 4) Checking that nullifier is legit
        // log("nullifier", i, j, calcNullifier[i][j].out);
        // log("inNullifier", i, j, inNullifiers[i][j]);
        inNullifiers[i][j] === calcNullifier[i][j].out;


        // 5) Calculating Transaction Root Hash
        calcTransactionRootHash[i][j] = MerkleRootCalculator(treeDepth);
        calcTransactionRootHash[i][j].inCommitment <== calcCommitment[i][j].out;
        for (var k = 0; k < treeDepth; k++) {
          calcTransactionRootHash[i][j].commitmentSiblings[k] <== inCommitmentSiblings[i][j][k];
          calcTransactionRootHash[i][j].commitmentSiblingSides[k] <== inCommitmentSiblingSides[i][j][k];
        }

        // log("roothash",i,j, calcTransactionRootHash[i][j].rootHash);
        // 6) Checking that transaction root hash is legit
        calcEqual[i][j] = ForceEqualIfEnabled();
        calcEqual[i][j].in[0] <== calcTransactionRootHash[i][j].rootHash;
        calcEqual[i][j].in[1] <== rootHash;
        calcEqual[i][j].enabled <== inAmounts[i][j];
        inTotal += inAmounts[i][j];
      }

      calcOutCommitment[i] = Poseidon(4);
      calcOutCommitment[i].inputs[0] <== outAmounts[i]; // if outAmount is negative, than this line will throw error
      calcOutCommitment[i].inputs[1] <== inErc20TokenAddresses[i];
      calcOutCommitment[i].inputs[2] <== publicKey;
      calcOutCommitment[i].inputs[3] <== outBlindings[i];

      // log("calcOutCommitment",i, calcOutCommitment[i].out);
      // log("outCommitments",i, outCommitments[i]);
      // Checking that output commitment is legit
      calcOutCommitment[i].out === outCommitments[i];

      calcOutBits[i] = Num2Bits(128);
      calcOutBits[i].in <== outAmounts[i]; // this will check if outAmounts[i] fits into 128 bits, this will also check that output amounts aren't negative

      // for each token type, the sum of refund and swapped amount should be equal to the sum of input amounts
      // log("inTotal", inTotal);
      // log("outAmounts[i]+inSwapAmounts[i]", outAmounts[i] + inSwapAmounts[i]);
      inTotal === outAmounts[i] + inSwapAmounts[i];
	}


  for(var i=inTokenCount; i<inTokenCount+outTokenCount; i++){
      calcOutCommitment[i] = Poseidon(4);
      calcOutCommitment[i].inputs[0] <== outSwapAmounts[i-inTokenCount]; // if outAmount is negative, than this line will throw error
      calcOutCommitment[i].inputs[1] <== outErc20TokenAddresses[i-inTokenCount];
      calcOutCommitment[i].inputs[2] <== publicKey;
      calcOutCommitment[i].inputs[3] <== outSwapBlindings[i-inTokenCount];

      // Checking that output commitment is legit
      // log("calcOutCommitment",i, calcOutCommitment[i].out);
      calcOutCommitment[i].out === outCommitments[i];

      calcOutBits[i] = Num2Bits(128);
      calcOutBits[i].in <== outSwapAmounts[i-inTokenCount];
  }

	component calcAccessToken = Poseidon(2);
	calcAccessToken.inputs[0] <== shieldedPrivateKey;
	calcAccessToken.inputs[1] <== publicKey;

	component calcAccessRootHash = MerkleRootCalculator(treeDepth);
	calcAccessRootHash.inCommitment <== calcAccessToken.out;

	for (var i = 0; i < treeDepth; i++) {
		calcAccessRootHash.commitmentSiblings[i] <== accessTokenSiblings[i];
		calcAccessRootHash.commitmentSiblingSides[i] <== accessTokenSiblingSides[i];
	}
  // log("access root hash", calcAccessRootHash.rootHash);
	calcAccessRootHash.rootHash === rootHashAccessToken;
}
