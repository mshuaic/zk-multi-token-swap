pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/bitify.circom";
include "./ForbidDuplicates.circom";
include "./MerkleRootCalculator.circom";
include "./Signature.circom";

template Swapper(inputCount,treeDepth) {
	signal input rootHash; // root hash of the merkle tree input[0]

	signal input shieldedPrivateKey; // shielded private key of the sender

	signal input inAmounts[inputCount]; // should be zero when depositing
	signal input inErc20TokenAddress; // input[1]
	signal input inBlindings[inputCount]; // blinding used to hide amount, and make depositing same amounts possible
	signal input inNullifiers[inputCount]; // input[2], input[3]
	signal input inCommitmentSiblings[inputCount][treeDepth];
	signal input inCommitmentSiblingSides[inputCount][treeDepth]; // left = 0, right = 1

	signal input outAmount;
	signal input outBlinding; // output blinding;
	signal input inSwapAmount; // input[4]
	signal input outSwapAmount; // input[5]
	signal input outErc20TokenAddress; // input[6]
	signal input outSwapBlinding;
	signal input outCommitments[2];

	signal input rootHashAccessToken; // input[7]
	signal input accessTokenSiblings[treeDepth];
	signal input accessTokenSiblingSides[treeDepth];

 	signal input fee; // fee of the pool

    signal input relay; // input[8]
	signal input relayFee; // input[9]

	// calculate public key of the sender;
	component publicKeyCalculator = Poseidon(1);
	publicKeyCalculator.inputs[0] <== shieldedPrivateKey;
	signal publicKey <== publicKeyCalculator.out;

	component calcCommitment[inputCount];
	component calcSignature[inputCount];
	component calcNullifier[inputCount];
	component calcTransactionRootHash[inputCount];
	component calcEqual[inputCount];

	var inTotal = 0;

	for (var i = 0; i < inputCount; i++) {
		// 1) Calculating Commitments for Input UTXO
		calcCommitment[i] = Poseidon(4);
		calcCommitment[i].inputs[0] <== inAmounts[i];
		calcCommitment[i].inputs[1] <== inErc20TokenAddress;
		calcCommitment[i].inputs[2] <== publicKey; // since public key is derived from private, ownership of comitment is prooved
		calcCommitment[i].inputs[3] <== inBlindings[i];

		// 2) Calculating Signature for Nullifier:
		// signature is included in nullifier in order for only owner to know hash it nullifies
		calcSignature[i] = Signature();
		calcSignature[i].shieldedPrivateKey <== shieldedPrivateKey;
		calcSignature[i].commitment <== calcCommitment[i].out;

		// 3) Calculating Nullifier from commitment and signature
		calcNullifier[i] = Poseidon(2);
		calcNullifier[i].inputs[0] <== calcCommitment[i].out;
		calcNullifier[i].inputs[1] <== calcSignature[i].out;

		// 4) Checking that nullifier is legit
		inNullifiers[i] === calcNullifier[i].out;

		calcTransactionRootHash[i] = MerkleRootCalculator(treeDepth);
		calcTransactionRootHash[i].inCommitment <== calcCommitment[i].out;
		for (var j = 0; j < treeDepth; j++) {
			calcTransactionRootHash[i].commitmentSiblings[j] <== inCommitmentSiblings[i][j];
			calcTransactionRootHash[i].commitmentSiblingSides[j] <== inCommitmentSiblingSides[i][j];
		}

		calcEqual[i] = ForceEqualIfEnabled();
		calcEqual[i].in[0] <== calcTransactionRootHash[i].rootHash;
		calcEqual[i].in[1] <== rootHashHinkal;
		calcEqual[i].enabled <== inAmounts[i];
		inTotal += inAmounts[i];
	}

	component calcOutCommitment[2];
	component calcOutBits[2];

	calcOutCommitment[0] = Poseidon(4);
	calcOutCommitment[0].inputs[0] <== outAmount; // if outAmount is negative, than this line will throw error
	calcOutCommitment[0].inputs[1] <== inErc20TokenAddress;
	calcOutCommitment[0].inputs[2] <== publicKey;
	calcOutCommitment[0].inputs[3] <== outBlinding;

	// Checking that output commitment is legit
	calcOutCommitment[0].out === outCommitments[0];

	calcOutBits[0] = Num2Bits(128);
	calcOutBits[0].in <== outAmount; // this will check if outAmounts[i] fits into 128 bits, this will also check that output amounts aren't negative

	calcOutCommitment[1] = Poseidon(4);
	calcOutCommitment[1].inputs[0] <== outSwapAmount; // if outAmount is negative, than this line will throw error
	calcOutCommitment[1].inputs[1] <== outErc20TokenAddress;
	calcOutCommitment[1].inputs[2] <== publicKey;
	calcOutCommitment[1].inputs[3] <== outSwapBlinding;

	// Checking that output commitment is legit
	calcOutCommitment[1].out === outCommitments[1];

	calcOutBits[1] = Num2Bits(128);
	calcOutBits[1].in <== outSwapAmount;

	// Final double spending prevention constraint
	inTotal === outAmount + inSwapAmount;

	component calcAccessToken = Poseidon(2);
	calcAccessToken.inputs[0] <== shieldedPrivateKey;
	calcAccessToken.inputs[1] <== publicKey;

	component calcAccessRootHash = MerkleRootCalculator(treeDepth);
	calcAccessRootHash.inCommitment <== calcAccessToken.out;

	for (var i = 0; i < treeDepth; i++) {
		calcAccessRootHash.commitmentSiblings[i] <== accessTokenSiblings[i];
		calcAccessRootHash.commitmentSiblingSides[i] <== accessTokenSiblingSides[i];
	}

	calcAccessRootHash.rootHash === rootHashAccessToken;
}
